From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2] ACPI/IORT: Fix iort_node_get_id() mapping entries
 indexing
Date: Fri, 3 Feb 2017 08:57:31 +0000
Message-ID: <20170203085731.GA30745@red-moon>
References: <20170110120020.17867-1-lorenzo.pieralisi@arm.com>
 <5893E8ED.1010107@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44848 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752217AbdBCIza (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 3 Feb 2017 03:55:30 -0500
Content-Disposition: inline
In-Reply-To: <5893E8ED.1010107@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Sinan Kaya <okaya@codeaurora.org>, Tomasz Nowicki <tn@semihalf.com>, Nate Watterson <nwatters@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Fri, Feb 03, 2017 at 10:20:29AM +0800, Hanjun Guo wrote:
> On 01/10/2017 08:00 PM, Lorenzo Pieralisi wrote:
> >Commit 618f535a6062 ("ACPI/IORT: Add single mapping function")
> >introduced a function (iort_node_get_id()) to retrieve ids for IORT
> >named components.
> >
> >The iort_node_get_id() takes an index as input to refer to a specific
> >mapping entry in the named component IORT node mapping array.
> >
> >For a mapping entry at a given index, iort_node_get_id() should return
> >the id value (through the id_out function parameter) and the IORT node
> >output_reference (through function return value) the given mapping entry
> >refers to.
> >
> >Technically output_reference values may differ for different map
> >entries, (see diagram below - mapped id values may refer to different eg
> >IORT SMMU nodes; the kernel may not be able to handle different
> >output_reference values for a given named component but the IORT kernel
> >layer should still report the IORT mappings as reported by firmware) but
> >current code in iort_node_get_id() fails to use the index function
> >parameter to return the correct output_reference value (ie it always
> >returns the output_reference value of the first entry in the mapping
> >array whilst using the index correctly to retrieve the id value from the
> >respective entry).
> >
> >	|----------------------|
> >	|     named component  |
> >	|----------------------|
> >	|      map entry[0]    |
> >	|----------------------|
> >	|       id value       |
> >	| output_reference----------------> eg SMMU 1
> >	|----------------------|
> >	|      map entry[1]    |
> >	|----------------------|
> >	|       id value       |
> >	| output_reference----------------> eg SMMU 2
> >	|----------------------|
> >		    .
> >		    .
> >		    .
> >	|----------------------|
> >	|      map entry[N]    |
> >	|----------------------|
> >	|       id value       |
> >	| output_reference----------------> eg SMMU 1
> >	|----------------------|
> >
> >Consequently the iort_node_get_id() function always returns the IORT
> >node pointed at by the output_reference value of the first named
> >component mapping array entry, irrespective of the index parameter,
> >which is a bug.
> >
> >Update the map array entry pointer computation in iort_node_get_id() to
> >take into account the index value, fixing the issue.
> >
> >Fixes: 618f535a6062 ("ACPI/IORT: Add single mapping function")
> >Reported-by: Hanjun Guo <hanjun.guo@linaro.org>
> >Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
> >Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >Cc: Hanjun Guo <hanjun.guo@linaro.org>
> >Cc: Sinan Kaya <okaya@codeaurora.org>
> >Cc: Tomasz Nowicki <tn@semihalf.com>
> >Cc: Nate Watterson <nwatters@codeaurora.org>
> >Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >---
> >v1 -> v2:
> >	- Updated/improved commit log
> >	- Added review tags
> 
> Forgot to mention that I tested this patch on Hisilicon
> D03,
> 
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> 
> BTW, Lorenzo, Rafael, since it's a bugfix, can this be merged into
> 4.10-rc7?

Yes, I thought Rafael picked it up already (I can't see it in
patchwork any longer).

This one from Dan:

https://patchwork.kernel.org/patch/9521003/

should get in -rc7 too, we should have both fixes in before v4.10
is released.

Rafael can you send them both for -rc7 please ?

Thanks,
Lorenzo
