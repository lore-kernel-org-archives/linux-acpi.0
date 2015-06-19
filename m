From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH v2 1/3] acpi: Add acpi_map_pxm_to_online_node()
Date: Thu, 18 Jun 2015 19:16:42 -0600
Message-ID: <1434676602.11808.102.camel@misato.fc.hp.com>
References: <1433891440-3515-1-git-send-email-toshi.kani@hp.com>
	 <1433891440-3515-2-git-send-email-toshi.kani@hp.com>
	 <2008104.uoxDMul6Vd@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g9t5009.houston.hp.com ([15.240.92.67]:45046 "EHLO
	g9t5009.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681AbbFSBQ6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Jun 2015 21:16:58 -0400
In-Reply-To: <2008104.uoxDMul6Vd@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: dan.j.williams@intel.com, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org

On Fri, 2015-06-19 at 02:42 +0200, Rafael J. Wysocki wrote:
> On Tuesday, June 09, 2015 05:10:38 PM Toshi Kani wrote:
> > The kernel initializes CPU & memory's NUMA topology from ACPI
> > SRAT table.  Some other ACPI tables, such as NFIT and DMAR,
> > also contain proximity IDs for their device's NUMA topology.
> > This information can be used to improve performance of these
> > devices.
> > 
> > This patch introduces acpi_map_pxm_to_online_node(), which maps
> > a given pxm to an online node.  This allows ACPI device driver
> > modules to obtain a node from a device proximity ID.  Unlike
> > acpi_map_pxm_to_node(), this interface is guaranteed to return
> > an online node so that the caller module can use the node without
> > dealing with the node status.  A node may be offline when a device
> > proximity ID is unique, SRAT memory entry does not exist, or
> > NUMA is disabled (ex. numa_off on x86).
> > 
> > This patch also moves the pxm range check from acpi_get_node()
> > to acpi_map_pxm_to_node().
 :
> > +/*
> > + * Return an online node from a pxm.  This interface is intended for ACPI
> > + * device drivers that obtain device NUMA topology from ACPI table, but
> > + * do not initialize the node status.
> > + */
> 
> Can you make this a proper kerneldoc, please?  *Especially* that it is an
> exported function.
> 
> The description is a bit terse too in my view.

Agreed. I will update the comment as a proper kerneldoc.

Thanks!
-Toshi

