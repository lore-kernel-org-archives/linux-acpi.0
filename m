From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v8 11/13] arm64: topology: enable ACPI/PPTT based CPU
 topology
Date: Tue, 1 May 2018 15:46:22 +0100
Message-ID: <ab8357f0-61d5-2996-46ca-5bc5d3e097cf@arm.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
 <20180425233121.13270-12-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180425233121.13270-12-jeremy.linton@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>, linux-acpi@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org, Lorenzo.Pieralisi@arm.com, hanjun.guo@linaro.org, rjw@rjwysocki.net, Will.Deacon@arm.com, Catalin.Marinas@arm.com, gregkh@linuxfoundation.org, Mark.Rutland@arm.com, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, wangxiongfeng2@huawei.com, vkilari@codeaurora.org, ahs3@redhat.com, Dietmar.Eggemann@arm.com, Morten.Rasmussen@arm.com, palmer@sifive.com, lenb@kernel.org, john.garry@huawei.com, austinwc@codeaurora.org, tnowicki@caviumnetworks.com, jhugo@qti.qualcomm.com, timur@qti.qualcomm.com, ard.biesheuvel@linaro.org
List-Id: linux-acpi@vger.kernel.org



On 26/04/18 00:31, Jeremy Linton wrote:
> Propagate the topology information from the PPTT tree to the
> cpu_topology array. We can get the thread id and core_id by assuming
> certain levels of the PPTT tree correspond to those concepts.
> The package_id is flagged in the tree and can be found by calling
> find_acpi_cpu_topology_package() which terminates
> its search when it finds an ACPI node flagged as the physical
> package. If the tree doesn't contain enough levels to represent
> all of the requested levels then the root node will be returned
> for all subsequent levels.
> 

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

[..]

> @@ -304,6 +345,8 @@ void __init init_cpu_topology(void)
>  	 * Discard anything that was parsed if we hit an error so we
>  	 * don't use partial information.
>  	 */
> -	if (of_have_populated_dt() && parse_dt_topology())
> +	if ((!acpi_disabled) && parse_acpi_topology())

[nit] not sure if extra () is need above, but I am fine either way.

-- 
Regards,
Sudeep
