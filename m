From: "Darrick J. Wong" <djwong@us.ibm.com>
Subject: Re: [patch 6/8] hwmon driver for ACPI 4.0 power meters
Date: Wed, 24 Nov 2010 15:21:59 -0800
Message-ID: <20101124232159.GX14383@tux1.beaverton.ibm.com>
References: <200909181941.n8IJf91g002548@imap1.linux-foundation.org> <20101124213936.GA9829@srcf.ucam.org>
Reply-To: djwong@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139]:39961 "EHLO e9.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751367Ab0KXXWA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Nov 2010 18:22:00 -0500
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id oAOMxv2T021173
	for <linux-acpi@vger.kernel.org>; Wed, 24 Nov 2010 17:59:59 -0500
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 1C06F72804D
	for <linux-acpi@vger.kernel.org>; Wed, 24 Nov 2010 18:21:59 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id oAONLwxe408456
	for <linux-acpi@vger.kernel.org>; Wed, 24 Nov 2010 18:21:58 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id oAONLwFg028416
	for <linux-acpi@vger.kernel.org>; Wed, 24 Nov 2010 18:21:58 -0500
Content-Disposition: inline
In-Reply-To: <20101124213936.GA9829@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: akpm@linux-foundation.org, lenb@kernel.org, linux-acpi@vger.kernel.org, pavel@ucw.cz, rui.zhang@intel.com

On Wed, Nov 24, 2010 at 09:39:36PM +0000, Matthew Garrett wrote:
> On Fri, Sep 18, 2009 at 12:41:09PM -0700, akpm@linux-foundation.org wrote:
> 
> > This driver exposes ACPI 4.0 compliant power meters as hardware monitoring
> > devices.  This second revision of the driver also exports the ACPI string
> > info as sysfs attributes, a list of the devices that the meter measures,
> > and will send ACPI notifications over the ACPI netlink socket.  This
> > latest revision only enables the power capping controls if it can be
> > confirmed that the power cap can be enforced by the hardware and explains
> > how the notification interfaces work.
> 
> I know I'm a bit late on this, but what do you mean by "it can be 
> confirmed that the power cap can be enforced by the hardware"? Isn't 
> that what bit 2 of the capabilities list means?

As I recall, Pavel had an objection that it wasn't clear to him that ACPI
advertising a capping ability necessarily meant that the platform hardware
would actually _enforce_ that cap, so I put in a DMI hook so that the cap only
appears on systems where ACPI advertises the ability /and/ someone can verify
that it's enforced outside software (either by patching the DMI table or by
supplying a module parameter).

I guess we were afraid that someone would build an ACPI power meter and then
require software to read the cap out of ACPI and enforce it(??) though I can't
find a link to that discussion.  I'll just attach it below, since the marc.info
archive of mm-commits doesn't seem to have caught it.

--D

On Thu 2009-08-20 14:37:55, Darrick J. Wong wrote:
> On Thu, Aug 20, 2009 at 11:15:57PM +0200, Pavel Machek wrote:
> > Hi!
> > 
> > > +power[1-*]_cap			If power use rises above this limit, the
> > > +				system should take action to reduce power use.
> > > +				A poll notification is sent to this file if the
> > > +				cap is changed by the hardware.
> > 
> > This one needs better documentation, I'd say. Who should take action?
> > What action? What happens if this is ignored? Hardware can change it;
> > does that mean we now have mandatory new daemon watching this?
> 
> Hmm, well, I was hoping the note for power*_alarm would suffice, but I guess I
> could explicitly state that non-specific Bad Things may happen to the computer
> if software ignores overpower situations.  From what I've seen of
> hardware-based monitor/cap systems, however, the hardware will usually take
> action if it doesn't observe the software making changes.
> 
> Of course, if the hw can manage everything, then no daemon's necessary.  If it
> doesn't, then one most probably is required.  Unfortunately that leaves us with
> "Contact your vendor to find out".  Not terribly satisfying. :(

Not satisfying, right. Is it possible to remove that feature from
current patches until the situation is clear?

Requiring a daemon for safe operation of the system would be huge step
back...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

On Fri 2009-08-21 11:47:18, Darrick J. Wong wrote:
> On Fri, Aug 21, 2009 at 11:19:40AM +0200, Pavel Machek wrote:
> 
> > > Of course, if the hw can manage everything, then no daemon's necessary.  If it
> > > doesn't, then one most probably is required.  Unfortunately that leaves us with
> > > "Contact your vendor to find out".  Not terribly satisfying. :(
> > 
> > Not satisfying, right. Is it possible to remove that feature from
> > current patches until the situation is clear?
> 
> Which feature, specifically?  Everything related to the cap, or just the
> notification?  I doubt that we'll ever be able to clarify this
> question for all

Everything related to the cap. 

> systems other than to implement a whitelist or something.  Perhaps it would not
> be so bad to have a "power1_cap_enforcer" file that tells you if the cap is
> done in hw, if it's expected that the OS must do capping, or if the kernel
> simply has no idea.  But I've observed resistance to whitelists in the kernel,
> so I'm not sure that would fly.

Well, user<->kernel interface that we do not understand is bad idea,
too. whitelist would be preferable to _that_.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
