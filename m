From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch] PNP: disable Supermicro H8DCE motherboard resources that overlap SATA BARs
Date: Tue, 22 Jan 2008 09:37:53 -0700
Message-ID: <200801220937.56488.bjorn.helgaas@hp.com>
References: <200801171603.20987.bjorn.helgaas@hp.com> <20080122014216.f59b486c.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:41882 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752051AbYAVQhJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Jan 2008 11:37:09 -0500
In-Reply-To: <20080122014216.f59b486c.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-acpi@vger.kernel.org, jeff@garzik.org, mhall@mhcomputing.net, hancockr@shaw.ca, wriede@riede.org, karl.bellve@umassmed.edu, jonstanley@gmail.com

On Tuesday 22 January 2008 02:42:16 am Andrew Morton wrote:
> > On Thu, 17 Jan 2008 16:03:18 -0700 Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> > +static void quirk_supermicro_h8dce_system(struct pnp_dev *dev)
> 
> hm.  If you trace back through the callchain here is seems that large
> amounts of the pnp code could be made __init/__initdata.  The two callers
> of pnp_add_device() are __init and afaict they're the only callers of the
> quirk code?

Yes, much of the PNP code could currently be __init.  But someday, we
should be able to handle hot-plug of ACPI devices, and some of those
will appear as PNPACPI devices.  We could at least mark stuff __devinit,
I guess.

Bjorn
