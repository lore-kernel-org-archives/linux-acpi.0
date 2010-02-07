From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Rotating tablet screen updates lid state but doesn't generate
	an event
Date: Sun, 7 Feb 2010 19:15:24 +0000
Message-ID: <20100207191524.GA19835@srcf.ucam.org>
References: <478B660B.3030706@cantab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:40094 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932960Ab0BGTP3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Feb 2010 14:15:29 -0500
Content-Disposition: inline
In-Reply-To: <478B660B.3030706@cantab.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toby Cubitt <t.s.cubitt.98-dated-1200750052.7226bb@cantab.net>
Cc: linux-acpi@vger.kernel.org

On Mon, Jan 14, 2008 at 01:39:23PM +0000, Toby Cubitt wrote:

> So it seems as though acpi is correctly identifying closing the lid and
> rotating the screen into tablet mode as two different types of events,
> but isn't writing anything to /proc/acpi/event for the latter. On the
> other hand, it is generating identical events for both opening the lid
> and rotating the screen back to laptop mode.

It's likely that your firmware sends some other sort of event for this. 
There's nothing in the ACPI spec for handing tablet state changes, so it 
tends to vary by vendor.

> I'm happy to provide more information if it would be helpful, but I have
> no experience at all in helping debug kernel code, so I'm not sure what
> I should be telling you.

Can you send a copy of the output of the acpidump command?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
