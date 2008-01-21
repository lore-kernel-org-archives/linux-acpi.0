From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: a problem about the EC driver
Date: Mon, 21 Jan 2008 13:00:58 +0300
Message-ID: <47946D5A.5020307@suse.de>
References: <1200928644.17879.49.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:47583 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758394AbYAUKBs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Jan 2008 05:01:48 -0500
In-Reply-To: <1200928644.17879.49.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org

Hi Zhao,

All patches have relevant bugzilla entries, so you could read them for full
understanding.
Summary:
acpi_ec_probe/boot_ec_enable are workarounds for same situation then
EC driver should be inited early, but ECDT was not provided. Half of this
workaround was enabled earlier with fake ECDT.

Having a kernel parameter to enable a workaround is not good, as it requires too
much knowledge from the users, while the problem seem to be not one or two notebooks,
but whole MSI and ASUS lines.

Spec only covers case of ECDT for early init of EC, so whole series of patches do not 
have anything to do with spec, that should be clear.

EC could be used in either _INI methods for some devices at device init stage, 
or in _STA methods, then devices are scanned and attached to drivers.

It was found, that in absence of ECDT, if some _INI requires presence of
EC op region, there will be empty _INI method in EC scope.
It was also found that many EC will fail to initialize before all _INI methods
are done. This is why the registration of EC op region is done only if _INI method
is present in EC scope.

For _STA methods during device scan it is completely safe to enable EC op region
before, just because this is only a priority of driver assignment. We could be
very smart and add several priority passes to scan, but enabling EC before scan
does exactly what we need.

>    I don't understand why the flowchart of boot EC is changed very
> frequently.
Why it is my problem, if don't understand something in the kernel?
> Will you please give me detailed info about the four
> patches? Maybe it is helpful for us to understand the EC driver.
Maybe it is not, who is "us" in this sentence?

Regards,
Alex.


Zhao Yakui wrote:
> Hi, Alexey
>     I know that you are very familiar with the EC driver and you submit
> a lot patches for EC. Now I have a problem about the EC and want to get
> help from you.
>    a. In the March of 2007 the patch of
> 33c7a0738c5f753a7d94fd3b2ec7d84e79a141a8 was submitted by you. In this
> patch the Fake ECDT workaround is no longer used, which means that OSPM
> won't parse EC in DSDT when there is no ECDT table. 
>    b. In the August of 2007 the patch of
> cd8c93a4e04dce8f00d1ef3a476aac8bd65ae40b was submitted. In this patch
> OSPM will parse EC in DSDT when there is no ECDT table. It seems that
> many laptops without ECDT table will be affected. Is there a potential
> problem for the laptops without ECDT table? 
>    c. In the November of 2007 the patch of
> 5870a8cd23181703cc76f88f630372f8602c7648 was submitted. In this patch
> _INI check is added for EC device in DSDT table, which means that in the
> function of acpi_ec_ecdt_probe OSPM won't install EC handler when no
> _INI  method is found under the scope of EC in DSDT. It seems that a
> regression is caused by this patch. Please refer to the bug 9730. In the
> bug of 9730 there is no _INI method for EC device in DSDT table and OSPM
> won't install EC handler. But the _CRS method of EC device will set the
> EC flag. So some devices can't access the Operation Region defined in EC
> device in the course of Linux ACPI device scan and the error messages
> are reported. 
>     According to the description of this patch it seems that the _EC
> device is related to the _INI method.  But according to ACPI spec
> whether the operation region can be accessed is related to the _REG
> method. 
>    d. In the Jan of 2008 the patch of
> c04209a7948b95e8c52084e8595e74e9428653d3 was submitted. In this patch
> the function of boot_ec_enable is added , which means that OSPM will
> install EC handler for boot_ec device before acpi_bus_scan. 
>    
>    I don't understand why the flowchart of boot EC is changed very
> frequently. Will you please give me detailed info about the four
> patches? Maybe it is helpful for us to understand the EC driver.
>    
> 
> Thanks.
> 
>    
>      
> 
>     
> 

