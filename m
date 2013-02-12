From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH] ACPI: Disable Windows 8 compatibility for some Lenovo
 ThinkPads
Date: Mon, 11 Feb 2013 21:05:15 -0600
Message-ID: <20130212030515.GA4043@ubuntu-mba51>
References: <1360599681-24781-1-git-send-email-seth.forshee@canonical.com>
 <20130211190617.GH13768@thinkpad-t410>
 <20130211190914.GA27364@srcf.ucam.org>
 <12728315.LFW3i1ALOK@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:47291 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466Ab3BLDFX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Feb 2013 22:05:23 -0500
Content-Disposition: inline
In-Reply-To: <12728315.LFW3i1ALOK@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Ben Jencks <ben@bjencks.net>, joeyli <jlee@suse.com>, Zhang Rui <rui.zhang@intel.com>

On Mon, Feb 11, 2013 at 08:31:08PM +0100, Rafael J. Wysocki wrote:
> On Monday, February 11, 2013 07:09:14 PM Matthew Garrett wrote:
> > On Mon, Feb 11, 2013 at 01:06:17PM -0600, Seth Forshee wrote:
> > > On Mon, Feb 11, 2013 at 05:52:13PM +0000, Matthew Garrett wrote:
> > > > So the problem is that userspace is writing values that don't happen to 
> > > > be aligned with the values the hardware reacts to, and so nothing gets 
> > > > changed?
> > > 
> > > Yes. The values are valid according to to _BCL, but _BCM is discarding
> > > any values that aren't contained in an array named BRTW. BRTW is
> > > literally the object returned by _BCL returns for !Windows 2012. Here's
> > > a link to the AML if you'd like to take a look.
> > 
> > Right. My concern here is that Windows clearly doesn't trigger the 
> > issue, and so there's some chance that we'll see similar issues on other 
> > machines. Disabling Windows 8 compatibility isn't really an option. One 

So my take on this is that it's a transition issue. In the case of the
x230 I know that this machine was sold with Windows 7 before Windows 8
came out and that older versions of the firmware don't have the Win8
workaround. I suspect the story is the same with the other models.

> > choice might be to have the ACPI video driver set all intermediate 
> > values if the system makes the Windows 8 OSI call?
> 
> At least I'd prefer that, so it would be great to verify if it works.

I expect it will work, depending on your definition of "works."

The problem with this suggestion is that there are still going to be
instances where a user's desktop says the brightness has changed without
it actually changing. For example, gnome-settings-daemon is going to
break this down into increments of 5, and even with hitting every point
in between some steps aren't going to change the brightness at all.

But if disabling Windows 8 compatibility is out then that may be the
best we can do without resorting to something really ugly.

Seth

