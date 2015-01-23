From: "Jan Beulich" <JBeulich@suse.com>
Subject: [PATCH] ACPI/sleep: mark acpi_sleep_dmi_check() __init
Date: Fri, 23 Jan 2015 08:12:06 +0000
Message-ID: <54C2106602000078000588DF@mail.emea.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:59530 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849AbbAWIMH convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-acpi@vger.kernel.org:3:1>);
	Fri, 23 Jan 2015 03:12:07 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, rjw@rjwysocki.net

ACPI/sleep: mark acpi_sleep_dmi_check() __init

This makes a difference if the compiler decides not to inline the
function, as then the function's reference to acpisleep_dmi_table[]
yields a section mismatch warning.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
---
 drivers/acpi/sleep.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 3.19-rc5/drivers/acpi/sleep.c
+++ 3.19-rc5-ACPI-sleep-DMI-check-init/drivers/acpi/sleep.c
@@ -321,7 +321,7 @@ static struct dmi_system_id acpisleep_dm
 	{},
 };
 
-static void acpi_sleep_dmi_check(void)
+static void __init acpi_sleep_dmi_check(void)
 {
 	int year;
 



