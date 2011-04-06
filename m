From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: ACPI blocking I2C driver - Poulsbo
Date: Wed, 6 Apr 2011 19:37:30 +0100
Message-ID: <20110406183730.GA13069@srcf.ucam.org>
References: <67d3106409027af35531bf7b42ca462c.squirrel@host171.canaca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:55393 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756145Ab1DFShd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Apr 2011 14:37:33 -0400
Content-Disposition: inline
In-Reply-To: <67d3106409027af35531bf7b42ca462c.squirrel@host171.canaca.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: simon@mungewell.org
Cc: linux-acpi@vger.kernel.org

On Wed, Apr 06, 2011 at 11:02:23AM -0400, simon@mungewell.org wrote:

> > [  403.809826] ACPI: resource (null) [io  0x0480-0x04bf] conflicts with
> > ACPI region PHO_ [io 0x4bc-0x4bc]
> > [  403.809834] ACPI: If an ACPI driver is available for this device, you
> > should use it instead of the native driver
> > [  403.809921] lpc_sch: probe of 0000:00:1f.0 failed with error -16

Your DSDT contains:

    OperationRegion (PHO, SystemIO, 0x04BC, One)

We won't touch the same region because of the risk of races between the 
firmware and the kernel. Boot with acpi_enforce_resources=lax if you 
think it's safe. Alternatively, if the i2c driver doesn't need the 0x4bc 
address, fix it not to request it.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
