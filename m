From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] acpi: Disable explicit power state retrieval on fans
Date: Fri, 18 Dec 2009 09:02:32 +0800
Message-ID: <1261098152.27291.32.camel@rzhang1-desktop>
References: <1257883752-2163-1-git-send-email-mjg@redhat.com>
	 <1260503569.27069.326.camel@rzhang1-desktop>
	 <1261036928.27291.21.camel@rzhang1-desktop>
	 <20091217191353.GA11041@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:62633 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750788AbZLRA7n (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Dec 2009 19:59:43 -0500
In-Reply-To: <20091217191353.GA11041@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Fri, 2009-12-18 at 03:13 +0800, Matthew Garrett wrote:
> On Thu, Dec 17, 2009 at 04:02:08PM +0800, Zhang Rui wrote:
> 
> > If the ACPI power state can be got both directly and indirectly,
> > we prefer to get it indirectly.
> 
> I guess this would be fine, but it seems to be a rather bigger change - 
> I'd feel safer limiting it to fans. We might as well give it a go, 
> though.
> 
only ACPI fan and several other devices that invokes
acpi_bus_set/get_power.
If it brings some problems, it won't take us a lot of efforts to debug.
I think it's a good candidate for -rc1.

thanks,
rui


