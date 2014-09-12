From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v4 05/18] ARM64 / ACPI: Introduce sleep-arm.c
Date: Fri, 12 Sep 2014 15:51:02 +0100
Message-ID: <20140912145102.GB5532@arm.com>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <1410530416-30200-6-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1410530416-30200-6-git-send-email-hanjun.guo@linaro.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <Mark.Rutland@arm.com>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Will Deacon <Will.Deacon@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, linux-acpi@vger.ker
List-Id: linux-acpi@vger.kernel.org

On Fri, Sep 12, 2014 at 03:00:03PM +0100, Hanjun Guo wrote:
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -23,7 +23,11 @@ acpi-y				+= nvs.o
>  
>  # Power management related files
>  acpi-y				+= wakeup.o
> +ifeq ($(ARCH), arm64)
> +acpi-y				+= sleep-arm.o
> +else # X86, IA64
>  acpi-y				+= sleep.o
> +endif
>  acpi-y				+= device_pm.o
>  acpi-$(CONFIG_ACPI_SLEEP)	+= proc.o

What about:

-acpi-y				+= sleep.o
+acpi-$(CONFIG_ACPI_SLEEP)	+= sleep.o

and make CONFIG_ACPI_SLEEP depend on !ARM64? Does the kernel compile if
you disable CONFIG_ACPI_SLEEP?

-- 
Catalin
