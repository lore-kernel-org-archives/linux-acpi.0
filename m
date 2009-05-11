From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [RFC] ACPI battery driver: odd usage of generic power supply
 class on battery removal
Date: Mon, 11 May 2009 16:44:49 +0100
Message-ID: <4A0847F1.4060205@tuffmail.co.uk>
References: <4A07159A.9010006@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f224.google.com ([209.85.219.224]:54810 "EHLO
	mail-ew0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755110AbZEKPow (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 May 2009 11:44:52 -0400
Received: by ewy24 with SMTP id 24so3518060ewy.37
        for <linux-acpi@vger.kernel.org>; Mon, 11 May 2009 08:44:52 -0700 (PDT)
In-Reply-To: <4A07159A.9010006@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Maxim Levitsky <maximlevitsky@gmail.com>

Alan Jenkins wrote:
> Hi,
>
> The ACPI battery driver does something strange with the generic power
> supply class, when the battery is removed from my laptop.  Instead of
> clearing the "present" attribute of the class device, it removes the
> entire class device.
>
> Can this be corrected, or is there a specific reason for it?
>
> Patch follows for illustration purposes.
>
> If this can be changed, I'd also try to cleanup
> acpi_battery_update().  I don't think it's right that
> CONFIG_ACPI_SYSFS_POWER affects the control flow.  When it's disabled,
> acpi_battery_present() is not tested before calling
> acpi_battery_get_state().  It might not cause any problems, but it is
> evil.
>

Ignore that patch, it won't work :-).  I have correct code prepared now
though.


    ACPI: battery: register power_supply subdevice only when battery is
present
   
    Make sure no power_supply object is present unless we actualy detect
    presence of battery. This fixes ghost batteries detected by HAL
   
    Signed-off-by: Andrey Borzenkov <arvidjaar@mail.ru>
    Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
    Signed-off-by: Len Brown <len.brown@intel.com>


Ok, I found the original discussion
<http://lkml.indiana.edu/hypermail/linux/kernel/0710.3/2001.html>.  At
that point, the battery driver tried to change the set of properties
dynamically.  If the battery was not present, there was a bug that
caused the set of properties to be left empty.

But it doesn't do that right now.  When I tested my (corrected) patches,
the set of properties remained constant, "present" returned "0", and all
the other attributes returned -ENODEV.

So I think we can revisit this and fix it the right way this time :-). 
I just need to write the descriptions, then I'll submit the patches for
review.

Thanks
Alan
