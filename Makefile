prefix ?= /usr/local
bindir = $(prefix)/bin

build:
	swift build --configuration release --triple arm64-apple-macosx -Xlinker -rpath -Xlinker $(shell /usr/bin/xcode-select -p)/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift-5.5/macosx
	swift build --configuration release --triple x86_64-apple-macosx -Xlinker -rpath -Xlinker $(shell /usr/bin/xcode-select -p)/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift-5.5/macosx
	lipo -create -output .build/ipatool .build/arm64-apple-macosx/release/ipatool .build/x86_64-apple-macosx/release/ipatool

install: build
	install -d "$(bindir)"
	install ".build/ipatool" "$(bindir)"

uninstall:
	rm -rf "$(bindir)/ipatool"

clean:
	rm -rf .build

.PHONY: build install uninstall clean
