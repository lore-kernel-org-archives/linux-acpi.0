From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] acpi: Export EDID blocks to the kernel
Date: Wed, 31 Mar 2010 20:53:59 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1003312053220.5062@localhost.localdomain>
References: <1263323823-11847-1-git-send-email-mjg@redhat.com>
 <20100330164947.GA27983@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:14754 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755663Ab0DAAyR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Mar 2010 20:54:17 -0400
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L0600BD0AI1B6C2@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 31 Mar 2010 19:54:06 -0500 (CDT)
In-reply-to: <20100330164947.GA27983@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org


On Tue, 30 Mar 2010, Matthew Garrett wrote:

> On Tue, Jan 12, 2010 at 02:17:03PM -0500, Matthew Garrett wrote:
> > The ACPI spec includes a provision for hardware to provide EDID via the
> > ACPI video extension. In the KMS world it's necessary for a way to obtain
> > this from within the kernel. Add a function that either returns the EDID
> > for the provided ACPI display ID or the first display of the provided type.
> > Also add support for ensuring that devices with legacy IDs are supported.
> > 
> > Signed-off-by: Matthew Garrett <mjg@redhat.com>
> 
> Did this get picked up?


No, it did not.

Rui,
Matthew is proposing adding an API to your driver.

-Len

