From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [GIT PULL] thinkpad-acpi sysfs support part 1
Date: Tue, 24 Apr 2007 11:48:11 -0300
Message-ID: <11774261003184-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:38989 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754099AbXDXOs1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Apr 2007 10:48:27 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

Len,

Please pull from:
git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git for-upstream/acpi-test

to receive the following patches *already* in acpi-test:
      ACPI: ibm-acpi: kill trailing whitespace
      ACPI: ibm-acpi: rename some identifiers
      ACPI: ibm-acpi: add header file
      ACPI: ibm-acpi: organize code
      ACPI: ibm-acpi: update copyright notice
      ACPI: ibm-acpi: update documentation
      ACPI: ibm-acpi: move driver to drivers/misc hierarchy
      ACPI: ibm-acpi: rename driver to thinkpad-acpi
      ACPI: thinkpad-acpi: cleanup Kconfig for thinkpad-acpi
      ACPI: thinkpad-acpi: add compatibility MODULE_ALIAS entry
      ACPI: thinkpad-acpi: cleanup after rename
      ACPI: thinkpad-acpi: update MAINTAINERS
      ACPI: thinkpad-acpi: rename register_ibmacpi_subdriver
      ACPI: thinkpad-acpi: rename one stray use of ibm-acpi in a comment
      ACPI: thinkpad-acpi: rename module glue
      ACPI: thinkpad-acpi: rename thinkpad constants
      ACPI: thinkpad-acpi: update fan firmware documentation
      ACPI: thinkpad-acpi: add debug mode
      ACPI: thinkpad-acpi: clean up probing and move init to subdrivers
      ACPI: thinkpad-acpi: add subdriver debug statements
      ACPI: thinkpad-acpi: uncouple subdriver init from ibms struct
      ACPI: thinkpad-acpi: improve thinkpad detection
      ACPI: thinkpad-acpi: use bitfields to hold subdriver flags
      ACPI: thinkpad-acpi: use bitfields for module flags
      ACPI: thinkpad-acpi: prepare for device model conversion
      ACPI: thinkpad-acpi: mark acpi helper functions __must_check
      ACPI: thinkpad-acpi: clean up hotkey subdriver
      ACPI: thinkpad-acpi: cleanup bluetooth and wan for sysfs conversion
      ACPI: thinkpad-acpi: cleanup video subdriver
      ACPI: thinkpad-acpi: clean up CMOS commands subdriver
      ACPI: thinkpad-acpi: cleanup thermal subdriver for sysfs conversion
      ACPI: thinkpad-acpi: improve fan watchdog messages

      (the above should not cause any probles if you already pulled
      from that branch, as I have not rebased the branch or modified
      any of the above patches)

and to receive the following *new* patches:

      ACPI: thinkpad-acpi: register with the device model
      ACPI: thinkpad-acpi: driver sysfs conversion
      ACPI: thinkpad-acpi: add infrastructure for the sysfs device attributes
      ACPI: thinkpad-acpi: protect fan and hotkey data structures
      ACPI: thinkpad-acpi: add sysfs support to the thermal subdriver
      ACPI: thinkpad-acpi: add sysfs support to fan subdriver
      ACPI: thinkpad-acpi: add a safety net for TPEC fan control mode
      ACPI: thinkpad-acpi: add sysfs support to the cmos command subdriver
      ACPI: thinkpad-acpi: update brightness sysfs interface support

This is the first part of the sysfs conversion work.  It uses standard
generic interfaces (hwmon and backlight classes) for the most part, so it
is not subject to much change later on.

I am still working on the rest of the interfaces.  Also, I am sure at lest
the thermal sysfs conversion can be further enhanced coding-wise to be less
wasteful of memory, but that can wait for a later patch.

Please merge for 2.6.22.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
