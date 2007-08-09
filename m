From: Len Brown <len.brown@intel.com>
Subject: [PATCH 2/6] ACPI: thermal: expose "thermal.tzp="
Date: Thu,  9 Aug 2007 01:58:52 -0400
Message-ID: <11866391381018-git-send-email-len.brown@intel.com>
References: 11866388361593-git-send-email-len.brown@intel.com
 <11866391363162-git-send-email-len.brown@intel.com>
 <11866391373567-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:23487 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755983AbXHIF67 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Aug 2007 01:58:59 -0400
In-Reply-To: <11866391373567-git-send-email-len.brown@intel.com>
Message-Id: <bccec9c22da355b4c54d8b74bb527c67e04c4bfb.1186638234.git.len.brown@intel.com>
In-Reply-To: <c405f58ecf5ebf0ba3752cb24a7cd0cc5075646d.1186638234.git.len.brown@intel.com>
References: <c405f58ecf5ebf0ba3752cb24a7cd0cc5075646d.1186638234.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

Thermal Zone Polling frequency (_TZP) is an optional ACPI object
recommending the rate that the OS should poll the associated thermal zone.

If _TZP is 0, no polling should be used.
If _TZP is non-zero, then the platform recommends that
the thermal zone be polled at the specified rate.
The minimum period is 30 seconds.
The maximum period is 5 minutes.

(note _TZP and thermal.tzp units are in deci-seconds,
 so _TZP = 300 corresponds to 30 seconds)

If _TZP is not present, ACPI 3.0b recommends that the
thermal zone be polled at an "OS provided default frequency".

However, common industry practice is:
1. The BIOS never specifies any _TZP
2. The OS never polls any thermal zones

Ie. OS depends on the platform's ability to
provoke thermal events when necessary, and
the "OS provided default frequency" is "never":-)

The Linux kernel already follows this common industry practice --
thermal zones are not polled unless _TZP is present and non-zero.

But thermal zone polling is useful as a workaround for systems
which have ACPI thermal control, but have an issue with
thermal events.  Indeed, some Linux distributions still
set a non-zero thermal polling frequency for this reason.

But rather than ask the user to write a polling frequency
into all the /proc/acpi/thermal_zone/*/polling_frequency
files, here we simply document and expose the already
existing module parameter to do the same at system level.

Note this is a module-load time parameter only.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |    5 +++++
 drivers/acpi/thermal.c              |    2 +-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 464aea1..2c21ed4 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1823,6 +1823,11 @@ and is between 256 and 4096 characters. It is defined in the file
 	thermal.off=	[HW,ACPI]
 			1: disable ACPI thermal control
 
+	thermal.tzp=	[HW,ACPI]
+			Specify global default ACPI thermal zone polling rate
+			<deci-seconds>: poll all this frequency
+			0: no polling (default)
+
 	time		Show timing data prefixed to each printk message line
 			[deprecated, see 'printk.time']
 
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 61337d9..b6b3bec 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -75,7 +75,7 @@ MODULE_DESCRIPTION("ACPI Thermal Zone Driver");
 MODULE_LICENSE("GPL");
 
 static int tzp;
-module_param(tzp, int, 0);
+module_param(tzp, int, 0444);
 MODULE_PARM_DESC(tzp, "Thermal zone polling frequency, in 1/10 seconds.\n");
 
 static int off;
-- 
1.5.3.rc4.29.g74276
