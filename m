From: Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 13/14] ACPI: use PNPID:instance_no as bus_id of ACPI device
Date: Fri, 8 Dec 2006 02:59:46 -0500
Message-ID: <200612080259.46901.len.brown@intel.com>
References: <1165496265.11485.87.camel@localhost.localdomain> <20061207130246.GB19142@redhat.com> <1165539951.18470.5.camel@localhost.localdomain>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42426 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425087AbWLHH4n (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Dec 2006 02:56:43 -0500
In-Reply-To: <1165539951.18470.5.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Dave Jones <davej@redhat.com>, "linux-acpi@vger" <linux-acpi@vger.kernel.org>

> >  > +		memset(acpi_device_bus_id, sizeof(struct acpi_device_bus_id), 0);

> > Bzzzrrrt,  Swapped args. 

> ... I'll refresh the patch.

Better yet, please replace kmalloc+memset with kzalloc.

thanks,
-Len
