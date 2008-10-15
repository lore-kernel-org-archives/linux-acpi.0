From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI suspend: Blacklist HP xw4600 Workstation for old code ordering
Date: Wed, 15 Oct 2008 23:20:05 +0200
Message-ID: <200810152320.06167.rjw@sisk.pl>
References: <200810142254.07024.rjw@sisk.pl> <200810151605.35883.rjw@sisk.pl> <20081015141526.GA5633@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54299 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753472AbYJOVQH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Oct 2008 17:16:07 -0400
In-Reply-To: <20081015141526.GA5633@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, John Brown <john.brown3@hp.com>

On Wednesday, 15 of October 2008, Matthew Garrett wrote:
> On Wed, Oct 15, 2008 at 04:05:35PM +0200, Rafael J. Wysocki wrote:
> > On Wednesday, 15 of October 2008, Matthew Garrett wrote:
> > > I think trying to work out what would be more useful than just adding it to
> > > a blacklist. 
> > 
> > Well, machines that require the "old" ordering are simply broken, because
> > you just can't assume that specific devices are not in D3 before you
> > execute _PTS.
> > 
> > IOW, we aren't doing anything wrong and the BIOS is buggy.
> 
> So how does Windows cope with this?

I don't know. :-(

One possible explanation is that the device causing the trouble is not put
into D3 at all during suspend, but I'm speculating here.

Thanks,
Rafael
