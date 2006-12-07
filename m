From: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH 13/14] ACPI: use PNPID:instance_no as bus_id of ACPI device
Date: Thu, 7 Dec 2006 08:02:46 -0500
Message-ID: <20061207130246.GB19142@redhat.com>
References: <1165496265.11485.87.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:39522 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032189AbWLGNER (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Dec 2006 08:04:17 -0500
Content-Disposition: inline
In-Reply-To: <1165496265.11485.87.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: lenb@kernel.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>

On Thu, Dec 07, 2006 at 08:57:45PM +0800, Zhang Rui wrote:
 > +		memset(acpi_device_bus_id, sizeof(struct acpi_device_bus_id), 0);

Bzzzrrrt,  Swapped args.

		Dave
