From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] acpi-video: Add disable_native_backlight quirk for Dell
 XPS15 L521X
Date: Mon, 12 Jan 2015 10:21:32 +0000
Message-ID: <20150112102131.GA25585@srcf.ucam.org>
References: <1420444624-8313-1-git-send-email-hdegoede@redhat.com>
 <20150111061602.GA1677@srcf.ucam.org>
 <54B25280.6010604@redhat.com>
 <20150112024411.GA6831@srcf.ucam.org>
 <54B39019.2070501@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:51497 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319AbbALKVi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Jan 2015 05:21:38 -0500
Content-Disposition: inline
In-Reply-To: <54B39019.2070501@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org

On Mon, Jan 12, 2015 at 10:12:57AM +0100, Hans de Goede wrote:
> Hi,
> 
> On 12-01-15 03:44, Matthew Garrett wrote:
> >On Sun, Jan 11, 2015 at 11:37:52AM +0100, Hans de Goede wrote:
> >
> >>Userspace is writing to the intel_backlight device because it is the
> >>only one present under /sys/class/backlight, as we disable acpi-video
> >>on win8 ready laptops by default now.
> >
> >Why is nouveau not providing a backlight device?
> 
> I do not know.

We should figure that out. One possibility here is that it's correct for 
Intel to be disabling the ACPI device, but not correct for nouveau to 
be. We should possibly extend the interface to only unregister devices 
that correspond to the PCI device provided by the raw interface.

> >I don't think we have enough evidence to know whether this fix is
> >correct.
> 
> This fix fixes a regression introduced from kernel 3.15 to 3.16, when we
> switched video.use_native_brightness's default from 0 to 1, all this patch
> does is restore the previous behaviour on this specific model as the new
> behaviour is broken.

But it does so in a way that discourages us from ever fixing the actual 
problem, and leaves an unknown number of similar systems broken.

> So this is in essence a model targeted "revert" fixing a regression and as
> such most certainly is correct, given the clear no regressions policy the
> kernel has.

If we want to avoid regressions and a patch has broken a system without 
us having a good idea as to why, we should revert the entire patch in 
order to unbreak other systems.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
