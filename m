From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v9 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
Date: Fri, 27 Feb 2015 10:36:50 +0000
Message-ID: <20150227103650.GA9011@leverpostej>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <54EFE282.1090305@codeaurora.org>
 <CAKv+Gu-LxaX6X=qApp=zhzfmNfv=tjfscf9npFCpNW314pZvvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42991 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752317AbbB0KhT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 27 Feb 2015 05:37:19 -0500
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-LxaX6X=qApp=zhzfmNfv=tjfscf9npFCpNW314pZvvg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Timur Tabi <timur@codeaurora.org>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <Will.Deacon@arm.com>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Robert Richter <rric@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, Sudeep Holla <Sudeep.Holla@a>

> > I'm still debugging it, but v9 on the 4.0-rc1 kernel crashes after calling
> > the UEFI boot time services exit function.  That is, this line:
> >
> > status = sys_table->boottime->exit_boot_services(handle, mmap_key);
> >
> > in allocate_new_fdt_and_exit_boot() gets called, and then soon after it
> > returns, the kernel crashes.  It's really early because the UEFI exception
> > handler is called.
> >
> > I did not have this problem with v8 patchset on 3.19.
> >
> 
> Are you not seeing this on v4.0-rc1 without the patchset applied?
> 
> Could the crash be inside the subsequent call to
> SetVirtualAddressMap() instead of inside ExitBootServices()?
> 
> If so, you have a firmware bug: Mark Rutland spotted a similar bug in
> the AMD Seattle firmware, which has been fixed in the mean time.
> It has to do with the firmware dereferencing the virtual mapping as it
> is being installed, which violates the UEFI spec.

A simple way to test is to change EFI_RT_VIRTUAL_BASE to point to the
(unmapped) high half of the address space (e.g. set it to
0xffff000000000000). If EFI is using pointers erroneously then something
should fault within SetVirtualAddressMap(), and you can catch this with
your favourite debugger.

Otherwise it's possible that the virtual address space chosen will cover
memory and/or devices in the existing idmap, and any erroneous accesses
will corrupt memory and/or cause devices to explode.

Thanks,
Mark
