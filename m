From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] pnp: add PNP resource range checking function
Date: Tue, 14 Apr 2009 15:55:05 -0700
Message-ID: <20090414155505.0c2b619f@hobbes>
References: <20090414124618.0dd9f536@hobbes>
	<200904141653.11884.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-152.bluehost.com ([67.222.39.32]:57492 "HELO
	outbound-mail-152.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750839AbZDNXBs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Apr 2009 19:01:48 -0400
In-Reply-To: <200904141653.11884.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, intel-gfx@lists.freedesktop.org

On Tue, 14 Apr 2009 16:53:11 -0600
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> On Tuesday 14 April 2009 01:46:18 pm Jesse Barnes wrote:
> > This patch adds a new export from the ACPI PNP core,
> > is_acpi_pnp_reserved, which is intended for use by drivers to check
> > whether a given range is already reserved (and therefore likely
> > safe to use) or not (indicating that new resource space should
> > probably be allocated).
> 
> This doesn't really need to be ACPI-specific, does it?  And can't
> you use the pre-parsed resources in pnp_dev->resources?  And wouldn't
> you just look at all resources for all PNP devices, not just the
> PNP0C01/2 ones?
> 
> Sorry I don't have time to code up an example right now; maybe next
> week, though, if you remind me :-)


Sure, that all sounds reasonable...  I'll try to remind you.  :)

-- 
Jesse Barnes, Intel Open Source Technology Center
