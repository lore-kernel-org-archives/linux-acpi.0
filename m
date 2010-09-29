From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: acpi/test panic
Date: Wed, 29 Sep 2010 16:55:47 +0800
Message-ID: <1285750547.12984.18.camel@minggr.sh.intel.com>
References: <4C9FC97F.7030405@oracle.com>
	 <1285550762.5416.30.camel@minggr.sh.intel.com>
	 <4CA010F9.8040804@oracle.com>
	 <1285563934.5416.35.camel@minggr.sh.intel.com>
	 <alpine.LFD.2.00.1009272045260.27732@localhost.localdomain>
	 <1285730626.5741.0.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:49288 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755265Ab0I2IzQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Sep 2010 04:55:16 -0400
In-Reply-To: <1285730626.5741.0.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Yinghai Lu <yinghai.lu@oracle.com>, "Moore, Robert" <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wed, 2010-09-29 at 11:23 +0800, Lin Ming wrote:
> On Tue, 2010-09-28 at 08:46 +0800, Len Brown wrote:
> > > Len,
> > > Please merge above code into then commit "ACPICA: Revert "Revert "Enable
> > > multi-byte EC transfers".
> > 
> > done.
> > but i've backed out the acpica branch entirely
> > because it doesn't boot on my t61
> > starting with at this patch:
> > 
> > ACPICA/ACPI: Add new host interfaces for _OSI support
> 
> I'll test t61 and get back to you.

Hi, Len

I found the root cause that t61 hangs.
T61 hangs at below code path:

start_kernel ->
    setup_arch ->
        acpi_boot_table_init ->
            acpi_blacklisted ->
                dmi_enable_osi_linux ->
                    dmi_enable_osi_linux ->
                        acpi_dmi_osi_linux -> (T61 hits the DMI table)
                            set_osi_linux ->
                                acpi_install_interface

acpi_install_interface needs to acquire a mutex, and the call to it
hangs because ACPICA subsystem has not yet initialized at above call
path.                                

Below patch fix it.
acpi_osi_setup only saves the OSI string(it does not call
acpi_install_interface/acpi_remove_interface), and a later function
acpi_osi_setup_late will handle the OSI string.


diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index af109c7..07516d2 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1000,9 +1000,9 @@ static void __init set_osi_linux(unsigned int enable)
 	}
 
 	if (osi_linux.enable)
-		acpi_install_interface("Linux");
+		acpi_osi_setup("Linux");
 	else
-		acpi_remove_interface("Linux");
+		acpi_osi_setup("!Linux");
 
 	return;
 }

--
Lin Ming

> 
> Lin Ming
> 
> > 
> > thanks,
> > -Len Brown, Intel Open Source Technology Center
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


