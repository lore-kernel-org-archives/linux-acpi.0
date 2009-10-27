From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 1/2] IPMI/ACPI: Locate the IPMI system interface in ACPI namespace
Date: Tue, 27 Oct 2009 09:38:41 -0600
Message-ID: <200910270938.42527.bjorn.helgaas@hp.com>
References: <1256564026-9855-1-git-send-email-yakui.zhao@intel.com> <200910260920.11124.bjorn.helgaas@hp.com> <1256605375.3563.182.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:8714 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755205AbZJ0Pij (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Oct 2009 11:38:39 -0400
In-Reply-To: <1256605375.3563.182.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: "minyard@acm.org" <minyard@acm.org>, "lenb@kernel.org" <lenb@kernel.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Monday 26 October 2009 07:02:55 pm ykzhao wrote:
> In fact you mention two issues about the two patches:
>    1: Load a PNP driver for it to register the IPMI system interface.
> This is about the first patch.
>    2. coding style( for example: comments, the definition about some
> variables).
> 
> For the first issue: Before I start the first patch, I consider using
> the PNP device driver. But I find that it is so complex because of the
> following two points:
>     1. One is that we can't register the IPMI system interface if the
> boot option of "pnpacpi=off" is added. This will also depend on the PNP
> module.

This is not a problem.  It is perfectly acceptable for the IPMI driver
to depend on PNP and PNPACPI in order to claim an ACPI device.  If the
users boots with "pnpacpi=off", we just won't find an IPMI device.
That is the way it works for TPM devices and serial devices described
by ACPI, and IPMI should work the same way.

>     2. The second is that there exist so many cases about the IPMI
> IO/memory resource definition. Maybe there exist both IO/memory resource
> definition for one IPMI device. In such case we can't know which should
> be selected. At the same time we have similar issues about the interrupt
> type. So I decide to parse the IO/memory/interrupt resource
> independently.

This doesn't make any sense.  The fact that an IPMI device might have
a variety of IO/memory/IRQ resources is orthogonal to the question of
whether you should use pnp_register_driver() or acpi_walk_namespace().

PNPACPI parses the IPMI device resources for every ACPI device,
including the IPMI device, before we even know whether there will be
a PNP driver for the device.  It's much easier to look at the PNP
resources and figure out which to use than it is to use
acpi_walk_resources() manually.

The main point is that ipmi_si_intf.c is a device driver, and it should
use the normal driver registration mechanisms.  I think it would be
simplest and clearest to make a few PNP enhancements so it could use
pnp_register_driver(), but even using acpi_bus_register_driver() would
be fine.  Using acpi_walk_namespace() to do everything by hand is just
completely wrong.

Bjorn


