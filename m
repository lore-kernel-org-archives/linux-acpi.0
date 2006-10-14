From: Len Brown <len.brown@intel.com>
Subject: [PATCH 4/28] ACPI: ibm_acpi: Documentation the wan feature.
Date: Sat, 14 Oct 2006 04:05:45 -0400
Message-ID: <11608131733755-git-send-email-len.brown@intel.com>
References: <11608131691346-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:15251 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1752124AbWJNICw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 14 Oct 2006 04:02:52 -0400
In-Reply-To: <11608131691346-git-send-email-len.brown@intel.com>
Message-Id: <28b779d127d3038ff83f42259d135a063b7cd848.1160812999.git.len.brown@intel.com>
In-Reply-To: <288f3ad406460f03642a41bb945826891a7b866f.1160812999.git.len.brown@intel.com>
References: <288f3ad406460f03642a41bb945826891a7b866f.1160812999.git.len.brown@intel.com>
Date: Fri, 22 Sep 2006 12:19:16 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Stefan Schmidt <stefan@datenfreihafen.org>, Len Brown <len.brown@intel.com>

From: Stefan Schmidt <stefan@datenfreihafen.org>

Document the wan feature Jeremy Fitzhardinge added to ibm_acpi.

Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Acked-by: Borislav Deianov <borislav@users.sourceforge.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/ibm-acpi.txt |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/Documentation/ibm-acpi.txt b/Documentation/ibm-acpi.txt
index 1672590..00b8cf3 100644
--- a/Documentation/ibm-acpi.txt
+++ b/Documentation/ibm-acpi.txt
@@ -33,6 +33,7 @@ detailed description):
 	- LCD brightness control
 	- Volume control
 	- Experimental: fan speed, fan enable/disable
+	- Experimental: WAN enable and disable
 
 A compatibility table by model and feature is maintained on the web
 site, http://ibm-acpi.sf.net/. I appreciate any success or failure
@@ -601,6 +602,23 @@ with the following command:
 
 	echo 'level <level>' > /proc/acpi/ibm/thermal
 
+EXPERIMENTAL: WAN -- /proc/acpi/ibm/wan
+---------------------------------------
+
+This feature is marked EXPERIMENTAL because the implementation
+directly accesses hardware registers and may not work as expected. USE
+WITH CAUTION! To use this feature, you need to supply the
+experimental=1 parameter when loading the module.
+
+This feature shows the presence and current state of a WAN (Sierra
+Wireless EV-DO) device. If WAN is installed, the following commands can
+be used:
+
+	echo enable > /proc/acpi/ibm/wan
+	echo disable > /proc/acpi/ibm/wan
+
+It was tested on a Lenovo Thinkpad X60. It should probably work on other
+Thinkpad models which come with this module installed.
 
 Multiple Commands, Module Parameters
 ------------------------------------
-- 
1.4.3.rc2.g23bed-dirty
