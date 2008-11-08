From: Len Brown <lenb@kernel.org>
Subject: video patches in ACPI test tree
Date: Sat, 08 Nov 2008 01:14:19 -0500
Message-ID: <1226124869-1878-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:50217 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbYKHGOb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 8 Nov 2008 01:14:31 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KA000NV94063NB2@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 08 Nov 2008 00:14:31 -0600 (CST)
Received: from localhost.localdomain (d975xbx2 [127.0.0.1])
	by localhost.localdomain (8.14.2/8.14.2) with ESMTP id mA86ETSM001922	for
 <linux-acpi@vger.kernel.org>; Sat, 08 Nov 2008 01:14:29 -0500
Received: (from lenb@localhost)	by localhost.localdomain (8.14.2/8.14.2/Submit)
 id mA86ETHV001920	for linux-acpi@vger.kernel.org; Sat,
 08 Nov 2008 01:14:29 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Here are the video patches as refreshed in the ACPI test branch.
(there are a couple of merge conflicts, since there are other
 patches in the acpi test tree that touch the same files)

I've tested my T61 (Intel Graphics, and thus IGD support)
and found that these patches do no harm.

in all cases, I load i915, video and thinkpad_acpi

2.6.27:
Brightness hotkeys display controls in X,
but have no actual effect on brightness
/sys/class/backlight/acpi_video0 has no effect
/sys/class/backlight/acpi_video1 works

2.6.28-rc3+:
Brightness hotkeys display controls in X,
and correctly control brightness
/sys/class/backlight/acpi_video0 works
/sys/class/backlight/acpi_video1 works

2.6.28-rc3+ with these patches:
same as 2.6.28-rc3+, except
/sys/class/backlight/acpi_video1 does not exist.

thanks,
-Len


