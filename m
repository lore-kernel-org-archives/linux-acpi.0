From: Eric Piel <eric.piel@tremplin-utc.net>
Subject: Re: [PATCH] Override DSDT and SSDTs via initramfs
Date: Fri, 01 Feb 2008 11:38:41 +0100
Message-ID: <47A2F6B1.9060108@tremplin-utc.net>
References: <4798E2A5.6020804@users.sf.net>	 <20080125063328.4e3b4752.akpm@linux-foundation.org>	 <200801252339.44246.lenb@kernel.org>	 <1201714051.1222.131.camel@queen.suse.de>	 <47A0FBD4.6090603@tremplin-utc.net> <1201861297.14573.66.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:32516 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754609AbYBAKis (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Feb 2008 05:38:48 -0500
In-Reply-To: <1201861297.14573.66.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Philippe Coval <rzr@users.sourceforge.net>, linux-acpi@vger.kernel.org, dsdt <dsdt@gaugusch.at>

Thomas Renninger wrote:
> About Len's points 1-4:
> 
> 1. tainted bit needs to be set when a DSDT override is used.
>    (this is common both to the new patch and the current
>     override method)
> 
> 2. upon setting the tainted bit, print a BIG FAT WARNING
>    that this is not a supported configuration.
> 
> 3. cmdline option needs to be available to disable
>    an override.  Otherwise a bad image in the intrd
>    may be a serious pickle for some users.
> 
> 4. get rid of alarming failure message:
> 
> +       printk(KERN_INFO "Looking for DSDT in initrd ...");
> ...
> +       printk(" not found!\n");
> 
> Most of this should be included in the one I sent:
> 1+2 should be covered by this:
> +                               printk(PREFIX "Override [%4.4s-%8.8s]"
> +                                      " from initramfs -"
> +                                      " tainting kernel\n",
> +                                      t->signature,
> +                                      t->oem_table_id);
> +                               add_taint(TAINT_NO_SUPPORT);
> I remember that I introduced a new TAINT flag, this got probably ripped
> out because I expect it needed conflict solving with new kernels all the
> time.
> Now when it goes mainline a TAINT_DSDT_OVERRIDE flag might be
> appropriate, so that if you see a kernel panic or whatever bug, you
> immediately see why the kernel is tainted.
> 
> Problem from 4. should also not exist in this patch anymore.
> 
> The boot parameter (3.) is still missing.
Indeed, points 2 and 4 are already solved in your patch :-)


> Eric, would you mind bringing this all together (if Len agrees with my
> aspects).
> I'd vote for moving the current location of the DSDT file to:
> /dsdt/DSDT.aml
> This would break current userspace apps (including SuSE's mkinitrd), but
> would prepare the patch for further SSDT enhancements.
Ok, I'll try to have something ready by the beginning of next week. I'm 
waiting from Len for his comments on the best names of the files and the 
SSDTs inclusion...

See you,
Eric
