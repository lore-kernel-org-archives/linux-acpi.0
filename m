From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] ACPI/IORT: Fix iort_node_get_id() mapping entries
 indexing
Date: Fri, 6 Jan 2017 09:48:26 +0000
Message-ID: <20170106094811.GA8587@red-moon>
References: <20170105182921.8167-1-lorenzo.pieralisi@arm.com>
 <8f8816bf-1a29-ca28-79f3-7bc1b9e9fb5c@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40958 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965918AbdAFJ4I (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 6 Jan 2017 04:56:08 -0500
Content-Disposition: inline
In-Reply-To: <8f8816bf-1a29-ca28-79f3-7bc1b9e9fb5c@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Tomasz Nowicki <tn@semihalf.com>, Nate Watterson <nwatters@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Thu, Jan 05, 2017 at 01:37:22PM -0500, Sinan Kaya wrote:
> On 1/5/2017 1:29 PM, Lorenzo Pieralisi wrote:
> > iort_node_get_id() takes an index as input to refer to a specific
> > mapping entry in the mapping array to retrieve the id at a specific
> > index provided the index is below the total mapping count; currently the
> > index is used to retrieve the mapping value from the correct entry but
> > not to dereference the correct entry while retrieving the mapping
> > output_reference (ie IORT parent pointer), which consequently always
> > resolves to the output_reference of the first entry in the mapping
> > array.
> 
> Maybe, irrelevant but I'm going to throw it out.
> 
> Can we somehow break these multiple input and multiple output single
> function into smaller and manageable pieces while we are fixing a bug
> on it?

No. This is a fix for code currently in the kernel that is going
to be released in a few weeks, it is not a clean-up, please let me
know if it works on your platforms.

> These functions seem to do N different things when an input is present
> or not. 
> 
> I got lost in these function when implementing ITS->SMMU->NC use case.

Hanjun is carrying out the clean-up of the mapping functions as part of
its platform MSIs patchset, I followed up on that already to achieve
what you request above.

Thanks,
Lorenzo
