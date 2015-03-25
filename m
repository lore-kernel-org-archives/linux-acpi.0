From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [patch v11 08/23] ARM64 / ACPI: Introduce early_param "acpi=" to
 enable/disable ACPI
Date: Wed, 25 Mar 2015 16:57:50 +0000
Message-ID: <20150325165750.GF14585@localhost>
References: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
 <1427205776-5060-9-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427205776-5060-9-git-send-email-hanjun.guo@linaro.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Ashwin Chaugule <ashwinc@codeaurora.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Robert Richter <rric@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Graeme Gregory <graeme.gregory@linaro.org>, linaro-acpi@lists.linaro.org, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Timur Tabi <timur@codeaurora.org>, Mark Salter <msalter@redhat.com>, linux-kernel@vger.kernel.org, Al Stone <al.stone@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Sudeep Holla <Sudeep.Holla@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 24, 2015 at 10:02:41PM +0800, Hanjun Guo wrote:
> From: Al Stone <al.stone@linaro.org>
> 
> This implements the following policy to decide whether ACPI should
> be used to boot the system:
> - acpi=off: ACPI will not be used to boot the system, even if there is
>   no alternative available (e.g., device tree is empty)
> - acpi=force: only ACPI will be used to boot the system; if that fails,
>   there will be no fallback to alternative methods (such as device tree)
> - otherwise, ACPI will be used as a fallback if the device tree turns out
>   to lack a platform description; the heuristic to decide this is whether
>   /chosen is the only node present at depth 1
> 
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> Acked-by: Olof Johansson <olof@lixom.net>
> Acked-by: Grant Likely <grant.likely@linaro.org>
> Tested-by: Timur Tabi <timur@codeaurora.org>
> Signed-off-by: Al Stone <al.stone@linaro.org>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

But we should also merge Lorenzo's patch which gets read of the forced
param (on top of this series, I really think we should stop rebasing at
this point).

-- 
Catalin
