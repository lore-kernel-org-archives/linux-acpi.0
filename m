From: Sinan Kaya <Okaya@kernel.org>
Subject: Re: [PATCH v3 10/11] x86: select IOSF_MBI only when CONFIG_PCI is set
Date: Sun, 30 Dec 2018 22:04:30 +0300
Message-ID: <CAK9iUCNrP6u_m1VE-vUBw9gPK6LvEeugEGK9Kc=UPDXEYjxggw@mail.gmail.com>
References: <20181223232521.11320-1-okaya@kernel.org> <20181223232521.11320-11-okaya@kernel.org>
 <CAJZ5v0is-DSV15AxRyNG93vazzQsY_8vM6crzgZXeEmhTyQBVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0is-DSV15AxRyNG93vazzQsY_8vM6crzgZXeEmhTyQBVQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Dec 25, 2018 at 12:14 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Dec 24, 2018 at 12:25 AM Sinan Kaya <okaya@kernel.org> wrote:
> >
> > Need CONFIG_PCI to be set in order to be able to use IOSF_MBI
> > functionality.
> >
> > Signed-off-by: Sinan Kaya <okaya@kernel.org>
>
> The subject and changelog here don't match the changes below.  Please fix.
>

Done

> > ---
> >  arch/x86/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index cc4f0c6ee1ed..322a58ababb0 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -617,7 +617,7 @@ config X86_INTEL_QUARK
> >
> >  config X86_INTEL_LPSS
> >         bool "Intel Low Power Subsystem Support"
> > -       depends on X86 && ACPI
> > +       depends on X86 && ACPI && PCI
> >         select COMMON_CLK
> >         select PINCTRL
> >         select IOSF_MBI
> > --
> > 2.19.0
> >
