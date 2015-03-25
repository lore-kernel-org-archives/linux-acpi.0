From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [patch v11 10/23] ARM64 / ACPI: Get PSCI flags in FADT for PSCI
 init
Date: Wed, 25 Mar 2015 17:01:04 +0000
Message-ID: <20150325170104.GH14585@localhost>
References: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
 <1427205776-5060-11-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1427205776-5060-11-git-send-email-hanjun.guo@linaro.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, linaro-acpi@lists.linaro.org, Will Deacon <will.deacon@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Timur Tabi <timur@codeaurora.org>, linux-acpi@vger.kernel.org, Mark Salter <msalter@redhat.com>, Grant Likely <grant.likely@linaro.org>, Robert Richter <rric@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Graeme Gregory <graeme.gregory@linaro.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Olof Johansson <olof@lixom.net>
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 24, 2015 at 10:02:43PM +0800, Hanjun Guo wrote:
> From: Graeme Gregory <graeme.gregory@linaro.org>
> 
> There are two flags: PSCI_COMPLIANT and PSCI_USE_HVC. When set,
> the former signals to the OS that the firmware is PSCI compliant.
> The latter selects the appropriate conduit for PSCI calls by
> toggling between Hypervisor Calls (HVC) and Secure Monitor Calls
> (SMC).
> 
> FADT table contains such information in ACPI 5.1, FADT table was
> parsed in ACPI table init and copy to struct acpi_gbl_FADT, so
> use the flags in struct acpi_gbl_FADT for PSCI init.
> 
> Since ACPI 5.1 doesn't support self defined PSCI function IDs,
> which means that only PSCI 0.2+ is supported in ACPI.
> 
> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Yijing Wang <wangyijing@huawei.com>
> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
> Tested-by: Jon Masters <jcm@redhat.com>
> Tested-by: Timur Tabi <timur@codeaurora.org>
> Tested-by: Robert Richter <rrichter@cavium.com>
> Acked-by: Robert Richter <rrichter@cavium.com>
> Acked-by: Olof Johansson <olof@lixom.net>
> Acked-by: Grant Likely <grant.likely@linaro.org>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
