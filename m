From: Robert Richter <robert.richter@caviumnetworks.com>
Subject: Re: [PATCH v3 08/12] arm64, numa: rework numa_add_memblk()
Date: Mon, 25 Jan 2016 10:34:29 +0100
Message-ID: <20160125093429.GD24726@rric.localdomain>
References: <1453541967-3744-1-git-send-email-guohanjun@huawei.com>
 <1453541967-3744-9-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1453541967-3744-9-git-send-email-guohanjun@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hanjun Guo <guohanjun@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Steve Capper <steve.capper@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Shannon Zhao <shannon.zhao@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>, linux-arm-kernel@lists.infradead.org, Hanjun Guo <hanjun.guo@linaro.org>
List-Id: linux-acpi@vger.kernel.org

On 23.01.16 17:39:23, Hanjun Guo wrote:
> Rework numa_add_memblk() to update the parameter "u64 size"
> to "u64 end", this will make it consistent with x86 and
> can simplify the code later.

> --- a/arch/arm64/kernel/of_numa.c
> +++ b/arch/arm64/kernel/of_numa.c
> @@ -168,7 +168,7 @@ static int __init early_init_parse_memory_node(unsigned long node)
>  		pr_debug("NUMA-DT:  base = %llx , node = %u\n",
>  				base, nid);
>  
> -		if (numa_add_memblk(nid, base, size) < 0)
> +		if (numa_add_memblk(nid, base, base + size) < 0)

The overall function usage looks more like as it should use size
instead of end. Even in the x86 implementation end is calculated from
base + size. So better change x86 code to use size instead.

Though this might involve to change the interface for
numa_add_memblk_to() for unifcation too.

-Robert
