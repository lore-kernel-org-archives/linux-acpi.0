From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 28/48] thermal: Add event notification to thermal framework
Date: Thu, 13 Jan 2011 14:41:52 +0100
Message-ID: <201101131441.52603.trenn@suse.de>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org> <201101131247.21031.trenn@suse.de> <D6D887BA8C9DFF48B5233887EF04654109447419AB@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:57509 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756811Ab1AMNlz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Jan 2011 08:41:55 -0500
In-Reply-To: <D6D887BA8C9DFF48B5233887EF04654109447419AB@bgsmsx502.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thursday 13 January 2011 13:36:19 R, Durgadoss wrote:
> > > I wonder why this one got exported at all.
> > > > It's only used in thermal_sys.c for now?
> > > > I hope I didn't oversee a follow up patch in another
> > > > driver which already makes use of it.
> > > >
> > >
> > > There is a patch to add threshold support to hwmon/coretemp.c
> > > that uses this events. This patch is getting reviewed upstream.
> > I wonder what the best way is to sync it with my updates
> > if Len accepts them.
> > Is the coretemp patch from you as well?
> > It is queued for another tree I expect?
> > Do you mind to repost it with a hint that it has to get synced
> > with this one?
> > 
> 
> The corresponding coretemp patch is from me only.
> Anyway, I have to submit the coretemp again(due to some fixes..)
> to the lm-sensors lists. This time when I submit it, I will
> mention that it has to be synced with this latest patch.

Or Len ignores my patch (the seconde, renaming one) and you pick
it up, extend it with the coretemp func and resubmit it
after everything got merged to Linus.
This should ensure no compile errors show up in linux-next or 
wherever...

   Thomas
