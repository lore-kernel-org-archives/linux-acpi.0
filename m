From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 1/1] include/acpi/processor.h: replace __attribute__((packed)) by __packed
Date: Sun,  1 Jun 2014 19:16:17 +0200
Message-ID: <1401642977-3745-1-git-send-email-fabf@skynet.be>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailrelay002.isp.belgacom.be ([195.238.6.175]:47511 "EHLO
	mailrelay002.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752103AbaFARRb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 1 Jun 2014 13:17:31 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Fabian Frederick <fabf@skynet.be>, Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

This patch fixes checkpatch warnings:

"WARNING: __packed is preferred over __attribute__((packed))"

Cc: Robert Moore <robert.moore@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 include/acpi/processor.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 6eb1d3c..9b9b6f2 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -53,7 +53,7 @@ struct acpi_power_register {
 	u8 bit_offset;
 	u8 access_size;
 	u64 address;
-} __attribute__ ((packed));
+} __packed;
 
 struct acpi_processor_cx {
 	u8 valid;
@@ -83,7 +83,7 @@ struct acpi_psd_package {
 	u64 domain;
 	u64 coord_type;
 	u64 num_processors;
-} __attribute__ ((packed));
+} __packed;
 
 struct acpi_pct_register {
 	u8 descriptor;
@@ -93,7 +93,7 @@ struct acpi_pct_register {
 	u8 bit_offset;
 	u8 reserved;
 	u64 address;
-} __attribute__ ((packed));
+} __packed;
 
 struct acpi_processor_px {
 	u64 core_frequency;	/* megahertz */
@@ -124,7 +124,7 @@ struct acpi_tsd_package {
 	u64 domain;
 	u64 coord_type;
 	u64 num_processors;
-} __attribute__ ((packed));
+} __packed;
 
 struct acpi_ptc_register {
 	u8 descriptor;
@@ -134,7 +134,7 @@ struct acpi_ptc_register {
 	u8 bit_offset;
 	u8 reserved;
 	u64 address;
-} __attribute__ ((packed));
+} __packed;
 
 struct acpi_processor_tx_tss {
 	u64 freqpercentage;	/* */
-- 
1.8.4.5

