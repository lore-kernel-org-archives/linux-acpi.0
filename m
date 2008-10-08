From: Jordan Crouse <jordan.crouse@amd.com>
Subject: Re: WDRT based watchdog timer
Date: Wed, 8 Oct 2008 14:44:22 -0600
Message-ID: <20081008204422.GA2932@cosmic.amd.com>
References: <20080926232752.GA6061@cosmic.amd.com> <alpine.LFD.1.10.0810081552220.3041@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-va3.frontbridge.com ([216.32.180.16]:12349 "EHLO
	VA3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754142AbYJHUoX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Oct 2008 16:44:23 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0810081552220.3041@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Marc Brooker <mbrooker@rrsg.ee.uct.ac.za>, Wim Van Sebroeck <wim@iguana.be>

On 08/10/08 16:25 -0400, Len Brown wrote:
> 
> 
> On Fri, 26 Sep 2008, Jordan Crouse wrote:
> 
> > Attached is a patch to support watchdog timers as described
> > by the WDRT (Watch Dog Resource Table).  This has been tested on
> > the AMD SB600 chipset, but it should work for any chipset / BIOS
> > that implements the WDRT table.
> > 
> > I'm not in love with the name - but I couldn't think of anything
> > better, so I'm open to suggestions.  I have a limited number of
> > systems that implement this interface, so I would be very happy
> > to hear from other users, especially ones not using AMD chipsets.
> 
> While this driver depends on ACPI, it actually isn't part of ACPI.
> 
> Indeed, here is 100% of the ACPI spec support for this watchdog timer:
> 
> "WDRT" Watchdog Resource Table Watchdog Timer Hardware Requirements for
>                                Windows Server 2003
>                                http://www.microsoft.com/whdc/system/CEC/
>                                watchdog.mspx
> 
> so while the driver uses ACPI to enumerate the device,
> the device doesn't use any run-time ACPI support,
> and the Windows spec above actually defines the hardware.
> 
> > drivers/watchdog/acpiwdt.c
> 
> I'm not wild about having the string "acpi" be part of the driver name,
> config option, variable names etc.   Maybe the spec above which actually
> defines the timer would suggest a better name; or maybe simply
> name it after its configuration table, wrdt.c?

yeah - the string 'acpi' concerned as well.  I didn't want to really
call it win2k3wdt.c, though. :). 

> The spec URL should be in the driver comments or commit log, BTW.

Will do.

> I don't know who maintains /drivers/watchdog/,
> but Wim Van Sebroeck has scribbled there the most recently,
> and can probably weigh in on this.

Yeah - I forgot to CC him on my previous email, and I forwarded it
to him separately.  

> I searched my logs for WRDT and found only one,
> and it does happen to be one with an Intel processor --
> though an nvidia chipset:
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=8950
> 
> so maybe Marc will be able to test the new driver?

Sure - once Wim sends his comments, I'll ping him.  Thanks.

Jordan

-- 
Jordan Crouse
Systems Software Development Engineer 
Advanced Micro Devices, Inc.

