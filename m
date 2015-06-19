From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH v3 1/3] acpi: Add acpi_map_pxm_to_online_node()
Date: Fri, 19 Jun 2015 17:11:42 -0600
Message-ID: <1434755502.11808.118.camel@misato.fc.hp.com>
References: <1434737914-18466-1-git-send-email-toshi.kani@hp.com>
	 <1434737914-18466-2-git-send-email-toshi.kani@hp.com>
	 <1533407.DRfAxUaIRz@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t3425.houston.hp.com ([15.201.208.53]:36521 "EHLO
	g4t3425.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990AbbFSXL7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Jun 2015 19:11:59 -0400
In-Reply-To: <1533407.DRfAxUaIRz@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: dan.j.williams@intel.com, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org

On Sat, 2015-06-20 at 01:26 +0200, Rafael J. Wysocki wrote:
> On Friday, June 19, 2015 12:18:32 PM Toshi Kani wrote:
 : 
> > +/**
> > + * acpi_map_pxm_to_online_node - Map proximity ID to on-line node
> > + * @pxm: ACPI proximity ID
> > + *
> > + * This is similar to acpi_map_pxm_to_node(), but always returns an on-line
> > + * node.  When the mapped node from a given proximity ID is off-line, it
> > + * looks up the node distance table and returns the nearest on-line node.
> > + *
> > + * ACPI device drivers, which are called after the NUMA initialization has
> > + * completed in the kernel, can call this interface to obtain their device
> > + * NUMA topology from ACPI tables.  Such drivers do not have to deal with
> > + * off-line nodes.  A node may be off-line when a device proximity ID is
> > + * unique, SRAT memory entry does not exist, or NUMA is disabled, ex.
> > + * "numa=off" on x86.
> 
> The dash in "off-line" and "on-line" is not needed, we spell those things as
> "offline" and "online" as a rule.
> 
> It looks good to me apart from this small detail.

Great!  I will send [PATCH v3-UPDATE 1/3] with this update.

Thanks,
-Toshi

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
