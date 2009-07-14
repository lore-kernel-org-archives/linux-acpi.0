From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/3] backlight: Allow drivers to update the core, and
	generate events on changes
Date: Tue, 14 Jul 2009 14:21:52 +0100
Message-ID: <20090714132152.GA22521@srcf.ucam.org>
References: <1247517685-7719-1-git-send-email-mjg@redhat.com> <20090714103006.GA19866@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49499 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752468AbZGNNVy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Jul 2009 09:21:54 -0400
Content-Disposition: inline
In-Reply-To: <20090714103006.GA19866@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rpurdie@rpsys.net, lenb@kernel.org, rui.zhang@intel.com, corentincj@iksaif.net

On Tue, Jul 14, 2009 at 07:30:07AM -0300, Henrique de Moraes Holschuh wrote:
> On Mon, 13 Jul 2009, Matthew Garrett wrote:
> > Certain hardware will send us events when the backlight brightness
> > changes. Add a function to update the value in the core, and
> > additionally send a uevent so that userspace can pop up appropriate
> > UI. The uevents are flagged depending on whether the update originated
> > in the kernel or from userspace, making it easier to only display UI
> > at the appropriate time.
> 
> Any reasons to not do it using poll() support (since sysfs has it)?  Or at
> least, do both poll and uevents?

More code? It doesn't really seem necessary.

> Other than that, I like the idea a lot.  thinkpad-acpi will use this event
> support.

Good, that's one of the use-cases I wanted to deal with - but the hotkey 
mask stuff is complicated enough that I hadn't got round to touching 
that yet. The combination of this and the ALSA mixer code should get us 
full notification.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
