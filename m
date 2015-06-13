From: Mathias Krause <minipli@googlemail.com>
Subject: [PATCH 12/12] ACPI: Constify ACPI device IDs in documentation
Date: Sat, 13 Jun 2015 14:27:00 +0200
Message-ID: <1434198420-8519-13-git-send-email-minipli@googlemail.com>
References: <1434198420-8519-1-git-send-email-minipli@googlemail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:36517 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958AbbFMM1X (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 Jun 2015 08:27:23 -0400
Received: by wgzl5 with SMTP id l5so14266583wgz.3
        for <linux-acpi@vger.kernel.org>; Sat, 13 Jun 2015 05:27:22 -0700 (PDT)
In-Reply-To: <1434198420-8519-1-git-send-email-minipli@googlemail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mathias Krause <minipli@googlemail.com>

ACPI device ID arrays normally don't need to be written to as they're
only ever read. The common usage -- embedding pointers to acpi_device_id
arrays in other data structures -- reference them as 'const', e.g. as in
struct acpi_driver / acpi_scan_handler / device_driver. The matchers are
taking const pointers, too. So it's only natural, to propose using const
arrays. Change the documentation accordingly.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
---
 Documentation/acpi/enumeration.txt |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/acpi/enumeration.txt b/Documentation/acpi/enumeration.txt
index 15dfce708ebf..1beaac8433b6 100644
--- a/Documentation/acpi/enumeration.txt
+++ b/Documentation/acpi/enumeration.txt
@@ -42,7 +42,7 @@ Adding ACPI support for an existing driver should be pretty
 straightforward. Here is the simplest example:
 
 	#ifdef CONFIG_ACPI
-	static struct acpi_device_id mydrv_acpi_match[] = {
+	static const struct acpi_device_id mydrv_acpi_match[] = {
 		/* ACPI IDs here */
 		{ }
 	};
@@ -166,7 +166,7 @@ the platform device drivers. Below is an example where we add ACPI support
 to at25 SPI eeprom driver (this is meant for the above ACPI snippet):
 
 	#ifdef CONFIG_ACPI
-	static struct acpi_device_id at25_acpi_match[] = {
+	static const struct acpi_device_id at25_acpi_match[] = {
 		{ "AT25", 0 },
 		{ },
 	};
@@ -230,7 +230,7 @@ Below is an example of how to add ACPI support to the existing mpu3050
 input driver:
 
 	#ifdef CONFIG_ACPI
-	static struct acpi_device_id mpu3050_acpi_match[] = {
+	static const struct acpi_device_id mpu3050_acpi_match[] = {
 		{ "MPU3050", 0 },
 		{ },
 	};
-- 
1.7.10.4

