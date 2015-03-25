From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [patch v11 03/23] ARM64: allow late use of early_ioremap
Date: Wed, 25 Mar 2015 16:43:54 +0000
Message-ID: <20150325164354.GB14585@localhost>
References: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
 <1427205776-5060-4-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427205776-5060-4-git-send-email-hanjun.guo@linaro.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Ashwin Chaugule <ashwinc@codeaurora.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Robert Richter <rric@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Graeme Gregory <graeme.gregory@linaro.org>, linaro-acpi@lists.linaro.org, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Timur Tabi <timur@codeaurora.org>, Mark Salter <msalter@redhat.com>, linux-kernel@vger.kernel.org, Leif Lindholm <leif.lindholm@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Sudeep Holla <Sudeep.Holla@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 24, 2015 at 10:02:36PM +0800, Hanjun Guo wrote:
> From: Mark Salter <msalter@redhat.com>
> 
> Commit 0e63ea48b4d8 (arm64/efi: add missing call to early_ioremap_reset())
> added a missing call to early_ioremap_reset(). This triggers a BUG if code
> tries using early_ioremap() after the early_ioremap_reset(). This is a
> problem for some ACPI code which needs short-lived temporary mappings
> after paging_init() but before acpi_early_init() in start_kernel(). This
> patch adds definitions for the __late_set_fixmap() and __late_clear_fixmap()
> which avoids the BUG by allowing later use of early_ioremap().
> 
> CC: Leif Lindholm <leif.lindholm@linaro.org>
> CC: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
> Tested-by: Jon Masters <jcm@redhat.com>
> Tested-by: Robert Richter <rrichter@cavium.com>
> Tested-by: Timur Tabi <timur@codeaurora.org>
> Acked-by: Robert Richter <rrichter@cavium.com>
> Reviewed-by: Grant Likely <grant.likely@linaro.org>
> Signed-off-by: Mark Salter <msalter@redhat.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
