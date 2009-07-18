From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/3] backlight: Allow drivers to update the core, and
	generate events on changes
Date: Sat, 18 Jul 2009 13:48:46 +0200
Message-ID: <20090718114846.GE1433@ucw.cz>
References: <1247587564-27737-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60508 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932549AbZGRLtE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 18 Jul 2009 07:49:04 -0400
Content-Disposition: inline
In-Reply-To: <1247587564-27737-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rpurdie@rpsys.net, lenb@kernel.org, rui.zhang@intel.com, corentincj@iksaif.net

On Tue 2009-07-14 17:06:02, Matthew Garrett wrote:
> Certain hardware will send us events when the backlight brightness
> changes. Add a function to update the value in the core, and
> additionally send a uevent so that userspace can pop up appropriate
> UI. The uevents are flagged depending on whether the update originated
> in the kernel or from userspace, making it easier to only display UI
> at the appropriate time.

This adds new kernel API. Should it be documented somewhere?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
