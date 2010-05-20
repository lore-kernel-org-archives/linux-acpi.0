From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] [RESUBMIT] Fix mute key on older Lenovo made Thinkpads by
 OSI blacklisting
Date: Wed, 19 May 2010 23:34:05 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1005192325470.2921@localhost.localdomain>
References: <1272770432.15493.49.camel@laptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:64262 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890Ab0ETDed (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 May 2010 23:34:33 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L2P00B4P8KUYRP7@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 19 May 2010 22:34:07 -0500 (CDT)
In-reply-to: <1272770432.15493.49.camel@laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jerone Young <jerone.young@canonical.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hello Jerone,

Thanks for working to make Linux users with these systems happier.

As you know, we really really hate to add OSI(Linux) hooks
because the OSI string "Linux" is not an appropriate OSI string
as it doesn't describe a single interface, or even version of Linux...

Thus in the upstream kernel, we have shipped with OSI(Linux) disabled
since 2.6.23. 

The risk of restoring OSI(Linux) is that BIOS writers will
not realize that they have a BIOS bug when they use it
and the abuse and risk of bugs will become unbounded.

Of course for systems that have shipped already, the damage
is done -- and that seems to be the case here.

So the question I have is if OSI(Linux) *only* changes the
mute button on these boxes, or if it has any other effects.
Generally we need to examine the DSDT for each box to know.
Do you have the DSDT's for these boxes?

thanks,
Len Brown, Intel Open Source Technology Center

>                      DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T500"),
>                 },
>         },
> +       {
> +       .callback = dmi_enable_osi_linux,
> +       .ident = "Lenovo ThinkPad X200[s][t]",
> +       .matches = {
> +                    DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +                    DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X200"),
> +               },
> +       },
> +       {
> +       .callback = dmi_enable_osi_linux,
> +       .ident = "Lenovo ThinkPad R400",
> +       .matches = {
> +                    DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +                    DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad R400"),
> +               },
> +       },
> +       {
> +       .callback = dmi_enable_osi_linux,
> +       .ident = "Lenovo ThinkPad R500",
> +       .matches = {
> +                    DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +                    DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad R500"),
> +               },
> +       },
> +       {
> +       .callback = dmi_enable_osi_linux,
> +       .ident = "Lenovo ThinkPad W500",
> +       .matches = {
> +                   DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +                   DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad W500"),
> +               },
> +       },
> +       {
> +       .callback = dmi_enable_osi_linux,
> +       .ident = "Lenovo ThinkPad W700[ds]",
> +       .matches = {
> +                  DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +                  DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad W700"),
> +               },
> +       },
>         {}
>  };
>  
> 
> 
> 
> 
