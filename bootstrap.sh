# Installs sds/.files configuration on what is assumed to be a brand-new machine.
#
# Execute by running:
#
#   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/sds/.files/HEAD/bootstrap.sh)"

# Install Homebrew (which takes care of Xcode CLI tools, including git)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add Homebrew to the path temporarily (install script will make it permanent)
export PATH="/opt/homebrew/bin:$PATH"

# Clone repo. Use HTTPS since we don't have SSH set up yet
git clone https://github.com/sds/.files.git ~/.files

cd ~/.files

# Switch repo to use SSH going forward (we'll have SSH set up soon)
git remote update origin git@github.com:sds/.files

# Replace this script with the install script and execute it
exec ./install
