From: Mattia Dongili <malattia@linux.it>
Subject: Re: sony-laptop on AR series
Date: Sat, 26 Jan 2008 12:50:59 +0900
Message-ID: <20080126035059.GA24583@inferi.kami.home>
References: <17b35fe50801230233jda8e183qf380ec153c26020c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi15.ns.itscom.net ([219.110.2.185]:54449 "EHLO
	mtoichi15.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbYAZDu4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Jan 2008 22:50:56 -0500
Content-Disposition: inline
In-Reply-To: <17b35fe50801230233jda8e183qf380ec153c26020c@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: eaglex <eaglex@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Wed, Jan 23, 2008 at 12:33:34PM +0200, eaglex wrote:
> Hello,

Hi,

> I own a Sony Vaio VGN-AR41E and have gotten the Fn keys
> to report ACPI events by adding:
> 
> ---------- paste ---------
>             .ident = "Sony Vaio AR Series",
>             .callback = sony_nc_C_enable,
>             .driver_data = sony_C_events,
>             .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "VGN-AR"),
> ------- end paste -----
> 
> to the appropriate section in drivers/misc/sony-laptop.c, but that's
> about all that works.

Great, I can add this laptop to the list.

> I get no controls in /sys/devices/platform/sony-laptop. I do get a few
> controls in
> /sys/class/backlight/sony, but they don't seem to do anything.
> (I get these: actual_brightness bl_power brightness max_brightness).
> 
> Any suggestions?

Could you send the output of lspci and upload somewhere the DSDT (or
send me provately as I'm not sure about the limits for postings to this
list).

Thanks
-- 
mattia
:wq!
