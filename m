From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH] ACPI: Disable Windows 8 compatibility for some Lenovo
 ThinkPads
Date: Wed, 13 Feb 2013 16:04:06 -0600
Message-ID: <20130213220406.GJ22867@thinkpad-t410>
References: <1360599681-24781-1-git-send-email-seth.forshee@canonical.com>
 <20130211175213.GA25139@srcf.ucam.org>
 <20130211190617.GH13768@thinkpad-t410>
 <20130211190914.GA27364@srcf.ucam.org>
 <20130213203228.GE22867@thinkpad-t410>
 <20130213205558.GA16559@srcf.ucam.org>
 <20130213214654.GG22867@thinkpad-t410>
 <20130213215435.GA17831@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:56926 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157Ab3BMWEL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Feb 2013 17:04:11 -0500
Content-Disposition: inline
In-Reply-To: <20130213215435.GA17831@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Ben Jencks <ben@bjencks.net>, joeyli <jlee@suse.com>

On Wed, Feb 13, 2013 at 09:54:35PM +0000, Matthew Garrett wrote:
> On Wed, Feb 13, 2013 at 03:46:54PM -0600, Seth Forshee wrote:
> 
> > After every brightness change? Maybe it would be better to just test for
> > this during initialization, then set device->cap._BQC to 0 so we won't
> > use it.
> 
> That would require us to change the backlight during boot, which we 
> don't necessarily want to do. There's also the risk that if we only do 
> the check once it'll correspond to a valid value and we'll get a false 
> positive.

We're already setting the level during boot to check whether or not _BQC
returns brightness values or indexes. We'd obviously have to try several
values to be fairly certain that this bug wasn't present.

