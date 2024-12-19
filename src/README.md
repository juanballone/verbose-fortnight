### Running the Project

To start the project, follow these steps:

1. **Change to the `src` Directory:**
   Before running any commands, navigate to the `src` directory:
   ```bash
   cd src
   ```

2. **Install Dependencies:**
   Ensure you have installed all required dependencies by running:
   ```bash
   npm install
   ```

3. **Run the Project:**
   Start the application using the following command:
   ```bash
   npm start
   ```

   This will start the server and make the application accessible locally. By default, it listens on the configured port (e.g., `http://localhost:3000`).

4. **Verify the Application:**
   Open your web browser and navigate to the local server URL to verify the application is running correctly.


### Managing `package-lock.json`

The `package-lock.json` file should be included in the repository for the following reasons:

1. **Reproducibility:**
   Ensures that everyone working on the project installs the exact same dependency versions, avoiding issues caused by version mismatches.

2. **Security:**
   Locks the versions of dependencies and their sub-dependencies, reducing the risk of installing a vulnerable or incompatible version of a package.

3. **Performance:**
   Optimizes installation by skipping version resolution for dependencies when using `npm install`.

#### Best Practices:

- Commit the `package-lock.json` file after running `npm install`.
- Update the `package-lock.json` file whenever dependencies are added or updated, and commit the changes along with `package.json`.
- Avoid manually editing the `package-lock.json` file; let npm manage it.

By including and maintaining the `package-lock.json` file, you ensure a more reliable and secure development environment for all contributors.
