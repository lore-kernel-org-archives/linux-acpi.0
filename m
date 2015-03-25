From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [patch v11 13/23] ACPI / processor: Introduce phys_cpuid_t for
 CPU hardware ID
Date: Wed, 25 Mar 2015 17:21:09 +0000
Message-ID: <20150325172109.GJ14585@localhost>
References: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
 <1427205776-5060-14-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1427205776-5060-14-git-send-email-hanjun.guo@linaro.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Robert Richter <rric@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ashwin Chaugule <ashwinc@codeaurora.org>, linaro-acpi@lists.linaro.org, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Timur Tabi <timur@codeaurora.org>, Mark Salter <msalter@redhat.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Sudeep Holla <Sudeep.Holla@arm.com>, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Jon Masters <jcm@redhat.com>, Olof Johansson <olof@lixom.net>, Graeme Gregory <graeme.gregory@linaro.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 24, 2015 at 10:02:46PM +0800, Hanjun Guo wrote:
> CPU hardware ID (phys_id) is defined as u32 in structure acpi_processor,
> but phys_id is used as int in acpi processor driver, so it will lead to
> some inconsistence for the drivers.
> 
> Furthermore, to cater for ACPI arch ports that implement 64 bits CPU
> ids a generic CPU physical id type is required.
> 
> So introduce typedef u32 phys_cpuid_t in a common file, and introduce
> a macro PHYS_CPUID_INVALID as (phys_cpuid_t)(-1) if it's not defined
> by other archs, this will solve the inconsistence in acpi processor driver,
> and will prepare for the ACPI on ARM64 for the 64 bit CPU hardware ID
> in the following patch.
> 
> CC: Rafael J Wysocki <rjw@rjwysocki.net>
> Suggested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reviewed-by: Grant Likely <grant.likely@linaro.org>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> [hj: reworked cpu physid map return codes]
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

BTW, am I still the author of this patch? If yes, it's missing a From:
line.

> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -170,7 +170,7 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
>  	acpi_status status;
>  	int ret;
>  
> -	if (pr->phys_id == -1)
> +	if (pr->phys_id == PHYS_CPUID_INVALID)
>  		return -ENODEV;

If PHYS_CPUID_INVALID is the same as INVALID_HWID, we should get rid of
the latter in the arm64 code (as a subsequent clean-up patch).

-- 
Catalin
