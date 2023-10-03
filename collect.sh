WD=$PWD
echo "Dropoff: $WD"
echo ""
echo "Collecting .zsh-config... "
sudo cp -R ~/.zshrc $WD && echo "+ DONE" || echo "- FAILED!"
sudo cp -R ~/.zsh_aliases $WD && echo "+ DONE" || echo "- FAILED!"

echo "Collecting nvim-config... "
sudo cp -R ~/.config/nvim $WD && echo "+ DONE" || echo "- FAILED!"

echo "Collecting tmux-config... "
sudo cp -R ~/.config/tmux $WD && echo "+ DONE" || echo "- FAILED!"

echo "Collecting alacritty-config... "
sudo cp -R ~/.config/alacritty $WD && echo "+ DONE" || echo "- FAILED!"

echo "Collecting awesome-config... "
sudo cp -R ~/.config/awesome $WD && echo "+ DONE" || echo "- FAILED!"

echo ""
echo "> Done Collecting!"
