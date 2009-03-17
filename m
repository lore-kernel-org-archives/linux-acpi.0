From: Len Brown <lenb@kernel.org>
Subject: Re: [patch for 2.6.29? 1/1] acer-wmi: fix regression in backlight
 detection
Date: Tue, 17 Mar 2009 01:17:40 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903170117020.4473@localhost.localdomain>
References: <200903042007.n24K7Yc7029496@imap1.linux-foundation.org>
 <200903051125.42313.trenn@suse.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-524342686-1237267062=:4473"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:13475 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbZCQFRr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Mar 2009 01:17:47 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KGM00L22XDLLPPG@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 17 Mar 2009 00:17:46 -0500 (CDT)
In-reply-to: <200903051125.42313.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: akpm@linux-foundation.org, linux-acpi@vger.kernel.org, mspang@csclub.uwaterloo.ca, ak@linux.intel.com, carlos@strangeworlds.co.uk, len.brown@intel.com, rjw@sisk.pl, rui.zhang@intel.com, stable@kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-524342686-1237267062=:4473
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT

Linus checked this into 2.6.29
1ba869ec581fd9078b684c56c399ffe3d2345e27

and greg has it in his 2.6.28.stable queue,
so we're all set.

thanks,
Len Brown, Intel Open Source Technology Center

On Thu, 5 Mar 2009, Thomas Renninger wrote:

> Hi,
> 
> On Wednesday 04 March 2009 21:07:34 akpm@linux-foundation.org wrote:
> > From: Michael Spang <mspang@csclub.uwaterloo.ca>
> > 
> > Currently we disable the Acer WMI backlight device if there is no ACPI
> > backlight device.  As a result, we end up with no backlight device at all.
> >  We should instead disable it if there is an ACPI device, as the other
> > laptop drivers do.  This regression was introduced in febf2d9 ("Acer-WMI:
> > fingers off backlight if video.ko is serving this functionality").
> > 
> > Each laptop driver with backlight support got a similar change around
> > febf2d9.  The changes to the other drivers look correct; see e.g. 
> > a598c82f for a similar but correct change.  The regression is also in
> > 2.6.28.
> Len, can you apply this one, please.
> 
> > Signed-off-by: Michael Spang <mspang@csclub.uwaterloo.ca>
> > Cc: Thomas Renninger <trenn@suse.de>
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> 
> No idea about stable policy, whether you have to wait for a mainline commit
> first or if you just push such typos. Here is the patch against 2.6.28,
> there the bug got introduced (file moved).
> 
> Thanks,
> 
>      Thomas
> 
> ---
>  drivers/misc/acer-wmi.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/misc/acer-wmi.c
> ===================================================================
> --- linux-2.6.orig/drivers/misc/acer-wmi.c
> +++ linux-2.6/drivers/misc/acer-wmi.c
> @@ -1297,7 +1297,7 @@ static int __init acer_wmi_init(void)
>  
>  	set_quirks();
>  
> -	if (!acpi_video_backlight_support() && has_cap(ACER_CAP_BRIGHTNESS)) {
> +	if (acpi_video_backlight_support() && has_cap(ACER_CAP_BRIGHTNESS)) {
>  		interface->capability &= ~ACER_CAP_BRIGHTNESS;
>  		printk(ACER_INFO "Brightness must be controlled by "
>  		       "generic video driver\n");
> --8323328-524342686-1237267062=:4473--
--8323328-524342686-1237267062=:4473--
