From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH 0/5] WMI patches for acpi-test
Date: Sun, 3 Feb 2008 09:45:05 +0000
Message-ID: <200802030945.06398.carlos@strangeworlds.co.uk>
References: <20080202121718.2286.89857.stgit@pacifica> <200802022244.22917.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from host-240-152.cust.aaawireless.net ([216.23.240.152]:52595 "EHLO
	mail.slackadelic.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S936479AbYBCJpJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Feb 2008 04:45:09 -0500
In-Reply-To: <200802022244.22917.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Alexey Starikovskiy <aystarik@gmail.com>

On Sunday 03 February 2008 03:44:22 Len Brown wrote:
> I think the indication of success of this effort will be
> other people writing drivers to do useful things with
> the WMI hooks you are exposing.  So we certainly want to
> get the base driver out there sooner to support that.

Matthew already has an input driver for HP laptops in progress, so I think 
that's a good sign.

> I don't know if it would be better to ship a prototype
> sysfs user interface in the hopes it encourages adopters
> and get feedback to make it better, or to bake it more
> out of tree in the hopes of shipping something more
> final in the first shot.

The main problem with the sysfs interface is that, unlike the kernel one, 
there are no real users yet.

I have a hacked together test application which does some basic read/ write to 
sysfs, but that's about it.

> I'm inclined to ship an EXPERIMENTAL API because
> the more eyes on it sooner the better.  One option
> would be to have the sysfs I/F be a sub-config option
> that is default N -- indeed, you can call it a DEBUGGING
> or DEVELOPMENT I/F to scare people away from the the wrong impression:-)

Yes, that would be a better idea.

> > +config ACPI_WMI
> > +	tristate "WMI (EXPERIMENTAL)"
> > +	depends on EXPERIMENTAL
> > +	default m
>
> I deleted the "default m" line when i checked in this patch.
> So if you revise/resend this patch in the future, please do the same.

Will do.

For future patches - do you want me to resend them, or send you incremental 
patches against what is currently in your tree?

> acer-wmi needs a MAINTAINER

Oversight on my part - will do.

> tc1100-wmi needs a MAINTAINER

I'll add myself for now; but if anyone else wants the job, I don't mind.

> I don't understand the WMI user/kernel sysfs API.

I did have some documentation on this - I'll refresh it and send another 
patch.

> I guess i had originally expected it to live in /sys/firmware/wmi,
> but I see that they put dmi a subset of DMI under /sys/class/dmi,
> so i guess there is precident...  I got my main wish, which was
> to have not _not_ be under some ACPI specific directory:-)

I can probably put a symlink in for /sys/firmware/wmi, if you like?

The /sys/class is done simply because using a class and virtual devices is far 
simpler, and appears less prone to the sysfs-rework-of-the-week (and makes 
autoload support based on a GUID trivial to implement).

> #2 is the better route -- move forward using workaround,
> and revert the workaround when it is no longer needed.
> The risk is if somebody in user-space starts actually
> programming to 19-character GUIDS.

Ok.

> I loaded this driver on an HP nx6325 as well as a Lenovo T61.

Interesting - do Lenovo actually use WMI for anything? I thought they had 
their own custom HID's supported by thinkpad-acpi?

> just for kicks i tried to dump the data attributes,
> but on both machines I found that some of them oops
> in wmi_data_read like below.

Hmm - I'll look into this and see if I can see what's going wrong.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
