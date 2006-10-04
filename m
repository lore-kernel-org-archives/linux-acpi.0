From: Greg KH <greg@kroah.com>
Subject: Re: [Pcihpd-discuss] [PATCH 1/3] - Altix: Add initial ACPI IO support
Date: Wed, 4 Oct 2006 15:56:49 -0700
Message-ID: <20061004225649.GB14395@kroah.com>
References: <20061004214925.3193.26724.sendpatchset@attica.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:6843 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751210AbWJDW4v (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Oct 2006 18:56:51 -0400
Content-Disposition: inline
In-Reply-To: <20061004214925.3193.26724.sendpatchset@attica.americas.sgi.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: John Keller <jpk@sgi.com>
Cc: akpm@osdl.org, linux-ia64@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wed, Oct 04, 2006 at 04:49:25PM -0500, John Keller wrote:
> First phase in introducing ACPI support to SN.
> In this phase, when running with an ACPI capable PROM,
> the DSDT will define the root busses and all SN nodes
> (SGIHUB, SGITIO). An ACPI bus driver will be registered
> for the node devices, with the acpi_pci_root_driver being
> used for the root busses. An ACPI vendor descriptor is
> now used to pass platform specific information for both
> nodes and busses, eliminating the need for the current
> SAL calls. Also, with ACPI support, SN fixup code is no longer
> needed to initiate the PCI bus scans, as the acpi_pci_root_driver
> does that.

How do these three patches differ from the ones I added to my tree
yesterday?

> Resend #2 - resync with TOT

"TOT"?

thanks,

greg k-h
