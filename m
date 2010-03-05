From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH -mmotm] acpi/sbs: fix build for ACPI_SYSFS_POWER=n
Date: Fri, 05 Mar 2010 11:54:17 -0800
Message-ID: <4B916169.5040303@oracle.com>
References: <201003050232.o252WD4K011798@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from acsinet12.oracle.com ([141.146.126.234]:38748 "EHLO
	acsinet12.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755802Ab0CET40 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Mar 2010 14:56:26 -0500
In-Reply-To: <201003050232.o252WD4K011798@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, Alexey Starikovskiy <astarikovskiy@suse.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

From: Randy Dunlap <randy.dunlap@oracle.com>

When CONFIG_ACPI_SYSFS_POWER is not enabled:

drivers/acpi/sbs.c:640: error: implicit declaration of function 'acpi_battery_get_alarm'
drivers/acpi/sbs.c:679: error: implicit declaration of function 'acpi_battery_set_alarm'


so move those functions outside of the ifdef/endif block for that
config option.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/acpi/sbs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- mmotm-2010-0304-1805.orig/drivers/acpi/sbs.c
+++ mmotm-2010-0304-1805/drivers/acpi/sbs.c
@@ -412,8 +412,6 @@ static int acpi_ac_get_present(struct ac
 	return result;
 }
 
-#ifdef CONFIG_ACPI_SYSFS_POWER
-
 static int acpi_battery_get_alarm(struct acpi_battery *battery)
 {
 	return acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD,
@@ -450,6 +448,8 @@ static int acpi_battery_set_alarm(struct
 	return ret;
 }
 
+#ifdef CONFIG_ACPI_SYSFS_POWER
+
 static ssize_t acpi_battery_alarm_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
