From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [PATCH 2/2] ACPI-Thermal: Add a 'flag' argument in thermal.c
Date: Thu, 26 Jan 2012 16:14:39 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB5902F813@BGSMSX101.gar.corp.intel.com>
References: <1327595749-17673-1-git-send-email-durgadoss.r@intel.com>
 <1327595749-17673-2-git-send-email-durgadoss.r@intel.com>
 <20120126134256.GA11017@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:33552 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751731Ab2AZQPZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Jan 2012 11:15:25 -0500
In-Reply-To: <20120126134256.GA11017@srcf.ucam.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>


> -----Original Message-----
> From: Matthew Garrett [mailto:mjg59@srcf.ucam.org]
> Sent: Thursday, January 26, 2012 7:13 PM
> To: R, Durgadoss
> Cc: linux-acpi@vger.kernel.org; lenb@kernel.org; Zhang, Rui
> Subject: Re: [PATCH 2/2] ACPI-Thermal: Add a 'flag' argument in thermal.c
> 
> On Thu, Jan 26, 2012 at 10:05:49PM +0530, Durgadoss R wrote:
> > This patch adds a 'flag' argument to the thermal_zone_device_register
> > call in thermal.c.
> 
> Functions and callers must be updated in the same patch - if someone
> bisects to between these two then their build will be broken.

I thought through this.. But there are few drivers in
drivers/platform/x86/, that use these calls. In that case,
how will we merge them ?

Is it ok If I send 'one' patch which includes both ACPI and
Platform driver(s) changes ?

Thanks,
Durga
