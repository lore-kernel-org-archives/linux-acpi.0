From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH] ACPI: Disable Windows 8 compatibility for some Lenovo
 ThinkPads
Date: Wed, 13 Feb 2013 15:49:14 -0600
Message-ID: <20130213214914.GH22867@thinkpad-t410>
References: <1360599681-24781-1-git-send-email-seth.forshee@canonical.com>
 <20130211175213.GA25139@srcf.ucam.org>
 <20130211190617.GH13768@thinkpad-t410>
 <20130211190914.GA27364@srcf.ucam.org>
 <20130213203228.GE22867@thinkpad-t410>
 <20130213205558.GA16559@srcf.ucam.org>
 <511BFFCD.5050008@bjencks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:56859 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760868Ab3BMVtT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Feb 2013 16:49:19 -0500
Content-Disposition: inline
In-Reply-To: <511BFFCD.5050008@bjencks.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ben Jencks <ben@bjencks.net>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, joeyli <jlee@suse.com>

On Wed, Feb 13, 2013 at 04:04:13PM -0500, Ben Jencks wrote:
> >> The other issue with using the cached value is that the hotkeys on these
> >> machines are still going to end up cycling through 101 brightness levels
> >> with 85% of them leaving the brightness unchanged. When there's that
> >> many levels though maybe it makes sense to jump more than one level at a
> >> time.
> > 
> > Right. I'd recommend turning off that functionality and just leaving it 
> > up to userspace. We still seem to be carrying a patch to do that in 
> > Fedora. I thought I had a patch to make this a config option somewhere, 
> > but can't find any sign of it now...
> 
> I think you're looking for video.brightness_switch_enabled=0, which I
> have to use, otherwise a single keypress changes brightness by two levels.

I think that option does what Matthew's suggesting. It would be a simple
change to default it to 0.

