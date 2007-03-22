From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 6/8] [-mm] ACPI: add ACPI Processor_throttling sysfs
	interface
Date: Thu, 22 Mar 2007 14:12:44 +0800
Message-ID: <1174543964.8833.159.camel@localhost.localdomain>
References: <1174382493.8833.85.camel@localhost.localdomain>
	 <200703220055.38215.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:37314 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751275AbXCVGNV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Mar 2007 02:13:21 -0400
In-Reply-To: <200703220055.38215.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>

On Thu, 2007-03-22 at 00:55 -0400, Len Brown wrote:
> On Tuesday 20 March 2007 05:21, Zhang Rui wrote:
> > From: Zhang Rui <rui.zhang@intel.com>
> > 
> > Add ACPI Processor throttling control sysfs interface.
> > 
> > Attribute	Mode	Description
> > state_count	RO	Maximum throttling state supported by this
> > 			processor.
> > active_state	RW	the current throttling state.
> 
> I like this better than the procfs interface.
> In particular, this is simple levels and doesn't get tangled up in percentages.
> 
> However, this gives the user the impression that they can actually
> change these values and they will stick -- which may be a lie.
> 
> Firmware sometimes messes with throttling behind our back.
> Thermal management can change throttling levels on us
> and it isn't clear what happens to the user-request in that context.
> Finally, something like the p4-clockmod driver can take over throttling
> at the request of the cpufreq sub-system.
> 
> Plus, we have the _TCP enhancements coming from Luming.
> 
Yep. I've discussed with Luming and we only need to add another
attribute like "platform_limit".
It exports a value "n" which means that only Tn~Tmax throttling states
are available currently.

> I think we need to sort through these issues before we
> can possibly propose the appropriate API for exporting
> processor throttling control to user-space.
> 
Agree. Maybe we need a processor throttling state driver just like we do
for processor power/performance state control(cpui_dle and cpu_freq).

Thanks,
Rui
