From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH] ACPI: Disable Windows 8 compatibility for some Lenovo
 ThinkPads
Date: Mon, 11 Feb 2013 13:06:17 -0600
Message-ID: <20130211190617.GH13768@thinkpad-t410>
References: <1360599681-24781-1-git-send-email-seth.forshee@canonical.com>
 <20130211175213.GA25139@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:45898 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758329Ab3BKTGX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Feb 2013 14:06:23 -0500
Content-Disposition: inline
In-Reply-To: <20130211175213.GA25139@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Ben Jencks <ben@bjencks.net>, joeyli <jlee@suse.com>

On Mon, Feb 11, 2013 at 05:52:13PM +0000, Matthew Garrett wrote:
> On Mon, Feb 11, 2013 at 10:21:21AM -0600, Seth Forshee wrote:
> > The AML implementation for brightness control on several ThinkPads
> > contains a workaround to meet a Windows 8 requirement of 101 brightness
> > levels [1]. The implementation is flawed, as only 16 of the brighness
> > values reported by _BCL affect a change in brightness. _BCM silently
> > discards the rest of the values. Disabling Windows 8 compatibility on
> > these machines reverts them to the old behavior, making _BCL only report
> > the 16 brightness levels which actually work. Add a quirk to do this
> > along with a dmi callback to disable Win8 compatibility.
> 
> So the problem is that userspace is writing values that don't happen to 
> be aligned with the values the hardware reacts to, and so nothing gets 
> changed?

Yes. The values are valid according to to _BCL, but _BCM is discarding
any values that aren't contained in an array named BRTW. BRTW is
literally the object returned by _BCL returns for !Windows 2012. Here's
a link to the AML if you'd like to take a look.

http://people.canonical.com/~sforshee/x230-acpi-tables/SSDT1.dsl

Seth

