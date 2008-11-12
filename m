From: Thomas Renninger <trenn@suse.de>
Subject: Re: Can video_detect be made __init?
Date: Wed, 12 Nov 2008 17:34:25 -0600
Message-ID: <200811121734.25449.trenn@suse.de>
References: <200811081655.08226.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:45045 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756143AbYKLXea (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Nov 2008 18:34:30 -0500
In-Reply-To: <200811081655.08226.arvidjaar@mail.ru>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-acpi@vger.kernel.org

On Saturday 08 November 2008 07:55:07 am Andrey Borzenkov wrote:
> I would add DMI entries to force vendor backlight for my system, but
> I'd really prefer they are not remain in memory forever. Is there any
> reason for the whole detection to not happen exactly once? After all,
> ACPI cannot change after boot, can it?
>
> Hmm ... actually DSDT can be loaded from initrd, so it can change ... but
> in this case we actually are just interested in DMI matching which says
> whether vendor driver is preferred or not. What would be the the best
> place to call it from?

Sorry, I only half answered the question in my previous mail.
acpi_video_backlight_support(..)
which is called by the backlight supporting drivers is going to check (when 
invoked the first time) whether general ACPI video functions are provided via 
the ACPI tables.
Advantage is that the check is only done if video.ko or vendor_laptop drivers 
are trying to be loaded. That means on a server where video.ko or 
vendor_laptop.ko are not needed, the video ACPI func detection does not take 
place.
The "disadvantage" is that it's done at driver load time and cannot be 
declared __init.

       Thomas
