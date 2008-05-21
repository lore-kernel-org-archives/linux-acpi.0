From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] bay: Exit if notify handler cannot be installed
Date: Wed, 21 May 2008 11:59:44 +0100
Message-ID: <20080521105944.GA30728@srcf.ucam.org>
References: <20080521104547.GA8097@homac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:50256 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755251AbYEULAP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 21 May 2008 07:00:15 -0400
Content-Disposition: inline
In-Reply-To: <20080521104547.GA8097@homac>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, kristen.c.accardi@intel.com, Len Brown <lenb@kernel.org>

On Wed, May 21, 2008 at 12:45:47PM +0200, Holger Macht wrote:
> If acpi_install_notify_handler() for a bay device fails, the bay driver is
> superfluous. Most likely, another driver (like libata) is already caring
> about this device anyway. Furthermore,
> register_hotplug_dock_device(acpi_handle) from the dock driver must not be
> called twice with the same handler. This would result in an endless loop
> consuming 100% of CPU. So clean up and exit.

The bay driver still provides the only mechanism for calling the eject 
methods.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
