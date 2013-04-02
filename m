From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH] ACPI: Disable Windows 8 compatibility for some Lenovo
 ThinkPads
Date: Tue, 2 Apr 2013 08:00:00 -0500
Message-ID: <20130402130000.GA12381@thinkpad-t410>
References: <1360599681-24781-1-git-send-email-seth.forshee@canonical.com>
 <5158E8A0.3050904@intel.com>
 <20130401130340.GA3269@thinkpad-t410>
 <515AA007.1050305@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:54830 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760800Ab3DBNAJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Apr 2013 09:00:09 -0400
Content-Disposition: inline
In-Reply-To: <515AA007.1050305@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Ben Jencks <ben@bjencks.net>, joeyli <jlee@suse.com>, Matthew Garrett <mjg59@srcf.ucam.org>

On Tue, Apr 02, 2013 at 05:08:23PM +0800, Aaron Lu wrote:
> On 04/01/2013 09:03 PM, Seth Forshee wrote:
> > On Mon, Apr 01, 2013 at 09:53:36AM +0800, Aaron Lu wrote:
> >> On 02/12/2013 12:21 AM, Seth Forshee wrote:
> >>> The AML implementation for brightness control on several ThinkPads
> >>> contains a workaround to meet a Windows 8 requirement of 101 brightness
> >>> levels [1]. The implementation is flawed, as only 16 of the brighness
> >>> values reported by _BCL affect a change in brightness. _BCM silently
> >>> discards the rest of the values. Disabling Windows 8 compatibility on
> >>> these machines reverts them to the old behavior, making _BCL only report
> >>> the 16 brightness levels which actually work. Add a quirk to do this
> >>> along with a dmi callback to disable Win8 compatibility.
> >>
> >> If we disable the _BQC(i.e. set cap._BQC=0) for these systems, will the
> >> problem go away? If so, I think perhaps we can put these systems into a
> >> _BQC quirk table and set cap._BQC=0 for them.
> > 
> > That helps a little, but we're still left with only 16 of the 101
> > brightness levels causing any change in brightness. The firmware isn't
> > rounding the "bad" values or anything like that; it just silently
> > ignores them.
> 
> OK, and if GUI tool like g-s-d decides to go some more steps when
> adjusting backlight level, it may always choose the non-functional
> values. Hmm, doesn't seem to be an usable way then.

Exactly.

> I really wondered, how Windows handled this, it should have the same
> problem, unless they are not using the acpi video interface?

I can only guess.

I think I remember reading that Windows 8 does smooth backlight
transitions, so it may well hit every intermediate brightness value.
Lenovo could also be supplying a driver which rounds values to the
nearest working value or uses some other interface or something else.

> > I submitted a second set of patches [1] which writes all intermediate
> > values between the old and new brightness values and disables _BQC for
> > these machines (empirically rather than using a quirk table), though no
> > one seems to be interested in reviewing them.
> 
> Suppose we are at level 100, and the user sets the target level to be
> 20, then we will need to call _BCM 80 times?

Yes. And on machines where _BQC actually returns legitimate values it
will get called 80 times as well. On these Lenovo's we'd quickly
determine that _BQC doesn't work and stop trying to use it however.

Seth
