From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [patch 2/2] ia64: add driver for ACPI methods to call native firmware
Date: Wed, 12 Sep 2007 05:48:57 -0400
Message-ID: <20070912094857.GD4119@fattire.cabal.ca>
References: <200709111714.57095.bjorn.helgaas@hp.com> <200709111716.47194.bjorn.helgaas@hp.com> <20070912085650.GA3015@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:40050 "EHLO
	stout.engsoc.carleton.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932572AbXILKBV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Sep 2007 06:01:21 -0400
Content-Disposition: inline
In-Reply-To: <20070912085650.GA3015@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-ia64@vger.kernel.org, linux-acpi@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>

On Wed, Sep 12, 2007 at 09:56:51AM +0100, Matthew Garrett wrote:
> On Tue, Sep 11, 2007 at 05:16:46PM -0600, Bjorn Helgaas wrote:
> > +config IA64_HP_AML_NFW
> > +	tristate "Support ACPI AML calls to native firmware"
> 
> The description seems a bit generic for something that's HP specific?
>

It's within arch/ia64/Kconfig, so it will only show up on IA64 boxes...
It's possible that Altix or Intel IA64 boxes will want to make SAL calls
from ACPI, so it looks ok...

--Kyle
