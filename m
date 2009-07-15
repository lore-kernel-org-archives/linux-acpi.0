From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: add driver for SMBus Control Method Interface
Date: Wed, 15 Jul 2009 15:00:57 +0100
Message-ID: <20090715140057.GB19054@srcf.ucam.org>
References: <20090715060219.GA30514@crane-desktop> <1247651002.4113.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:42362 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754625AbZGOOBC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jul 2009 10:01:02 -0400
Content-Disposition: inline
In-Reply-To: <1247651002.4113.9.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: Crane Cai <crane.cai@amd.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Jul 15, 2009 at 05:43:22PM +0800, ykzhao wrote:
> On Wed, 2009-07-15 at 14:02 +0800, Crane Cai wrote:
> > This driver supports the SMBus Control Method Interface. It needs BIOS declare
> > ACPI control methods via SMBus Control Method Interface Spec.
> It seems that SM bus control is realized in BIOS. And OS can use the
> given control method interface to access it. 
> Will this controller be accessed directly directly BIOS?
> If it can be accessed by BIOS, how to resolve the conflict between BIOS
> and OS?

It's being accessed via ACPI methods, so the vendors have the 
opportunity to implement proper locking.

> In fact we see the conflict on some boxes. The SMbus controller will be
> accessed by BIOS. If the corresponding driver is loaded for the SMBUS
> controller, there exists the potential risk. In such case we will hide
> the SMbus controller or not load the device driver for it.

I don't think that's a risk in this case.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
