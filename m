From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Do not return true to all kind of Windows OSI calls
Date: Sun, 3 Aug 2008 15:12:31 +0100
Message-ID: <20080803141231.GA14272@srcf.ucam.org>
References: <1217632817.4610.6.camel@hidalgo> <200808021930.05643.trenn@suse.de> <20080802194843.GA1168@srcf.ucam.org> <200808031531.54725.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:47102 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755191AbYHCOMk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Aug 2008 10:12:40 -0400
Content-Disposition: inline
In-Reply-To: <200808031531.54725.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: corsac@debian.org, ak@linux.intel.com, rui.zhang@intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, hmh@debian.org

On Sun, Aug 03, 2008 at 03:31:53PM +0200, Thomas Renninger wrote:

> This is even worse, because that means that Lenovo and everyone
> else who has to add Windows hotfixes to their BIOS and potentially
> have to break their Linux supported OS by that cannot guarantee
> their customers full Linux support (without providing a separate
> Linux BIOS).

That's fine. Where we diverge from the Windows behaviour we already have 
a bug.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
