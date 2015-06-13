From: Mathias Krause <minipli@googlemail.com>
Subject: [PATCH 05/12] ACPI / battery: constify the offset tables
Date: Sat, 13 Jun 2015 14:26:53 +0200
Message-ID: <1434198420-8519-6-git-send-email-minipli@googlemail.com>
References: <1434198420-8519-1-git-send-email-minipli@googlemail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:35377 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509AbbFMM1R (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 Jun 2015 08:27:17 -0400
Received: by wgbhy7 with SMTP id hy7so6006647wgb.2
        for <linux-acpi@vger.kernel.org>; Sat, 13 Jun 2015 05:27:16 -0700 (PDT)
In-Reply-To: <1434198420-8519-1-git-send-email-minipli@googlemail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mathias Krause <minipli@googlemail.com>

The offset tables are only read, not modified. Make them const.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
---
 drivers/acpi/battery.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 63d43677f644..8ec28e395fa1 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -354,14 +354,14 @@ struct acpi_offsets {
 	u8 mode;		/* int or string? */
 };
 
-static struct acpi_offsets state_offsets[] = {
+static const struct acpi_offsets state_offsets[] = {
 	{offsetof(struct acpi_battery, state), 0},
 	{offsetof(struct acpi_battery, rate_now), 0},
 	{offsetof(struct acpi_battery, capacity_now), 0},
 	{offsetof(struct acpi_battery, voltage_now), 0},
 };
 
-static struct acpi_offsets info_offsets[] = {
+static const struct acpi_offsets info_offsets[] = {
 	{offsetof(struct acpi_battery, power_unit), 0},
 	{offsetof(struct acpi_battery, design_capacity), 0},
 	{offsetof(struct acpi_battery, full_charge_capacity), 0},
@@ -377,7 +377,7 @@ static struct acpi_offsets info_offsets[] = {
 	{offsetof(struct acpi_battery, oem_info), 1},
 };
 
-static struct acpi_offsets extended_info_offsets[] = {
+static const struct acpi_offsets extended_info_offsets[] = {
 	{offsetof(struct acpi_battery, revision), 0},
 	{offsetof(struct acpi_battery, power_unit), 0},
 	{offsetof(struct acpi_battery, design_capacity), 0},
@@ -402,7 +402,7 @@ static struct acpi_offsets extended_info_offsets[] = {
 
 static int extract_package(struct acpi_battery *battery,
 			   union acpi_object *package,
-			   struct acpi_offsets *offsets, int num)
+			   const struct acpi_offsets *offsets, int num)
 {
 	int i;
 	union acpi_object *element;
-- 
1.7.10.4

