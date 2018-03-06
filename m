From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v7 08/13] arm64: Add support for ACPI based firmware
 tables
Date: Tue, 6 Mar 2018 17:23:28 +0000
Message-ID: <362fcf8a-44f8-7eb5-0f17-a7763f6236e4@arm.com>
References: <20180228220619.6992-1-jeremy.linton@arm.com>
 <20180228220619.6992-9-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180228220619.6992-9-jeremy.linton@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>, linux-acpi@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, wangxiongfeng2@huawei.com, vkilari@codeaurora.org, ahs3@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, palmer@sifive.com, lenb@kernel.org, john.garry@huawei.com, austinwc@codeaurora.org, tnowicki@caviumnetworks.com
List-Id: linux-acpi@vger.kernel.org



On 28/02/18 22:06, Jeremy Linton wrote:
> The /sys cache entries should support ACPI/PPTT generated cache
> topology information. Lets detect ACPI systems and call
> an arch specific cache_setup_acpi() routine to update the hardware
> probed cache topology.
> 
> For arm64, if ACPI is enabled, determine the max number of cache
> levels and populate them using the PPTT table if one is available.
> 

I fail to understand the kbuild failure report association with this
patch(most likely the previous patch could be culprit, I am looking at
it in detail now), but for this patch

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
