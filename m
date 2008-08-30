From: Pavel Machek <pavel@suse.cz>
Subject: Re: Introduce interface to report BIOS bugs (reworked, FW_BUG simple solution)
Date: Sat, 30 Aug 2008 15:15:48 +0200
Message-ID: <20080830131547.GB7862@ucw.cz>
References: <200808210919.07642.bjorn.helgaas@hp.com> <1219843631-26015-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1158 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754829AbYH3Vv0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 30 Aug 2008 17:51:26 -0400
Content-Disposition: inline
In-Reply-To: <1219843631-26015-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: ak@linux.intel.com, bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org, arjan@linux.intel.com, linux-acpi@vger.kernel.org, ckornacker@suse.de

On Wed 2008-08-27 15:27:08, Thomas Renninger wrote:
> Even simplier, using FW_BUG define. I agree that the first implementation
> was over-designed, I somehow liked the printk_fw_err() and printk_fw_info()
> more, looked somehow more consistent with:
> 
> #define pr_info(fmt, arg...) \
>         printk(KERN_INFO fmt, ##arg)
> (and others).
> 
> Hmm, it shouldn't really matter.
> I wonder whether it works out that messages are hidden to the ordinary
> user with printk(KERN_INFO FW_BUG...).
> Something that vendors get an idea that they should not do this, but
> hiding it on a normally booted system is needed (but e.g. show it on a
> linuxfirmwarekit booted kernel).
> 
> printk(KERN_DEBUG FW_BUG...)
> Won't work because there you get too much output?
> Are these patches sufficient to achieve above?
> 
>       Thomas
> 
> PS: Forgot to add Pavel to CC who also commented on previous patches,
> it's work to do it right now, I expect you read this anyway.

Pavel listens, but sees no patch on either this or followup mail.

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
