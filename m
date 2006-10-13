From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: USB suspend/resume in linux
Date: Fri, 13 Oct 2006 10:19:25 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0610131016150.6460-100000@iolanthe.rowland.org>
References: <200610131328.40857.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:62991 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750855AbWJMOT2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Oct 2006 10:19:28 -0400
In-Reply-To: <200610131328.40857.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: trenn@suse.de, "Kaburlasos, Nikos" <nikos.kaburlasos@intel.com>, linux-acpi@vger.kernel.org

On Fri, 13 Oct 2006, Rafael J. Wysocki wrote:

> On Friday, 13 October 2006 10:39, Thomas Renninger wrote:
> > On Thu, 2006-10-12 at 22:54 -0700, Kaburlasos, Nikos wrote:
> > > Does anyone know whether the linux USB drivers support the suspend
> > > feature on idle USB ports (i.e. the port has been idle for sometime and
> > > so the driver transitions it in to a low-power 'suspend' state) while
> > > the system is active and in S0 state? As far as I know, Windows don't
> > > support that, I was wondering if linux does.
> > > 
> > > Please note, I have no background on linux or in OS programming (I am a
> > > hardware guy), so please be gentle with the level of technical detail in
> > > your response :-)
> > 
> > AFAIK linux is not doing that.
> > Therefore the ohci (also uhci?) drivers need to poll the ports quite
> > often even there is no device attached. This makes C-states less
> > efficient (what should save more power than the suspended USB ports). I
> > thought Windows is doing that, I at least heard Mac OS is doing it like
> > that, but I don't know for sure.
> > The proper solution to avoid polling should be to suspend idle ports,
> > stop polling and wait for some kind of resume/attach event, but AFAIK
> > nobody really works on that. Would be nice if someone gives this a
> > try...
> 
> Alan Stern has been working on USB autosuspend for quite some time
> and there are some patches in -mm and in the recent mainline, AFAICT.

Rafael is right.  2.6.19-rc1 already contains code that will suspend ports
if the attached device doesn't have a driver.  Under testing now is a
patch to suspend ports when the attached device is idle, stop polling
root-hub ports, and stop DMA activity (which is even worse than polling
at keeping the processor out of low-power C states).

Alan Stern

