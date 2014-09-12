From: Graeme Gregory <gg@slimlogic.co.uk>
Subject: Re: [PATCH v4 05/18] ARM64 / ACPI: Introduce sleep-arm.c
Date: Fri, 12 Sep 2014 16:18:51 +0100
Message-ID: <20140912151850.GB9234@xora-haswell.xora.org.uk>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <1410530416-30200-6-git-send-email-hanjun.guo@linaro.org>
 <20140912145102.GB5532@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140912145102.GB5532@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Mark Rutland <Mark.Rutland@arm.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Will Deacon <Will.Deacon@arm.com>, Lv Zheng <lv.zheng@intel.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Moore <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "jcm@redhat.com" <jcm@redhat.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <Marc.Zyngier@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.i
List-Id: linux-acpi@vger.kernel.org

On Fri, Sep 12, 2014 at 03:51:02PM +0100, Catalin Marinas wrote:
> On Fri, Sep 12, 2014 at 03:00:03PM +0100, Hanjun Guo wrote:
> > --- a/drivers/acpi/Makefile
> > +++ b/drivers/acpi/Makefile
> > @@ -23,7 +23,11 @@ acpi-y				+= nvs.o
> >  
> >  # Power management related files
> >  acpi-y				+= wakeup.o
> > +ifeq ($(ARCH), arm64)
> > +acpi-y				+= sleep-arm.o
> > +else # X86, IA64
> >  acpi-y				+= sleep.o
> > +endif
> >  acpi-y				+= device_pm.o
> >  acpi-$(CONFIG_ACPI_SLEEP)	+= proc.o
> 
> What about:
> 
> -acpi-y				+= sleep.o
> +acpi-$(CONFIG_ACPI_SLEEP)	+= sleep.o
> 
> and make CONFIG_ACPI_SLEEP depend on !ARM64? Does the kernel compile if
> you disable CONFIG_ACPI_SLEEP?
> 
sleep.c is still needed in the case CONFIG_ACPI_SLEEP=n

basically the two functions I stubbed are always called by bus.c

Graeme
