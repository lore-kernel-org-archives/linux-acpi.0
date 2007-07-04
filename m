From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 2/2] PM: Introduce pm_power_off_prepare
Date: Wed, 4 Jul 2007 21:52:31 +0200
Message-ID: <20070704195231.GI2728@elf.ucw.cz>
References: <200707012051.48338.rjw@sisk.pl> <200707012054.31782.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56407 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757093AbXGDTwf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 4 Jul 2007 15:52:35 -0400
Content-Disposition: inline
In-Reply-To: <200707012054.31782.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Sun 2007-07-01 20:54:31, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Introduce the pm_power_off_prepare() callback that can be registered by the
> interested platforms in analogy with pm_idle() and pm_power_off(), used for
> preparing the system to power off (needed by ACPI).
> 
> This allows us to drop acpi_sysclass and device_acpi that are only defined in
> order to register the ACPI power off preparation callback, which is needed by
> pm_power_off() registered in a much different way.

Well, the acpi way works with more than one piece of code "listening"
for powerdowns... and does not seem that ugly to me.

Okay, so accessing system_state is not _that_ nice... aha, and perhaps
I understand why 1/2 of this series is right... it called prepare for
S4 even when we had shutdown in /sys/power/disk, right?

Hmm. Okay, I think I can ACK both of these patches, but ACPI people
should have chance to comment, and it probably needs to stay in -mm
for a while.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
