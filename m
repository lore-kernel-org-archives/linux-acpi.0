From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch] PNP: disable Supermicro H8DCE motherboard resources
 that overlap SATA BARs
Date: Tue, 22 Jan 2008 01:42:16 -0800
Message-ID: <20080122014216.f59b486c.akpm@linux-foundation.org>
References: <200801171603.20987.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:45893 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755671AbYAVJmm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Jan 2008 04:42:42 -0500
In-Reply-To: <200801171603.20987.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-acpi@vger.kernel.org, jeff@garzik.org, mhall@mhcomputing.net, hancockr@shaw.ca, wriede@riede.org, karl.bellve@umassmed.edu, jonstanley@gmail.com

> On Thu, 17 Jan 2008 16:03:18 -0700 Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> +static void quirk_supermicro_h8dce_system(struct pnp_dev *dev)

hm.  If you trace back through the callchain here is seems that large
amounts of the pnp code could be made __init/__initdata.  The two callers
of pnp_add_device() are __init and afaict they're the only callers of the
quirk code?

Anyway.  It's not a lot of fun to pick through all that and it's easy to
break things.

