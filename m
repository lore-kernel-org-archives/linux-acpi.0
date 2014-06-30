From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v4 07/13] ARM64 / ACPI: Introduce lowlevel suspend
 function
Date: Mon, 30 Jun 2014 17:28:17 +0100
Message-ID: <20140630162817.GS28951@arm.com>
References: <1403840976-7456-1-git-send-email-hanjun.guo@linaro.org>
 <1403840976-7456-8-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1403840976-7456-8-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, "rric@kernel.org" <rric@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jun 27, 2014 at 04:49:30AM +0100, Hanjun Guo wrote:
> From: Graeme Gregory <graeme.gregory@linaro.org>
> 
> acpi_wakeup_address is used on x86 as the address bios jumps into
> when machine wakes up from suspend. As arm64 does not have such a
> bios this mechanism will be provided by other means. But the define
> is still required inside the acpi core.

Why not fix the place where it is used rather than defining a dummy
pointer?

> Introduce a null stub for acpi_suspend_lowlevel as this is also
> required by core. This will be filled in when standards are
> defined for arm64 ACPI global power states.

I assume acpi_suspend_lowlevel would be just a dummy definition but it
will have some use when the standard allows.

-- 
Catalin
