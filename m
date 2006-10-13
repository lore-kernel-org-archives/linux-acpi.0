From: "Kaburlasos, Nikos" <nikos.kaburlasos@intel.com>
Subject: RE: USB suspend/resume in linux
Date: Fri, 13 Oct 2006 07:37:30 -0700
Message-ID: <0FB24CC078F78248B19595A43F00E01FD92DF3@fmsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:15801 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1750904AbWJMOhj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Oct 2006 10:37:39 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: trenn@suse.de, linux-acpi@vger.kernel.org

Alan, will the 2.6.19-rc1 fix you mention also place USB controllers in
D3 (after all the ports under them are in suspend) to save a bit of
extra power?
Nikos Kaburlasos


-----Original Message-----
From: Alan Stern [mailto:stern@rowland.harvard.edu] 
Sent: Friday, October 13, 2006 7:19 AM
To: Rafael J. Wysocki
Cc: trenn@suse.de; Kaburlasos, Nikos; linux-acpi@vger.kernel.org
Subject: Re: USB suspend/resume in linux

On Fri, 13 Oct 2006, Rafael J. Wysocki wrote:

> On Friday, 13 October 2006 10:39, Thomas Renninger wrote:
> > On Thu, 2006-10-12 at 22:54 -0700, Kaburlasos, Nikos wrote:
> > > Does anyone know whether the linux USB drivers support the suspend
> > > feature on idle USB ports (i.e. the port has been idle for
sometime and
> > > so the driver transitions it in to a low-power 'suspend' state)
while
> > > the system is active and in S0 state? As far as I know, Windows
don't
> > > support that, I was wondering if linux does.
> > > 
> > > Please note, I have no background on linux or in OS programming (I
am a
> > > hardware guy), so please be gentle with the level of technical
detail in
> > > your response :-)
> > 
> > AFAIK linux is not doing that.
> > Therefore the ohci (also uhci?) drivers need to poll the ports quite
> > often even there is no device attached. This makes C-states less
> > efficient (what should save more power than the suspended USB
ports). I
> > thought Windows is doing that, I at least heard Mac OS is doing it
like
> > that, but I don't know for sure.
> > The proper solution to avoid polling should be to suspend idle
ports,
> > stop polling and wait for some kind of resume/attach event, but
AFAIK
> > nobody really works on that. Would be nice if someone gives this a
> > try...
> 
> Alan Stern has been working on USB autosuspend for quite some time
> and there are some patches in -mm and in the recent mainline, AFAICT.

Rafael is right.  2.6.19-rc1 already contains code that will suspend
ports
if the attached device doesn't have a driver.  Under testing now is a
patch to suspend ports when the attached device is idle, stop polling
root-hub ports, and stop DMA activity (which is even worse than polling
at keeping the processor out of low-power C states).

Alan Stern
