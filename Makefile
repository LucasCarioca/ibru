.PHONY := all

beta: 
	bundle exec fastlane beta

screenshots:
	bundle exec fastlane screenshots

test:
	bundle exec fastlane test
	