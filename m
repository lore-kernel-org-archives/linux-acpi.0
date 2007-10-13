From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [GIT PATCH v3] thinkpad-acpi changes for the merge window (part 2 and 3)
Date: Sat, 13 Oct 2007 17:22:49 -0300
Message-ID: <1192306979-26886-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:53045 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753123AbXJMUXH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 13 Oct 2007 16:23:07 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

Len,                                                                                                                                                  

Here is the second and third batches of thinkpad-acpi changes for the
merge window (target: 2.6.24).

I have taken into account the comments about the brightness levels, and
now I do the detection without touching _BCL, and allow the user to select
which kind of backlight interface he wants at runtime.  The default *is*
the ACPI generic backlight interface.

There are also a few fixes, and the third batch adds support for NVRAM
polling of hot keys, needed by older thinkpads.

Please merge this batch to acpi-test.  I have rebased the git tree to
linus' latest, since there was a change in mainline that touched
thinkpad-acpi (no conflicts, though).

As usual, the patch set is available at:
git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git for-upstream/acpi-test

Shortlog of the above branch:

Henrique de Moraes Holschuh (20):
  (already submitted)
      ACPI: thinkpad-acpi: make room for more features in tp_features bitfield
      ACPI: thinkpad-acpi: issue EV_SYNC after EV_SWITCH
      ACPI: thinkpad-acpi: add mutex-based locking to input device event send path
      ACPI: thinkpad-acpi: keep track of module state
      ACPI: thinkpad-acpi: check version of hot key firmware
      ACPI: thinkpad-acpi: dequeue all pending hot key events at once (v2.2)
      ACPI: thinkpad-acpi: fix regression on HKEY LID event handling
      ACPI: thinkpad-acpi: use a separate platform device for hwmon and name it (v2)
      ACPI: thinkpad-acpi: duplicate driver attributes to new hwmon pdrv
      ACPI: thinkpad-acpi: skip blanks before the data when parsing sysfs
  (new or modified)
      ACPI: thinkpad-acpi: support 16 levels of brightness (v3)
      ACPI: thinkpad-acpi: add brightness_force parameter
      ACPI: thinkpad-acpi: prefer standard ACPI backlight level control
      ACPI: thinkpad-acpi: bump up version to 0.17
      ACPI: thinkpad-acpi: allow for syscall restart in sysfs handlers
      ACPI: thinkpad-acpi: fix brightness_set error paths
      ACPI: thinkpad-acpi: refactor hotkey_get and hotkey_set
      ACPI: thinkpad-acpi: prepare for NVRAM polling support
      ACPI: thinkpad-acpi: add CMOS NVRAM polling for hot keys (v6)
      ACPI: thinkpad-acpi: bump up version to 0.18

Thanks.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

