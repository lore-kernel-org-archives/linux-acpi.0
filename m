From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 0/2] ACPI: Avoid NULL derefernce when hotplugging
Date: Fri, 29 Jan 2010 10:29:53 -0700
Message-ID: <201001291029.54155.bjorn.helgaas@hp.com>
References: <201001291748.49780.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:37425 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932169Ab0A2R35 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Jan 2010 12:29:57 -0500
In-Reply-To: <201001291748.49780.trenn@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, kristen.c.accardi@intel.com

On Friday 29 January 2010 09:48:49 am Thomas Renninger wrote:
> these are against 2.6.32, but patch fine against latest
> acpi release tree with a small offset.
> 
> Would be great to see them mainline soon.
> The first is IMO a must for stable, eventually both should
> end up there.

I guess I don't object to these.

I still hope that we can someday get rid of these external calls
to acpi_bus_add(), acpi_bus_start(), etc., and instead have the
Linux/ACPI code handle hotplug itself and call the driver .add()
and .remove() methods like normal subsystems do.

But until we can do that, I guess we have to patch up the
current code so it at least doesn't crash.

Bjorn
