From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.24-rc1: OOPS at  acpi_battery_update
Date: Mon, 5 Nov 2007 01:18:34 +0100
Message-ID: <200711050118.34610.rjw@sisk.pl>
References: <1193652664.22149.4.camel@localhost> <200711041417.23920.rjw@sisk.pl> <200711050029.09768.listen@selfservix.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:33109 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754288AbXKEABe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 4 Nov 2007 19:01:34 -0500
In-Reply-To: <200711050029.09768.listen@selfservix.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Michael (rabenkind) Brandstetter" <listen@selfservix.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Monday, 5 of November 2007, Michael (rabenkind) Brandstetter wrote:
> Am Sonntag, 4. November 2007 14:17:23 schrieben Sie:
> > On Sunday, 4 of November 2007, Romano Giannetti wrote:
> > > On Fri, 2007-11-02 at 17:08 +0100, Rafael J. Wysocki wrote:
> > > > On Friday, 2 November 2007 00:14, Andrew Morton wrote:
> > > > > On Mon, 29 Oct 2007 11:11:04 +0100
> 
> Hello!
> 
> > > [OOPS removed]
> > >
> > > > > Did any earlier kernels do this?  In other words, do you believe that
> > > > > this is a bug which we added after 2.6.23 was released?
> 
> Yes the kernels prior to 2.6.24-rc1 did not have this bug.
> 
> The oops always appear when i plug in or remove the battery.
> 
> > > Never noticed it before. But it's happening just sometime (I've had it
> > > just two times), so I cannot be sure.
> > >
> > > > This might be the same as
> > > > http://bugzilla.kernel.org/show_bug.cgi?id=9283
> > >
> > > Hmmm... there is too little info for my level in that bug report to
> > > understand if it's the same.
> >
> > Then, please apply the patch from
> >
> > http://bugzilla.kernel.org/attachment.cgi?id=13376&action=view
> >
> > and see if the problem goes away.
> 
> The bug went away on my Dell Latitude C610. I applied the patch on two boxes 
> (2.6.24-rc1-git12) and the haldaemon is not killed and no oops when i remove 
> the battery or plug it in. 
> 
> But on the Portege 3110CT the bug remains.

Well, please create a bug report at http://bugzilla.kernel.org regarding this
bug and place all of the relevant information in there (including what boxes
are fixed by the above patch etc.) Also please add my address to the report's
CC list.

Thanks,
Rafael
