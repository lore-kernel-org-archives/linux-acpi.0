From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Explicitly disable BT radio using rfkill interface on
	suspend
Date: Tue, 19 May 2009 17:33:33 +0100
Message-ID: <20090519163333.GA17189@srcf.ucam.org>
References: <4A11C126.1000704@dell.com> <1242710064.3147.4.camel@localhost.localdomain> <20090519090610.GA29967@srcf.ucam.org> <200905191447.34000.oliver@neukum.org> <20090519125853.GA12483@srcf.ucam.org> <4A12DEA8.4060305@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:43769 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136AbZESQdh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 May 2009 12:33:37 -0400
Content-Disposition: inline
In-Reply-To: <4A12DEA8.4060305@dell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: Oliver Neukum <oliver@neukum.org>, Marcel Holtmann <marcel@holtmann.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, May 19, 2009 at 11:30:32AM -0500, Mario Limonciello wrote:
> Hi Guys:
> 
> Matthew Garrett wrote:
> > On Tue, May 19, 2009 at 02:47:33PM +0200, Oliver Neukum wrote:
> >   
> >
> > It doesn't seem to for Mario, otherwise this patch wouldn't change 
> > anything.
> >
> >   
> During S3, when power gets cut, the device is reset and the radio
> logical device no longer shows up.  At no point do either of the USB
> keyboard/mouse devices stop showing up on the bus.  Henceforth, there is
> no event for udev to trigger from when a mouse or keyboard gets
> added/removed.

I thought all USB devices got reenumerated on resume?
-- 
Matthew Garrett | mjg59@srcf.ucam.org
