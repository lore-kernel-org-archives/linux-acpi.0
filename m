From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: Disable Windows 8 compatibility for some Lenovo
 ThinkPads
Date: Mon, 11 Feb 2013 19:09:14 +0000
Message-ID: <20130211190914.GA27364@srcf.ucam.org>
References: <1360599681-24781-1-git-send-email-seth.forshee@canonical.com>
 <20130211175213.GA25139@srcf.ucam.org>
 <20130211190617.GH13768@thinkpad-t410>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:41851 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758700Ab3BKTJT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Feb 2013 14:09:19 -0500
Content-Disposition: inline
In-Reply-To: <20130211190617.GH13768@thinkpad-t410>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Seth Forshee <seth.forshee@canonical.com>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Ben Jencks <ben@bjencks.net>, joeyli <jlee@suse.com>

On Mon, Feb 11, 2013 at 01:06:17PM -0600, Seth Forshee wrote:
> On Mon, Feb 11, 2013 at 05:52:13PM +0000, Matthew Garrett wrote:
> > So the problem is that userspace is writing values that don't happen to 
> > be aligned with the values the hardware reacts to, and so nothing gets 
> > changed?
> 
> Yes. The values are valid according to to _BCL, but _BCM is discarding
> any values that aren't contained in an array named BRTW. BRTW is
> literally the object returned by _BCL returns for !Windows 2012. Here's
> a link to the AML if you'd like to take a look.

Right. My concern here is that Windows clearly doesn't trigger the 
issue, and so there's some chance that we'll see similar issues on other 
machines. Disabling Windows 8 compatibility isn't really an option. One 
choice might be to have the ACPI video driver set all intermediate 
values if the system makes the Windows 8 OSI call?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
