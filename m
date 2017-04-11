From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 1/2] ACPI: ACPICA: Add non-linux host build support
Date: Tue, 11 Apr 2017 07:22:02 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CE8DA3C@SHSMSX101.ccr.corp.intel.com>
References: <45fb52dc64ba477ae07c135aecd3b68394f5893b.1490930522.git.lv.zheng@intel.com>
 <5ce80bd8-c0c8-8ba9-872f-80af844a1ac1@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:50878 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753792AbdDKHbm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Apr 2017 03:31:42 -0400
In-Reply-To: <5ce80bd8-c0c8-8ba9-872f-80af844a1ac1@redhat.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "ahs3@redhat.com" <ahs3@redhat.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Al Stone <ah3@redhat.com>

Hi,

> From: Al Stone [mailto:ahs3@redhat.com]
> Subject: Re: [PATCH 1/2] ACPI: ACPICA: Add non-linux host build support
>=20
> On 03/30/2017 10:53 PM, Lv Zheng wrote:
> > _LINUX: used to detect a target build is a linux kernel/application.
> > __linux__: used to detect a build is on a linux hosts.
> >
> > Thus we can see: if a linux kernel build is performed on environments o=
ther
> > than linux hosts, __linux__ may not be defined by the compiler and _LIN=
UX
> > cannot cover linux kernel resident ACPICA files, as it's only defined i=
n
> > <linux/acpi.h> and hence only allows non ACPICA kernel files to correct=
ly
> > include aclinux.h.
> > As a conclusion, we don't actually support such build.
> >
> > This patch adds -D_LINUX for ACPICA files so that kernel builds on any
> > hosts can use unified _LINUX as a linux kernel target indication to
> > correctly include aclinux.h.
> >
> > Cc: Al Stone <ah3@redhat.com>
> > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> > ---
> >  drivers/acpi/acpica/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefil=
e
> > index 32d93ed..dea6530 100644
> > --- a/drivers/acpi/acpica/Makefile
> > +++ b/drivers/acpi/acpica/Makefile
> > @@ -2,7 +2,7 @@
> >  # Makefile for ACPICA Core interpreter
> >  #
> >
> > -ccflags-y			:=3D -Os -DBUILDING_ACPICA
> > +ccflags-y			:=3D -Os -D_LINUX -DBUILDING_ACPICA
> >  ccflags-$(CONFIG_ACPI_DEBUG)	+=3D -DACPI_DEBUG_OUTPUT
> >
> >  # use acpi.o to put all files here into acpi.o modparam namespace
> >
>=20
> These patches do solve the particular compilation problem I was having
> (targeting an embedded arm64 system), so thank you for that.  The build
> test obviously needs fixing, but with the Linaro aarch64-elf compilers,
> and the defconfig,

Thanks for the confirmation.
PATCH 02 cannot be upstreamed due to the kbuild test report.
It can only go into Linux after fixing ACPICA's stub problems.
However PATCH 01 should be sufficient for fixing your problem.
I'll ask Rafael to drop PATCH 02 and take PATCH 01 as a build fix.

Thanks and best regards
Lv

>=20
> Tested-by: Al Stone <ahs3@redhat.com>
>=20
> --
> ciao,
> al
> -----------------------------------
> Al Stone
> Software Engineer
> Red Hat, Inc.
> ahs3@redhat.com
> -----------------------------------
