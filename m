From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] ACPI/IORT: Fix iort_node_get_id() mapping entries
 indexing
Date: Thu, 5 Jan 2017 13:37:22 -0500
Message-ID: <8f8816bf-1a29-ca28-79f3-7bc1b9e9fb5c@codeaurora.org>
References: <20170105182921.8167-1-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170105182921.8167-1-lorenzo.pieralisi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Tomasz Nowicki <tn@semihalf.com>, Nate Watterson <nwatters@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-acpi@vger.kernel.org

On 1/5/2017 1:29 PM, Lorenzo Pieralisi wrote:
> iort_node_get_id() takes an index as input to refer to a specific
> mapping entry in the mapping array to retrieve the id at a specific
> index provided the index is below the total mapping count; currently the
> index is used to retrieve the mapping value from the correct entry but
> not to dereference the correct entry while retrieving the mapping
> output_reference (ie IORT parent pointer), which consequently always
> resolves to the output_reference of the first entry in the mapping
> array.

Maybe, irrelevant but I'm going to throw it out.

Can we somehow break these multiple input and multiple output single
function into smaller and manageable pieces while we are fixing a bug
on it?

These functions seem to do N different things when an input is present
or not. 

I got lost in these function when implementing ITS->SMMU->NC use case.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
