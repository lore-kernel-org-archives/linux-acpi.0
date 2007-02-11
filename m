From: Len Brown <lenb@kernel.org>
Subject: acpi_find_bmc() and acpi_get_table()
Date: Sat, 10 Feb 2007 23:27:28 -0500
Message-ID: <200702102327.28312.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58668 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752674AbXBKE24 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 10 Feb 2007 23:28:56 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: minyard@mvista.com, Corey Minyard <minyard@acm.org>
Cc: linux-acpi@vger.kernel.org

Cory,
acpi_find_bmc() appears to be searching for 
multiple SPMI tables in the RSDT and running
try_init_acpi() on each of them
until it doesn't find any more.

Is that the intent?

Are here systems with multiple SPMI tables?

static __devinit void acpi_find_bmc(void)
{
        acpi_status      status;
        struct SPMITable *spmi;
        int              i;

        if (acpi_disabled)
                return;

        if (acpi_failure)
                return;

        for (i = 0; ; i++) {
                status = acpi_get_table(ACPI_SIG_SPMI, i+1,
                                        (struct acpi_table_header **)&spmi);
                if (status != AE_OK)
                        return;

                try_init_acpi(spmi);
        }
}

I speculated recently that the only table signature
that is (supposed to be) repeated in the RSDT is an SSDT.
Maybe that speculation is wrong if there can be multiple SPMI tables...

Bob, Alexey,
Also, one thing I'm not excited about is that acpi_get_table()
treats instance number 0 and 1 as synonyms -- which is
presumably why "i+1" is used above.  I think it would make sense
if instance 0 and instance 1 were different instances.

ie.

--- a/drivers/acpi/tables/tbxface.c
+++ b/drivers/acpi/tables/tbxface.c
@@ -397,7 +397,7 @@ acpi_get_table(char *signature,
                        continue;
                }

-               if (++j < instance) {
+               if (++j <= instance) {
                        continue;
                }

thanks,
-Len
