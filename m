From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: Disable Windows 8 compatibility for some Lenovo ThinkPads
Date: Mon, 11 Feb 2013 20:31:08 +0100
Message-ID: <12728315.LFW3i1ALOK@vostro.rjw.lan>
References: <1360599681-24781-1-git-send-email-seth.forshee@canonical.com> <20130211190617.GH13768@thinkpad-t410> <20130211190914.GA27364@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:37248 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759236Ab3BKTYn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Feb 2013 14:24:43 -0500
In-Reply-To: <20130211190914.GA27364@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>, Seth Forshee <seth.forshee@canonical.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Ben Jencks <ben@bjencks.net>, joeyli <jlee@suse.com>, Zhang Rui <rui.zhang@intel.com>

On Monday, February 11, 2013 07:09:14 PM Matthew Garrett wrote:
> On Mon, Feb 11, 2013 at 01:06:17PM -0600, Seth Forshee wrote:
> > On Mon, Feb 11, 2013 at 05:52:13PM +0000, Matthew Garrett wrote:
> > > So the problem is that userspace is writing values that don't happen to 
> > > be aligned with the values the hardware reacts to, and so nothing gets 
> > > changed?
> > 
> > Yes. The values are valid according to to _BCL, but _BCM is discarding
> > any values that aren't contained in an array named BRTW. BRTW is
> > literally the object returned by _BCL returns for !Windows 2012. Here's
> > a link to the AML if you'd like to take a look.
> 
> Right. My concern here is that Windows clearly doesn't trigger the 
> issue, and so there's some chance that we'll see similar issues on other 
> machines. Disabling Windows 8 compatibility isn't really an option. One 
> choice might be to have the ACPI video driver set all intermediate 
> values if the system makes the Windows 8 OSI call?

At least I'd prefer that, so it would be great to verify if it works.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
