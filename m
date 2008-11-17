From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [RFC] [Patch 1/2]  ACPI :Compare EC device in DSDT table with
 that	in ECDT table
Date: Mon, 17 Nov 2008 13:46:52 +0300
Message-ID: <49214B9C.6030204@gmail.com>
References: <1226904541.4062.23.camel@yakui_zhao.sh.intel.com>	 <49212B22.5030202@suse.de> <1226914935.4062.67.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:55320 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbYKQKqy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Nov 2008 05:46:54 -0500
Received: by ug-out-1314.google.com with SMTP id 39so366557ugf.37
        for <linux-acpi@vger.kernel.org>; Mon, 17 Nov 2008 02:46:51 -0800 (PST)
In-Reply-To: <1226914935.4062.67.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>

Zhao Yakui wrote:
>> Couple of concerns -- I think, I already mentioned one, but still...
>> 1. By parsing DSDT unconditionally, we loose all performance (if any) benefits of
>> having ECDT table. If we just don't look into ECDT, we will save some efforts.
>>     
> Agree with what you said. It is not appropriate to punish the system
> that already works well. It will take more time to execute the function
> of acpi_ec_ecdt_probe if ECDT table exists. OS can't confirm whether the
> ECDT table is correct before this check. Only after the check is added,
> we can know whether the info defined in ECDT table is reliable. So in my
> patch it is assumed that the info defined in ECDT table is not
> reliable.
So, either ECDT parse should go the way of do-do,
or DSDT parse in presence of ECDT should not happen.
I prefer second way -- as it is closer to the specification :)
>  
>   
>> 2. We are speaking about broken (hopefully rare) BIOS -- it might not be wise to punish everyone (see #1).
>> How about adding check in acpi_ec_start(), that with the same GPE we found difference in addresses?
>>     
>    It is a good point to add the check in the acpi_ec_start. But in such
> case there exists two issues:
>      a. OS will scan the ACPI namespace to build the ACPI device tree
> before the ACPI ec driver is registered. As the EC device is already
> initialized, maybe the EC will be accessed in the scanning of ACPI
> device tree.(For example: in the _STA object of battery, AC Adapter). In
> such case some warning message will be reported.
>      >ACPI: EC: input buffer is not empty, aborting transaction
>     >[18.125459] ACPI Exception (evregion-0420): AE_TIME, Returned by Handler
> for [EmbeddedControl] [20070126]
>   
Remember, we are speaking about broken hardware, it is OK to spill some 
errors, while
we provide solution to user in the end. In this case only user of broken 
hardware is punished, not everybody.
>     
>     After the acpi ec driver is registered, the above message won't be reported again.
> But it seems very confusing.
>
>     b. On the laptops of bug 11880 all the info in ECDT table is incorrect. 
> The EC GPE number and EC namepath are incorrect besides the EC Cmd/Status/Data I/O port.
>     As there exists the ECDT table, the EC device will be initialized and the incorrect 
> EC GPE is enabled before building ACPI device tree.  In such case although the EC address
> info can be corrected by calling the ec_parse_device in acpi_ec_start, the EC GPE can't be
> corrected(Still the incorrect GPE number is enabled for EC).
You could insert some check like if ("errors in boot_ec" || 
"acpi_ec_start does not find boot ec"), print same advice...

>  
>   
>> And if this check triggers, print "Your ECDT does not conform to DSDT. Add acpi_ec.skip_ecdt=1 kernel option."
>> Add acpi_ec.skip_ecdt option and skip ECDT parse if it is set...
>> 3. This patch seems to imply that DSDT contains single EC. As this is first place with such assumption,
>>     
>     Yes. What you said is right. One EC device is assumed in my patch.
> In theory there exists more than one EC device. But it seems that now no
> laptops have more than one EC devices. Can this case be ignored?
>   
I have notebook  with 2 EC on my desk at the moment, made by FIC/VIA.
I don't like to break working hardware to enable broken.

Regards,
Alex.
