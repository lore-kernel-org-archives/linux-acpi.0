From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [patch v11 23/23] ARM64 / ACPI: Don't unflatten device tree if
 acpi=force is passed
Date: Wed, 25 Mar 2015 17:31:07 +0000
Message-ID: <20150325173107.GQ14585@localhost>
References: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
 <1427205776-5060-24-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1427205776-5060-24-git-send-email-hanjun.guo@linaro.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, linaro-acpi@lists.linaro.org, Will Deacon <will.deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Timur Tabi <timur@codeaurora.org>, linux-acpi@vger.kernel.org, Mark Salter <msalter@redhat.com>, Grant Likely <grant.likely@linaro.org>, Robert Richter <rric@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Graeme Gregory <graeme.gregory@linaro.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Olof Johansson <olof@lixom.net>
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 24, 2015 at 10:02:56PM +0800, Hanjun Guo wrote:
> Since the policy is that once we pass acpi=force in the early
> param, we will not unflatten device tree even if ACPI is disabled
> in ACPI table init fails, so fix the code by comparinging both
> acpi_disabled and param_acpi_force before the device tree is
> unflattened.
> 
> CC: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

but as I said, we should take Lorenzo's patch on top as well.
