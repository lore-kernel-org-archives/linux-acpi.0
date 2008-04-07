From: nikosapi <me@nikosapi.org>
Subject: Re: Suspend on Lenovo 3000 V200 - Linux 2.6.25rc8
Date: Mon, 7 Apr 2008 18:59:24 -0400
Message-ID: <200804071859.24899.me@nikosapi.org>
References: <3e8fd0440804052010xbe8f59bw3268d8206b97ac3e@mail.gmail.com> <200804071008.33879.me@nikosapi.org> <200804071934.42121.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:62336 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276AbYDGW7R (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Apr 2008 18:59:17 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1506368wah.23
        for <linux-acpi@vger.kernel.org>; Mon, 07 Apr 2008 15:59:17 -0700 (PDT)
In-Reply-To: <200804071934.42121.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On April 7, 2008 13:34:41 Rafael J. Wysocki wrote:
> On Monday, 7 of April 2008, nikosapi wrote:
> > On April 7, 2008 04:58:37 Rafael J. Wysocki wrote:
> > > On Monday, 7 of April 2008, nikosapi wrote:
> > > > On April 6, 2008 19:23:36 Rafael J. Wysocki wrote:
> > > > > On Monday, 7 of April 2008, nikosapi wrote:
> > > > > > On April 6, 2008 16:21:57 Rafael J. Wysocki wrote:
> > > > > > > On Sunday, 6 of April 2008, Nick Nobody wrote:
> > >
> > > [--snip--]
> > >
> > > > > > Hello Rafael,
> > > > > >
> > > > > > I tested with that patch and the problem persists, when the
> > > > > > laptop resumes it locks up (with a black screen). If I add
> > > > > > acpi_apic_instance=2 acpi_osi=Linux as kernel boot options (as
> > > > > > suggested by my dmesg) when it resumes I get back to a virtual
> > > > > > term but I'm not able to log in. After entering my username it
> > > > > > just hangs there.
> > >
> > > Have you tried if doing "echo mem > /sys/power/state" instead of s2ram
> > > works?
> > >
> > > If you have, what graphics adapter is there in your machine?
> > >
> > > Rafael
> > > --
> >
> > Yes, I've been using /sys/power/state to put the machine to sleep ever
> > since you told me.
> >
> > Here's the output of lspci -d 8086:2a02 -vvvxxx
> >
> > 00:02.0 VGA compatible controller: Intel Corporation Mobile GM965/GL960
> > Integrated Graphics Controller (rev 03) (prog-if 00 [VGA controller])
>
> Hm, Intel.  Do you use the i915 driver?
>
> Well, I think that what you see is another form of
> http://bugzilla.kernel.org/show_bug.cgi?id=10319
> so you can add yourself to the CC list in there.
>
> Thanks,
> Rafael

Good news! I was reading through the linux-kernel archives and I found this[1] 
post. It suggested using 2.6.25rc8-git2, I installed git4 and suspend works!

Thanks for your time, if you need anything else just ask.

nick

[1] http://marc.info/?l=linux-kernel&m=120760390231799&w=2
