From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / video: Fix circular lock dependency issue in the video-detect code
Date: Fri, 14 Aug 2015 11:39:13 +0200
Message-ID: <8673015.1SLQP2GE9q@vostro.rjw.lan>
References: <1439484817-2888-1-git-send-email-hdegoede@redhat.com> <CA+icZUUz1ExQHWo1OhVJSZdLf6mopu4hWURcSd4tGtuyCj4TSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53154 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752133AbbHNJL4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Aug 2015 05:11:56 -0400
In-Reply-To: <CA+icZUUz1ExQHWo1OhVJSZdLf6mopu4hWURcSd4tGtuyCj4TSQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: sedat.dilek@gmail.com
Cc: Hans de Goede <hdegoede@redhat.com>, Aaron Lu <aaron.lu@intel.com>, Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux ACPI <linux-acpi@vger.kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>

On Thursday, August 13, 2015 10:39:08 PM Sedat Dilek wrote:
> 
> --f46d04447e7fc2306e051d3753a5
> Content-Type: text/plain; charset=UTF-8
> 
> On Thu, Aug 13, 2015 at 6:53 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> > Before this commit, the following would happen:
> >
> > a) acpi_video_get_backlight_type() gets called
> > b) acpi_video_get_backlight_type() calls acpi_video_init_backlight_type()
> > c) acpi_video_init_backlight_type() locks its function static init_mutex
> > d) acpi_video_init_backlight_type() calls backlight_register_notifier()
> > e) backlight_register_notifier() takes its notifier-chain lock
> >
> > And when the backlight notifier chain gets called we've:
> >
> > 1) blocking_notifier_call_chain() gets called
> > 2) blocking_notifier_call_chain() takes the notifier-chain lock
> > 3) blocking_notifier_call_chain() calls acpi_video_backlight_notify()
> > 4) acpi_video_backlight_notify() calls acpi_video_get_backlight_type()
> > 5) acpi_video_get_backlight_type() calls acpi_video_init_backlight_type()
> > 6) acpi_video_init_backlight_type() locks its function static init_mutex
> >
> > So in the first call sequence we have:
> >
> > a) init_mutex gets locked
> > b) notifier-chain gets locked
> >
> > and in the second call sequence we have:
> >
> > 1) notifier-chain gets locked
> > 2) init_mutex gets locked
> >
> > And we've a circular locking dependency. This specific locking dependency
> > is fixable without using the big hammer otherwise known as a workqueue,
> > but further analysis shows a similar problem with the backlight notifier
> > chain lock vs register_count_mutex from drivers/acpi/acpi_video.c,
> > and fixing that becomes problematic.
> >
> > So this commit simply fixes this with the big hammer, performance
> > wise this is a non issue as we expect the work to get scheduled
> > exactly zero or one times during normal system use.
> >
> 
> This patch on top of Linux v4.2-rc6 fixes the issue for me.
> 
> Feel free to add my...
> 
>    Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
>    Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

Applied, thanks!

Rafael

