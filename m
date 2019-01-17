From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [for-next][PATCH] x86/Kconfig: Select PCI_LOCKLESS_CONFIG if PCI
 is enabled
Date: Thu, 17 Jan 2019 23:05:43 +0100
Message-ID: <CAJZ5v0hHFASeJb8z8QwQkh-tCs409pnaywtWcqLP5K5ZDGhTsw@mail.gmail.com>
References: <20190117161722.3945-1-okaya@kernel.org> <20190117163722.GE5023@zn.tnic>
 <c0fa174a-2e7b-2ef2-4913-167934c68c06@kernel.org> <20190117215631.GF5023@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190117215631.GF5023@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Sinan Kaya <okaya@kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Linux-Next Mailing List <linux-next@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jan 17, 2019 at 10:56 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Jan 17, 2019 at 11:42:39AM -0500, Sinan Kaya wrote:
> > On 1/17/2019 11:37 AM, Borislav Petkov wrote:
> > > Also, I see a lot of build failures when doing randconfig builds for the
> > > stuff in drivers/platform/x86/Kconfig. Is someone picking those up too?
> >
> > Can you share the build failures you are seeing?
>
> Here are three configs which fail.
>
> They have in common:
>
> # CONFIG_PCI is not set
>
> As a tip for the future - always build the default
> def/allno/yes/modconfig targets and as many randconfigs as possible when
> changing Kconfig dependencies. I've learned that the hard way.
>
> Here are the build failures:
>
> arch/x86/kernel/ftrace.c:668:23: warning: ‘ftrace_jmp_replace’ defined but not used [-Wunused-function]
> drivers/platform/x86/intel_ips.c: In function ‘ips_probe’:
> drivers/platform/x86/intel_ips.c:1463:2: error: implicit declaration of function ‘pcim_enable_device’ [-Werror=implicit-function-declaration]
> drivers/platform/x86/intel_ips.c:1525:2: error: implicit declaration of function ‘pci_alloc_irq_vectors’ [-Werror=implicit-function-declaration]
> drivers/platform/x86/intel_ips.c:1525:41: error: ‘PCI_IRQ_LEGACY’ undeclared (first use in this function)
> drivers/platform/x86/intel_ips.c:1525:41: note: each undeclared identifier is reported only once for each function it appears in
> drivers/platform/x86/intel_ips.c:1529:2: error: implicit declaration of function ‘pci_irq_vector’ [-Werror=implicit-function-declaration]
> drivers/platform/x86/intel_ips.c:1592:2: error: implicit declaration of function ‘pci_free_irq_vectors’ [-Werror=implicit-function-declaration]
> drivers/platform/x86/intel_ips.c: At top level:
> drivers/platform/x86/intel_ips.c:1636:1: warning: data definition has no type or storage class [enabled by default]
> drivers/platform/x86/intel_ips.c:1636:1: error: type defaults to ‘int’ in declaration of ‘module_pci_driver’ [-Werror=implicit-int]
> drivers/platform/x86/intel_ips.c:1636:1: warning: parameter names (without types) in function declaration [enabled by default]
> drivers/platform/x86/intel_ips.c:1629:26: warning: ‘ips_pci_driver’ defined but not used [-Wunused-variable]
> make[3]: *** [drivers/platform/x86/intel_ips.o] Error 1
> make[2]: *** [drivers/platform/x86] Error 2
>
> drivers/platform/x86/apple-gmux.c: In function ‘gmux_probe’:
> drivers/platform/x86/apple-gmux.c:746:22: error: ‘pci_bus_type’ undeclared (first use in this function)
> drivers/platform/x86/apple-gmux.c:746:22: note: each undeclared identifier is reported only once for each function it appears in
> make[3]: *** [drivers/platform/x86/apple-gmux.o] Error 1
>
> drivers/platform/x86/intel_pmc_ipc.c: In function ‘ipc_pci_probe’:
> drivers/platform/x86/intel_pmc_ipc.c:520:2: error: implicit declaration of function ‘pcim_enable_device’ [-Werror=implicit-function-declaration]
> make[3]: *** [drivers/platform/x86/intel_pmc_ipc.o] Error 1
>
> You get the idea...

I have patches for intel_ips and intel_pmc_ipc queued up (will be
pushed for -rc3), plus some others.  apple-gmux is a new one.
