From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: linux-next acpi changes make vmware server unusable
Date: Thu, 05 Mar 2009 08:44:31 +0800
Message-ID: <1236213871.28145.1.camel@minggr.sh.intel.com>
References: <1236203700.3569.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:24881 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754624AbZCEAuF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 4 Mar 2009 19:50:05 -0500
In-Reply-To: <1236203700.3569.11.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Eric Paris <eparis@redhat.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "Brown, Len" <len.brown@intel.com>

On Thu, 2009-03-05 at 05:55 +0800, Eric Paris wrote:
> I built a linux-next kernel yesterday and discovered that the free
> vmware server 2 would start to boot the kernel and very quickly just
> power off.  vmware gave some crap message about the MBR being wrong,
> which obviously wasn't the case since grub started and the kernel
> started booting.  Looking at the last line on the serial console for the
> new kernel and the next line in a working kernel I knew the next output
> was supposed to be in the ACPI code.  I bisected drivers/acpi and found
> that d6c349993fc7c9dabf873796c4e82bb94544b3ce is first bad commit.

Would you please try below patch?


    ACPICA: Check for non-zero address before being converted to GAS
    
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/tbfadt.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index 042d239..af8fbe1 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -625,12 +625,14 @@ static void acpi_tb_setup_fadt_registers(void)
 		    ACPI_ADD_PTR(struct acpi_generic_address, &acpi_gbl_FADT,
 				 fadt_pm_info_table[i].source);
 
-		acpi_tb_init_generic_address(fadt_pm_info_table[i].target,
-					     source64->space_id,
-					     pm1_register_byte_width,
-					     source64->address +
-					     (fadt_pm_info_table[i].
-					      register_num *
-					      pm1_register_byte_width));
+		if (source64->address) {
+			acpi_tb_init_generic_address(fadt_pm_info_table[i].
+						     target, source64->space_id,
+						     pm1_register_byte_width,
+						     source64->address +
+						     (fadt_pm_info_table[i].
+						      register_num *
+						      pm1_register_byte_width));
+		}
 	}
 }


> 
> I have no idea what vmware is doing, or what we are doing, but before
> that patch I was able to boot and after it, vmware just shuts itself
> off.
> 
> -Eric
> 
> 

