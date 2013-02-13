From: Ben Jencks <ben@bjencks.net>
Subject: Re: [PATCH] ACPI: Disable Windows 8 compatibility for some Lenovo
 ThinkPads
Date: Wed, 13 Feb 2013 16:04:13 -0500
Message-ID: <511BFFCD.5050008@bjencks.net>
References: <1360599681-24781-1-git-send-email-seth.forshee@canonical.com> <20130211175213.GA25139@srcf.ucam.org> <20130211190617.GH13768@thinkpad-t410> <20130211190914.GA27364@srcf.ucam.org> <20130213203228.GE22867@thinkpad-t410> <20130213205558.GA16559@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ve0-f171.google.com ([209.85.128.171]:34948 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869Ab3BMVER (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Feb 2013 16:04:17 -0500
Received: by mail-ve0-f171.google.com with SMTP id b10so1513109vea.2
        for <linux-acpi@vger.kernel.org>; Wed, 13 Feb 2013 13:04:17 -0800 (PST)
In-Reply-To: <20130213205558.GA16559@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Seth Forshee <seth.forshee@canonical.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, joeyli <jlee@suse.com>

On 02/13/2013 03:55 PM, Matthew Garrett wrote:
> On Wed, Feb 13, 2013 at 02:32:28PM -0600, Seth Forshee wrote:
>> On Mon, Feb 11, 2013 at 07:09:14PM +0000, Matthew Garrett wrote:
>>> Right. My concern here is that Windows clearly doesn't trigger the 
>>> issue, and so there's some chance that we'll see similar issues on other 
>>> machines. Disabling Windows 8 compatibility isn't really an option. One 
>>> choice might be to have the ACPI video driver set all intermediate 
>>> values if the system makes the Windows 8 OSI call?

I'm not too familiar with the per-machine tweaks code; would it be
possible to override the SSDT1 table if it's this particular bad one?

>> The (untested) fix I've come up with is to use the cached value for the
>> current brightness rather than asking the firmware. I'm assuming though
>> that acpi_video would be using the cached values already if there wasn't
>> a chance that their changing without its knowledge?
> 
> Yeah. What I'd suggest here is calling _BQC after every change, and if 
> it returns the old value throw a firmware bug message and fall back to 
> using a cached one.

This still has the problem that some changes will have no effect, which
isn't a great user experience.

>> The other issue with using the cached value is that the hotkeys on these
>> machines are still going to end up cycling through 101 brightness levels
>> with 85% of them leaving the brightness unchanged. When there's that
>> many levels though maybe it makes sense to jump more than one level at a
>> time.
> 
> Right. I'd recommend turning off that functionality and just leaving it 
> up to userspace. We still seem to be carrying a patch to do that in 
> Fedora. I thought I had a patch to make this a config option somewhere, 
> but can't find any sign of it now...

I think you're looking for video.brightness_switch_enabled=0, which I
have to use, otherwise a single keypress changes brightness by two levels.

-Ben
