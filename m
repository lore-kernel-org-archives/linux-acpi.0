From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v8 02/21] acpi: fix acpi_os_ioremap for arm64
Date: Tue, 3 Feb 2015 11:37:44 +0000
Message-ID: <20150203113744.GA3677@e104818-lin.cambridge.arm.com>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <1422881149-8177-3-git-send-email-hanjun.guo@linaro.org>
 <2422968.Es7R0p3loO@vostro.rjw.lan>
 <54D0901A.2080406@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54D0901A.2080406@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Feb 03, 2015 at 09:08:42AM +0000, Hanjun Guo wrote:
> On 2015=E5=B9=B402=E6=9C=8803=E6=97=A5 06:14, Rafael J. Wysocki wrote=
:
> > On Monday, February 02, 2015 08:45:30 PM Hanjun Guo wrote:
> >> From: Mark Salter <msalter@redhat.com>
> >>
> >> The acpi_os_ioremap() function may be used to map normal RAM or IO
> >> regions. The current implementation simply uses ioremap_cache(). T=
his
> >> will work for some architectures, but arm64 ioremap_cache() cannot=
 be
> >> used to map IO regions which don't support caching. So for arm64, =
use
> >> ioremap() for non-RAM regions.
> >>
> >> CC: Rafael J Wysocki <rjw@rjwysocki.net>
> >> Signed-off-by: Mark Salter <msalter@redhat.com>
> >> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> >> ---
> >>   include/acpi/acpi_io.h | 6 ++++++
> >>   1 file changed, 6 insertions(+)
> >>
> >> diff --git a/include/acpi/acpi_io.h b/include/acpi/acpi_io.h
> >> index 444671e..9d573db 100644
> >> --- a/include/acpi/acpi_io.h
> >> +++ b/include/acpi/acpi_io.h
> >> @@ -1,11 +1,17 @@
> >>   #ifndef _ACPI_IO_H_
> >>   #define _ACPI_IO_H_
> >>
> >> +#include <linux/mm.h>
> >>   #include <linux/io.h>
> >>
> >>   static inline void __iomem *acpi_os_ioremap(acpi_physical_addres=
s phys,
> >>   					    acpi_size size)
> >>   {
> >> +#ifdef CONFIG_ARM64
> >> +	if (!page_is_ram(phys >> PAGE_SHIFT))
> >> +		return ioremap(phys, size);
> >> +#endif
> >
> > I don't want to see #ifdef CONFIG_ARM64 in this file.
> >
> > There are multiple examples of how things like this are done.  Gene=
rally,
> > the logic is "If the architecture provides its own function for thi=
s, use
> > that one, or use the generic one provided here otherwise."
>=20
> OK. I think weak function would work.

Probably not in a header file. It's better to define acpi_os_ioremap()
in an arm64 kernel file, together with something like:

#define ARCH_HAS_ACPI_OS_IOREMAP

and the corresponding #ifdef's in the acpi_io.h file.

On arm64 could we make this function call iorema (nocache) all the time=
?
We need to clarify the contexts where this is used in the core ACPI
code. The acpi_map() function for example checks if the page is ram and
does a kmap(). Do we need to handle the NVS on arm64? AFAICT, we don't
even compile drivers/acpi/sleep.c in.

Are there other cases where acpi_os_ioremap() is called directly and it
needs a cacheable mapping?

--=20
Catalin
