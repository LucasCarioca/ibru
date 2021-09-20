.PHONY := all

beta: 
	bundle exec fastlane beta

snapshots:
	bundle exec fastlane snapshot

test:
	bundle exec fastlane test
	