From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.24 regression:  hibernation hangs on "Suspending console" in low-battery condition
Date: Fri, 16 Nov 2007 22:55:16 +0100
Message-ID: <200711162255.17014.rjw@sisk.pl>
References: <200711052201.17150.arvidjaar@mail.ru> <200711170001.46710.arvidjaar@mail.ru> <200711162233.52910.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:58182 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761414AbXKPViC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Nov 2007 16:38:02 -0500
In-Reply-To: <200711162233.52910.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Alexey Starikovskiy <astarikovskiy@suse.de>

On Friday, 16 of November 2007, Rafael J. Wysocki wrote:
> On Friday, 16 of November 2007, Andrey Borzenkov wrote:
> > On Sunday 11 November 2007, Rafael J. Wysocki wrote:
> > > On Sunday, 11 of November 2007, Andrey Borzenkov wrote:
> > > > On Sunday 11 November 2007, Rafael J. Wysocki wrote:
> > > > > On Sunday, 11 of November 2007, Andrey Borzenkov wrote:
> > > > > > On Monday 05 November 2007, Andrey Borzenkov wrote:
> > > > > > > Notice "hung" not "hangs". This happened so far only once - when low battery 
> > > > > > > condition triggered suspend to disk. I was not able to reproduce it after 
> > > > > > > this running on AC.
> > > > > > > 
> > > > > > > Just in case it rings the bell for someone. This is not suspend regression 
> > > > > > > reported earlier by Jens - I do not even have SATA nor is using libata 
> > > > > > > drivers.
> > > > > > > 
> > > > > > 
> > > > > > This happened second time, now with 2.6.24-rc2. I have kpowersave configured
> > > > > > to initiate suspend-to-disk on low battery. Suspend-to-disk is initiated,
> > > > > > but system stops after Suspending console line. Suspend image is not created.
> > > > > > 
> > > > > > This did work before although I do not name exact version.
> > > > > > 
> > > > > > I am rather at loss how to proceed further ... any idea? dmesg and config
> > > > > > attached just in case. The problem is that hibernation works when I initiate
> > > > > > it manually ...
> > > > > 
> > > > > Have you tried it with the battery removed?
> > > > > 
> > > > > 
> > > > 
> > > > It works. Subjectively I have relatively long pause after first Suspending console
> > > > message (where it hangs otherwise), according to dmesg timestamp it is about
> > > > 1 second before next messages appear. Also last two times I tried it writeout
> > > > of suspend image was really slow; it was both with and without battery. Reading
> > > > on resume in really in order of magnitude faster.
> > > > 
> > > > But manual STD so far works both on AC (with or without battery) or on battery.
> > > > 
> > > > Of course it is possible that battery gets exhausted during STD, but system
> > > > is not switched off. Rather I would suspect something like ACPI notification
> > > > that comes during freeze ...
> > > 
> > > Frankly, I'm suspecting a deadlock in the ACPI code.
> > > 
> > > Please try to make kpowersave start hibernation a bit earlier and see what
> > > happens.
> > > 
> > > What's your critical time now?
> > > 
> > > 
> > 
> > it was set to 5%. Setting it to 10% makes it work, but it just confirms what I
> > said before - suspend-to-RAM in normal battery conditions (or without battery)
> > works.
> 
> Yes.
> 
> > With 5% threshold I have visible indication of alarm from *firmware* -
> > battery LED flashing. 
> > 
> > Something happens differently when battery is in dangerous state.
> 
> Yes, definitely.
> 
> > I tried patch 
> > 4c41d3ad6544f1c9aec37c441af04f5d0ad3a731 (got from ACPI tree) but it did not
> > change anything. It worked once when I left system on battery with artificial
> > load (find . -exec md5sum in linux tree in a loop) but I suspect it is just
> > because it just triggered limit earlier. (Frankly I do not know which percentage
> > kpowersave computes)
> 
> Well, do we have a bugzilla entry for this issue?

Yes, we have: http://bugzilla.kernel.org/show_bug.cgi?id=9344

Let's use it from now on, please.

Thanks,
Rafael
