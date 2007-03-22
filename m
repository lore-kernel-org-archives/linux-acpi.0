From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 5/8] [-mm] ACPI: add ACPI Processor_core sysfs interface
Date: Thu, 22 Mar 2007 14:05:30 +0800
Message-ID: <1174543530.8833.151.camel@localhost.localdomain>
References: <1174382491.8833.84.camel@localhost.localdomain>
	 <200703220051.32920.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:7575 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965834AbXCVGGI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Mar 2007 02:06:08 -0400
In-Reply-To: <200703220051.32920.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>

On Thu, 2007-03-22 at 00:51 -0400, Len Brown wrote:
> On Tuesday 20 March 2007 05:21, Zhang Rui wrote:
> > From: Zhang Rui <rui.zhang@intel.com>
> > 
> > Add ACPI Processor_core sysfs interface.
> > 
> > Attribute	Mode	Description
> > processor_id	RO
> > acpi_id		RO
> > throttling
> > _control	RO	whether throttling control is supported
> > 			1 = Support, 0 = Not Support.
> > limit_interface	RO	whether processor thermal control is supported
> > 			1 = Support, 0 = Not Support.
> 
> What bad things would happen if we exported none of these?
> 
> I think the answer is "nothing", and thus we shouldn't do it.
> 
Right. 
I'll remove them.

Thanks,
Rui
