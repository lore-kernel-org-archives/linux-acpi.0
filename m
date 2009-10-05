From: Stefan Bader <stefan.bader@canonical.com>
Subject: Re: [Fwd: Re: [PATCH] acerhdf: Limit modalias matching to supported
 boards]
Date: Mon, 05 Oct 2009 17:56:51 +0200
Message-ID: <4ACA1743.5030500@canonical.com>
References: <4AC9E0F3.5030605@canonical.com> <4AC9E122.8050609@canonical.com> <200910050919.51581.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:37947 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859AbZJEP5a (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Oct 2009 11:57:30 -0400
In-Reply-To: <200910050919.51581.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: lenb@kernel.org, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Borislav Petkov <petkovbb@gmail.com>, Peter Feuerer <peter@piie.net>

Bjorn Helgaas wrote:
> On Monday 05 October 2009 06:05:54 am Stefan Bader wrote:
>>>>>> <stefan.bader@canonical.com> wrote:
>>>>>>>>> I search my acerhdf-inbox for the people who sent me the BIOS 
>>>>>>>>> versions,
>>>>>>>> maybe they still have the netbook and can me send the modalias 
>>>>>>>> content. I'll
>>>>>>>> hopefully find some time upcoming weekend.
>>>>>>>>
>>>>>>>> But, can't we simply assume, following dmi lines?
>>>>>>>>
>>>>>>>> MODULE_ALIAS("dmi:*:*Acer*:*AOA*:");
>>>>>>>> MODULE_ALIAS("dmi:*:*Gateway*:*AOA*:");
>>>>>>>> MODULE_ALIAS("dmi:*:*Packard Bell*:*AOA*:");
>>>>>>>> MODULE_ALIAS("dmi:*:*Packard Bell*:*DOA*:");
>>>>>>>>
>>>>>>>> We have exactly those constellations within the BIOS settings 
>>>>>>>> table. If I
>>>>>>>> interpret the modalias line correctly, "pnAOA110" means "Product Name
>>>>>>>> AOA110" and that's what we have already in the BIOS settings 
>>>>>>>> table. So I
>>>>>>>> think we do already have all information we need to create a 
>>>>>>>> complete patch
>>>>>>>> for the problem, or am I wrong?
>>>>>>> Right pn means that. I would strongly believe the above changes 
>>>>>>> should be
>>>>>>> good. I sometimes tend to be over-cautious. Attaching a refreshed 
>>>>>>> patch
>>>>>>> which includes them all.
>>>>>> Well, acerhdf.c and dmi-id.c both do
>>>>>> dmi_get_system_info(DMI_PRODUCT_NAME) when querying product name which
>>>>>> means that the product names in the acerhdf table and the dmi-id ones
>>>>>> are actually one and the same thing.
> 
> This smells like a maintenance problem.  The driver only works on the
> specific machines and BIOS versions compiled into it.  That means you
> have to update the driver every time a new machine comes out.  A major
> goal of ACPI is to avoid stuff like that.
> 
> Are you sure there's no way to make this driver work in a generic way,
> e.g., by claiming an ACPI device?

The driver is currently only targeted at a small set of netbooks and even there 
some registers have changed between sub models or bios versions.
The functions are implemented by poking and reading bits from the EC. No acpi 
interface to which one relate as far as I know. Maybe wmi, but from the 
experiences with acer-wmi, I doubt anything works. At least acer-wmi now 
explicitly blacklist these models for uselessness.
So the driver performs very strict bios version checks and every unknown 
version get a big warning printed. Which you do not want to be issued on every 
hardware of one of these vendors. Which happens with the driver as it is now.

-Stefan

> I can't believe that Windows would tolerate a solution like this,
> although I guess maybe people are using to having to install Windows,
> then install random OEM-specific junk on top to get full functionality,
> and OEMs can probably do whatever ugly things they want there.
> 
> Or is this another case of "the OS is supposed to use WMI to do this,
> and no, you can't have the WMI information"?

> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 

When all other means of communication fail, try words!


