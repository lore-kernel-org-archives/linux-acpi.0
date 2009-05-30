From: Len Brown <lenb@kernel.org>
Subject: [PATCH 56/65] ACPI: delete acpi.power_nocheck from
 kernel-parameters.txt
Date: Fri, 29 May 2009 21:42:34 -0400
Message-ID: <113b3a2b901573961509e81a28e9546cf9defef0.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:40281 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757299AbZE3BnE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:43:04 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF0059RORRUAT3@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:43:03 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index fd5cac0..ed3d8b9 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -229,14 +229,6 @@ and is between 256 and 4096 characters. It is defined in the file
 			to assume that this machine's pmtimer latches its value
 			and always returns good values.
 
- 	acpi.power_nocheck=	[HW,ACPI]
- 			Format: 1/0 enable/disable the check of power state.
- 			On some bogus BIOS the _PSC object/_STA object of
- 			power resource can't return the correct device power
- 			state. In such case it is unneccessary to check its
- 			power state again in power transition.
- 			1 : disable the power state check
-
 	acpi_sci=	[HW,ACPI] ACPI System Control Interrupt trigger mode
 			Format: { level | edge | high | low }
 
-- 
1.6.0.6

