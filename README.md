# Github Repo Starring (Swift)


## Personal Access Tokens

Most of the API interaction we've been doing so far has been authorized using client IDs and secrets, which lets API calls act on behalf of an **application**. For this lab, though, we're going to be starring and unstarring Github repositories, which only makes sense if done on behalf of a **user**. In a few days, we'll see how to do this with OAuth. But for now, we're going to use a *personal access token* from Github's website.

In the settings section of Github's website, go to "Personal access tokens" and then "Generate new token". Give the token some name (say, "FIS Labs" or something). You then need to specify the permissions you grant someone with this token. For this lab, granting just `public_repo` should be sufficient.

Once you click "Generate token", you'll see your personal access token one time and one time only. Be sure to copy it before leaving the page. We're going to store it in a file in our project.


## The Secrets File

Go ahead and bring in the `Secrets.swift` file from your Github Repo List lab. You're going to add one more constant to this file - the personal access token you just generated on Github. Remember to add `Secrets.swift` to your `.gitignore` file (if it's not already there) so that they aren't pushed up to Github!

## Goal

Bring in the code you've already written for your Github Repo List lab. You've already gotten the table view to display a list of repositories, so it's time to add some additional functionality to this app. We want to be able to tap on repos in the table view and have it star or unstar the repository appropriately, using Github's API. You can see the overview of the relevant API calls [here](https://developer.github.com/v3/activity/starring/).

## Instructions

  1. Create the method in `GithubAPIClient` called `checkIfRepositoryIsStarred(fullName: completion:)` that accepts a repo full name (e.g. `githubUser/repoName`) and checks to see if it is currently starred. The completion closure should take a boolean (true for starred, false otherwise). Checkout the [Github Documentation](https://developer.github.com/v3/activity/starring/#check-if-you-are-starring-a-repository) on how this works on the API side.
    - Keep in mind that since this action needs to know *which* user is doing the starring, it will have to be passed the access token. You can do that by adding an `access_token` parameter in the query string of the URL. The same is true for all the remaining API calls in this lab.
  2. Make a method in `GithubAPIClient` called `starRepository(fullName: completion:)` that stars a repository given its full name. Checkout the [Github Documentation](https://developer.github.com/v3/activity/starring/#star-a-repository). The completion closure should'nt return anything and shouldn't accept any parameters.
  3. Make a method in `GithubAPIClient` called `unstarRepository(fullName: completion:)` that unstars a repository given its full name. Checkout the [Github Documentation](https://developer.github.com/v3/activity/starring/#unstar-a-repository).
  4. Create a method in `ReposDataStore` called `toggleStarStatusForRepository(repository: completion:)` that, given a `GithubRepository` object, checks to see if it's starred or not and then either stars or unstars the repo. That is, it should toggle the star on a given repository. In the completion closure, there should be a `Bool` parameter called `starred` that is `true` if the repo was just starred, and `false` if it was just unstarred.
  5. Finally, when a cell in the table view is selected, it should call your `ReposDataStore` method to toggle the starred status and display a `UIAlertController` saying either "You just starred `REPO NAME`" or "You just unstarred `REPO NAME`". You should also set the `accessibilityLabel` of the presented alert controller to either "You just starred `REPO NAME`" or "You just unstarred `REPO NAME`" (depending on the action that just occurred).
  6. Verify that the starring worked. You should go to the Github page for any repository that you tap and see its star status. For example, if you tapped on `mojombo/grit`, go to `http://www.github.com/mojombo/grit` and check if it's starred or not. Tap the cell for that repo again and refresh the page for the repository in your browser. You should see the star status of the repository change!

