From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [patch v11 07/23] ARM64 / ACPI: Introduce PCI stub functions for
 ACPI
Date: Wed, 25 Mar 2015 16:50:31 +0000
Message-ID: <20150325165031.GE14585@localhost>
References: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
 <1427205776-5060-8-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427205776-5060-8-git-send-email-hanjun.guo@linaro.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Ashwin Chaugule <ashwinc@codeaurora.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Robert Richter <rric@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Graeme Gregory <graeme.gregory@linaro.org>, linaro-acpi@lists.linaro.org, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Timur Tabi <timur@codeaurora.org>, Mark Salter <msalter@redhat.com>, Liviu Dudau <Liviu.Dudau@arm.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Sudeep Holla <Sudeep.Holla@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 24, 2015 at 10:02:40PM +0800, Hanjun Guo wrote:
> CONFIG_ACPI depends CONFIG_PCI on x86 and ia64, in ARM64 server
> world we will have PCIe in most cases, but some of them may not,
> make CONFIG_ACPI depend CONFIG_PCI on ARM64 will satisfy both.
> 
> With that case, we need some arch dependent PCI functions to
> access the config space before the PCI root bridge is created, and
> pci_acpi_scan_root() to create the PCI root bus. So introduce
> some stub function here to make ACPI core compile and revisit
> them later when implemented on ARM64.
> 
> CC: Liviu Dudau <Liviu.Dudau@arm.com>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Yijing Wang <wangyijing@huawei.com>
> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
> Tested-by: Jon Masters <jcm@redhat.com>
> Tested-by: Timur Tabi <timur@codeaurora.org>
> Tested-by: Robert Richter <rrichter@cavium.com>
> Acked-by: Robert Richter <rrichter@cavium.com>
> Reviewed-by: Grant Likely <grant.likely@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
