From: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 16/19] Altix: Add ACPI SSDT PCI device support (hotplug)
Date: Wed, 20 Dec 2006 00:39:54 -0800
Message-ID: <20061220003954.29452788.akpm@osdl.org>
References: <200612192056.kBJKuMD8010059@shell0.pdx.osdl.net>
	<200612200156.09612.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:46459 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964932AbWLTIkr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Dec 2006 03:40:47 -0500
In-Reply-To: <200612200156.09612.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, jpk@sgi.com, ayoung@sgi.com, greg@kroah.com, tony.luck@intel.com

On Wed, 20 Dec 2006 01:56:09 -0500
Len Brown <lenb@kernel.org> wrote:

> Tony,
> This should probably be sent via your tree.

I assume that it is dependent upon
add-support-for-acpi_load_table-acpi_unload_table_id.patch, in which case
I shouldn't sent this to Tony until acpi->Linus has happened.
