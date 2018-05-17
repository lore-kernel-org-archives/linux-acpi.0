From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v9 00/12] Support PPTT for ARM64
Date: Thu, 17 May 2018 18:05:24 +0100
Message-ID: <20180517170523.h7tuvbzdfluuidcz@armageddon.cambridge.arm.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180511235807.30834-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-acpi@vger.kernel.org, Mark.Rutland@arm.com, austinwc@codeaurora.org, tnowicki@caviumnetworks.com, palmer@sifive.com, Will.Deacon@arm.com, linux-riscv@lists.infradead.org, Morten.Rasmussen@arm.com, vkilari@codeaurora.org, Lorenzo.Pieralisi@arm.com, jhugo@codeaurora.org, ahs3@redhat.com, lenb@kernel.org, john.garry@huawei.com, wangxiongfeng2@huawei.com, Dietmar.Eggemann@arm.com, linux-arm-kernel@lists.infradead.org, ard.biesheuvel@linaro.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, hanjun.guo@linaro.org, Sudeep.Holla@arm.com
List-Id: linux-acpi@vger.kernel.org

On Fri, May 11, 2018 at 06:57:55PM -0500, Jeremy Linton wrote:
> Jeremy Linton (12):
>   drivers: base: cacheinfo: move cache_setup_of_node()
>   drivers: base: cacheinfo: setup DT cache properties early
>   cacheinfo: rename of_node to fw_token
>   arm64/acpi: Create arch specific cpu to acpi id helper
>   ACPI/PPTT: Add Processor Properties Topology Table parsing
>   ACPI: Enable PPTT support on ARM64
>   drivers: base cacheinfo: Add support for ACPI based firmware tables
>   arm64: Add support for ACPI based firmware tables
>   arm64: topology: rename cluster_id
>   arm64: topology: enable ACPI/PPTT based CPU topology
>   ACPI: Add PPTT to injectable table list
>   arm64: topology: divorce MC scheduling domain from core_siblings

Queued for 4.18 (without Sudeep's latest property_read_u64 cacheinfo
patch - http://lkml.kernel.org/r/20180517154701.GA20281@e107155-lin; I
can add it separately).

Thanks.

-- 
Catalin
