From: "Michael (rabenkind) Brandstetter" <listen@selfservix.org>
Subject: Re: 2.6.24-rc1: OOPS at  acpi_battery_update
Date: Mon, 5 Nov 2007 00:29:08 +0100
Message-ID: <200711050029.09768.listen@selfservix.org>
References: <1193652664.22149.4.camel@localhost> <1194168853.10245.18.camel@rukbat> <200711041417.23920.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.selfservix.org ([87.230.120.200]:34587 "EHLO
	nfs01.selfservix.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753277AbXKDXgH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Nov 2007 18:36:07 -0500
In-Reply-To: <200711041417.23920.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Am Sonntag, 4. November 2007 14:17:23 schrieben Sie:
> On Sunday, 4 of November 2007, Romano Giannetti wrote:
> > On Fri, 2007-11-02 at 17:08 +0100, Rafael J. Wysocki wrote:
> > > On Friday, 2 November 2007 00:14, Andrew Morton wrote:
> > > > On Mon, 29 Oct 2007 11:11:04 +0100

Hello!

> > [OOPS removed]
> >
> > > > Did any earlier kernels do this?  In other words, do you believe that
> > > > this is a bug which we added after 2.6.23 was released?

Yes the kernels prior to 2.6.24-rc1 did not have this bug.

The oops always appear when i plug in or remove the battery.

> > Never noticed it before. But it's happening just sometime (I've had it
> > just two times), so I cannot be sure.
> >
> > > This might be the same as
> > > http://bugzilla.kernel.org/show_bug.cgi?id=9283
> >
> > Hmmm... there is too little info for my level in that bug report to
> > understand if it's the same.
>
> Then, please apply the patch from
>
> http://bugzilla.kernel.org/attachment.cgi?id=13376&action=view
>
> and see if the problem goes away.

The bug went away on my Dell Latitude C610. I applied the patch on two boxes 
(2.6.24-rc1-git12) and the haldaemon is not killed and no oops when i remove 
the battery or plug it in. 

But on the Portege 3110CT the bug remains.

greetz Michael :))
-- 
Duisburger Linux User Group
Free Software Foundation Europe

  /"\        ASCII Ribbon Campaign
  \ /        No HTML/RTF in email
   x         No Word docs in email
  / \        Respect for open standards
