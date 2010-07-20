From: akpm@linux-foundation.org
Subject: [patch 12/26] acerhdf: make needlessly global symbols static
Date: Tue, 20 Jul 2010 15:19:43 -0700
Message-ID: <201007202219.o6KMJhI2021032@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50713 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932952Ab0GTWko (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jul 2010 18:40:44 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mjg59@srcf.ucam.org
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org, axel.lin@gmail.com, bp@alien8.de, mjg@redhat.com, peter@piie.net

From: Axel Lin <axel.lin@gmail.com>

The following symbols are needlessly defined global:

thz_dev
cl_dev
acerhdf_dev
acerhdf_dev_ops
acerhdf_cooling_ops

This patch makes the symbols static.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
Acked-by: Borislav Petkov <bp@alien8.de>
Acked-by: Peter Feuerer <peter@piie.net>
Cc: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/acerhdf.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff -puN drivers/platform/x86/acerhdf.c~acerhdf-make-needlessly-global-symbols-static drivers/platform/x86/acerhdf.c
--- a/drivers/platform/x86/acerhdf.c~acerhdf-make-needlessly-global-symbols-static
+++ a/drivers/platform/x86/acerhdf.c
@@ -92,9 +92,9 @@ static unsigned int fanstate = ACERHDF_F
 static char force_bios[16];
 static char force_product[16];
 static unsigned int prev_interval;
-struct thermal_zone_device *thz_dev;
-struct thermal_cooling_device *cl_dev;
-struct platform_device *acerhdf_dev;
+static struct thermal_zone_device *thz_dev;
+static struct thermal_cooling_device *cl_dev;
+static struct platform_device *acerhdf_dev;
 
 module_param(kernelmode, uint, 0);
 MODULE_PARM_DESC(kernelmode, "Kernel mode fan control on / off");
@@ -406,7 +406,7 @@ static int acerhdf_get_crit_temp(struct 
 }
 
 /* bind callback functions to thermalzone */
-struct thermal_zone_device_ops acerhdf_dev_ops = {
+static struct thermal_zone_device_ops acerhdf_dev_ops = {
 	.bind = acerhdf_bind,
 	.unbind = acerhdf_unbind,
 	.get_temp = acerhdf_get_ec_temp,
@@ -481,7 +481,7 @@ err_out:
 }
 
 /* bind fan callbacks to fan device */
-struct thermal_cooling_device_ops acerhdf_cooling_ops = {
+static struct thermal_cooling_device_ops acerhdf_cooling_ops = {
 	.get_max_state = acerhdf_get_max_state,
 	.get_cur_state = acerhdf_get_cur_state,
 	.set_cur_state = acerhdf_set_cur_state,
_
