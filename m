From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [PATCH 28/48] thermal: Add event notification to thermal
 framework
Date: Thu, 13 Jan 2011 18:06:19 +0530
Message-ID: <D6D887BA8C9DFF48B5233887EF04654109447419AB@bgsmsx502.gar.corp.intel.com>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>
 <201101131221.43797.trenn@suse.de>
 <D6D887BA8C9DFF48B5233887EF0465410944741961@bgsmsx502.gar.corp.intel.com>
 <201101131247.21031.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:24948 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932547Ab1AMMgX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Jan 2011 07:36:23 -0500
In-Reply-To: <201101131247.21031.trenn@suse.de>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

> > I wonder why this one got exported at all.
> > > It's only used in thermal_sys.c for now?
> > > I hope I didn't oversee a follow up patch in another
> > > driver which already makes use of it.
> > >
> >
> > There is a patch to add threshold support to hwmon/coretemp.c
> > that uses this events. This patch is getting reviewed upstream.
> I wonder what the best way is to sync it with my updates
> if Len accepts them.
> Is the coretemp patch from you as well?
> It is queued for another tree I expect?
> Do you mind to repost it with a hint that it has to get synced
> with this one?
> 

The corresponding coretemp patch is from me only.
Anyway, I have to submit the coretemp again(due to some fixes..)
to the lm-sensors lists. This time when I submit it, I will
mention that it has to be synced with this latest patch.

Durga
