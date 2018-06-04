From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v9 00/12] Support PPTT for ARM64
Date: Mon, 4 Jun 2018 16:12:24 +0100
Message-ID: <20180604151223.tmwllb72lqopff2y@armageddon.cambridge.arm.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
 <20180517170523.h7tuvbzdfluuidcz@armageddon.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180517170523.h7tuvbzdfluuidcz@armageddon.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: Mark.Rutland@arm.com, austinwc@codeaurora.org, tnowicki@caviumnetworks.com, palmer@sifive.com, Will.Deacon@arm.com, linux-riscv@lists.infradead.org, wangxiongfeng2@huawei.com, vkilari@codeaurora.org, Lorenzo.Pieralisi@arm.com, jhugo@codeaurora.org, Morten.Rasmussen@arm.com, linux-acpi@vger.kernel.org, lenb@kernel.org, john.garry@huawei.com, ahs3@redhat.com, linux-arm-kernel@lists.infradead.org, ard.biesheuvel@linaro.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, hanjun.guo@linaro.org, Sudeep.Holla@arm.com, Dietmar.Eggemann@arm.com
List-Id: linux-acpi@vger.kernel.org

On Thu, May 17, 2018 at 06:05:24PM +0100, Catalin Marinas wrote:
> On Fri, May 11, 2018 at 06:57:55PM -0500, Jeremy Linton wrote:
> > Jeremy Linton (12):
> >   drivers: base: cacheinfo: move cache_setup_of_node()
> >   drivers: base: cacheinfo: setup DT cache properties early
> >   cacheinfo: rename of_node to fw_token
> >   arm64/acpi: Create arch specific cpu to acpi id helper
> >   ACPI/PPTT: Add Processor Properties Topology Table parsing
> >   ACPI: Enable PPTT support on ARM64
> >   drivers: base cacheinfo: Add support for ACPI based firmware tables
> >   arm64: Add support for ACPI based firmware tables
> >   arm64: topology: rename cluster_id
> >   arm64: topology: enable ACPI/PPTT based CPU topology
> >   ACPI: Add PPTT to injectable table list
> >   arm64: topology: divorce MC scheduling domain from core_siblings
> 
> Queued for 4.18 (without Sudeep's latest property_read_u64 cacheinfo
> patch - http://lkml.kernel.org/r/20180517154701.GA20281@e107155-lin; I
> can add it separately).

I'm going to revert patch 12 in this series (arm64: topology: divorce MC
scheduling domain from core_siblings) until the problem is understood
and a fix proposed and tested. It's likely that the PPTT for arm64 will
only be fully enabled in 4.19.

-- 
Catalin
