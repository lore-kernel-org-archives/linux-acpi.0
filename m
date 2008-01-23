From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 3/4] ACPI: Check for any matching CID when walking
	namespace.
Date: Wed, 23 Jan 2008 09:42:53 -0800
Message-ID: <20080123174253.GA10387@kroah.com>
References: <20080123001807.28190.32648.stgit@bluto.andrew> <20080123001822.28190.3147.stgit@bluto.andrew>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:56644 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757180AbYAWRvQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Jan 2008 12:51:16 -0500
Content-Disposition: inline
In-Reply-To: <20080123001822.28190.3147.stgit@bluto.andrew>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Patterson <andrew.patterson@hp.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, lenb@kernel.org, gregkh@suse.de, matthew@wil.cx, tom.l.nguyen@intel.com, linux-acpi@vger.kernel.org

On Tue, Jan 22, 2008 at 05:18:22PM -0700, Andrew Patterson wrote:
> From: Andrew Patterson <andrew.patterson@hp.com>
> 
> The callback function acpi_ns_get_device_callback called from
> acpi_get_devices() will check CID's if the HID does not match.  This code
> has a bug where it requires that all CIDs match the HID. Changed the code
> so that any CID match will do.
> 
> Signed-off-by: Andrew Patterson <andrew.patterson@hp.com>
> ---
> 
>  drivers/acpi/namespace/nsxfeval.c |   11 ++++++++---
>  1 files changed, 8 insertions(+), 3 deletions(-)

This should probably go through the ACPI tree, not the PCI tree, right?

thanks,

greg k-h
