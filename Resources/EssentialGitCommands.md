# A Quick Guide to Essential Git Commands

Git is a powerful version control system that helps developers manage their code efficiently. This blog post covers essential Git commands that can be used as a quick reference.

## 1. Repository and Branch Management

### 1.1. Initializing and Cloning Repositories

- Initializes a new Git repository or reinitializes an existing one: `git init`
- Creates a local copy of a remote repository: `git clone <repository_URL>`

### 1.2. Managing Branches

- Fetches updates from the remote repository: `git fetch origin`
- Switches to a different branch or commit: `git checkout <branch_name>`
- Creates a new branch and switches to it: `git checkout -b <branch_name>`
- Lists all local branches: `git branch`
- Lists all remote branches: `git branch -r`
- Pushes a local branch to the remote repository: `git push origin <branch_name>`
- Pulls a specific branch from the remote repository: `git pull origin <branch_name>`
- Deletes a local branch: `git branch -d <branch_name>`
- Deletes a remote branch: `git push origin --delete <branch_name>`

## 2. Committing and Merging Changes

### 2.1. Staging and Committing Changes

- Stages changes to be committed: `git add <file>` or `git add .`
- Creates a new commit with a descriptive message: `git commit -m "Commit message"`

### 2.2. Merging Changes

- Merges changes from another branch into your current branch: `git merge <branch_name>`
- Pushes the updated main branch to the remote repository: `git push origin main`

## 3. Viewing Commit History and Changes

### 3.1. Exploring Commit History

- Displays the commit history of the currently checked-out branch: `git log`
- Displays a graphical representation of the commit history: `git log --graph --oneline --decorate`
- Shows commits made by a specific author: `git log --author="Author Name"`
- Displays the commit history within a specific date range: `git log --since="1 week ago" --until="yesterday"`
- Shows the changes introduced by each commit: `git log -p`
- Displays the commit history for a specific file, including commit ID, author, and date: `git log --pretty=format:"%h - %an, %ad : %s" -- path/to/your/file`
