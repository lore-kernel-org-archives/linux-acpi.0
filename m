From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] acpi: Export EDID blocks to the kernel
Date: Fri, 02 Apr 2010 11:19:49 +0800
Message-ID: <1270178389.24064.4534.camel@rzhang1-desktop>
References: <1263323823-11847-1-git-send-email-mjg@redhat.com>
	 <20100330164947.GA27983@srcf.ucam.org>
	 <alpine.LFD.2.00.1003312053220.5062@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:25196 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752588Ab0DBDSr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 Apr 2010 23:18:47 -0400
In-Reply-To: <alpine.LFD.2.00.1003312053220.5062@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, 2010-04-01 at 08:53 +0800, Len Brown wrote:
> On Tue, 30 Mar 2010, Matthew Garrett wrote:
> 
> > On Tue, Jan 12, 2010 at 02:17:03PM -0500, Matthew Garrett wrote:
> > > The ACPI spec includes a provision for hardware to provide EDID via the
> > > ACPI video extension. In the KMS world it's necessary for a way to obtain
> > > this from within the kernel. Add a function that either returns the EDID
> > > for the provided ACPI display ID or the first display of the provided type.
> > > Also add support for ensuring that devices with legacy IDs are supported.
> > > 
> > > Signed-off-by: Matthew Garrett <mjg@redhat.com>
> > 
> > Did this get picked up?
> 
> 
> No, it did not.
> 
> Rui,
> Matthew is proposing adding an API to your driver.
> 

Acked-by: Zhang Rui <rui.zhang@intel.com>

> -Len
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


