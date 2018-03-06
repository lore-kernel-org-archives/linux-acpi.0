From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v7 04/13] arm64/acpi: Create arch specific cpu to acpi id
 helper
Date: Tue, 6 Mar 2018 17:13:46 +0000
Message-ID: <6763fdb6-92ac-c9cd-0cbc-e641e785b2d9@arm.com>
References: <20180228220619.6992-1-jeremy.linton@arm.com>
 <20180228220619.6992-5-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180228220619.6992-5-jeremy.linton@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>, linux-acpi@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, wangxiongfeng2@huawei.com, vkilari@codeaurora.org, ahs3@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, palmer@sifive.com, lenb@kernel.org, john.garry@huawei.com, austinwc@codeaurora.org, tnowicki@caviumnetworks.com
List-Id: linux-acpi@vger.kernel.org



On 28/02/18 22:06, Jeremy Linton wrote:
> Its helpful to be able to lookup the acpi_processor_id associated
> with a logical cpu. Provide an arm64 helper to do this.
> 

This patch on it's own is good, but it's quite generic and made to look
at it again. Sorry for missing this earlier.

Can we use "per_cpu(processors, cpu)->acpi_id" at call sites instead ?
Or you can make that a generic helper using above expression ?

-- 
Regards,
Sudeep
