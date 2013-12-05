From: Betty Dall <betty.dall@hp.com>
Subject: Re: [BUG] Re: [PATCH v10 1/3] aerdrv: Trace Event for AER
Date: Thu, 05 Dec 2013 11:21:10 -0700
Message-ID: <1386267670.18256.8.camel@ejdallLaptop>
References: <20130116235102.16015.77379.stgit@grignak.americas.hpqcorp.net>
	 <CANVTcTabw2pxUP0iinepviavSLHT7AAyaQvA7e-mv2simbX7ow@mail.gmail.com>
	 <CABawtvP3m_dAKaOLxNqHXQobsgk92ysh6H881i3eDASLi+-WAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g6t0185.atlanta.hp.com ([15.193.32.62]:44498 "EHLO
	g6t0185.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293Ab3LESVP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Dec 2013 13:21:15 -0500
In-Reply-To: <CABawtvP3m_dAKaOLxNqHXQobsgk92ysh6H881i3eDASLi+-WAg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ethan Zhao <ethan.kernel@gmail.com>
Cc: rui wang <ruiv.wang@gmail.com>, Lance Ortiz <lance.ortiz@hp.com>, Bjorn Helgaas <bhelgaas@google.com>, lance_ortiz@hotmail.com, jiang.liu@intel.com, tony.luck@intel.com, bp@alien8.de, rostedt@goodmis.org, m.chehab@samsung.com, linux-acpi@vger.kernel.org, linux-pci <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, gong.chen@linux.intel.com

On Wed, 2013-12-04 at 23:28 +0800, Ethan Zhao wrote:
> Rui,
>    Agree with that, there are really many such confusing error type d=
efinition
> need to be standardized or unified, some of them are
> ambiguous=E3=80=81inconsistent, some of them violates ACPI/PCI spec.
>=20
>   According to the ACPI spec, the 'FATAL' in fact, is a sub-category
> of 'UNCORRECTABLE' , the another one is 'NON-FATAL', then how to
> understand the bebow 'UNCORRECTABLE's ?  mean  uncorrectable-non-fata=
l
> ? just guess, confusing.
>=20
> acpi\actbl1.h
>=20
> #define ACPI_EINJ_PROCESSOR_CORRECTABLE     (1)
> #define ACPI_EINJ_PROCESSOR_UNCORRECTABLE   (1<<1)
> #define ACPI_EINJ_PROCESSOR_FATAL           (1<<2)
> #define ACPI_EINJ_MEMORY_CORRECTABLE        (1<<3)
> #define ACPI_EINJ_MEMORY_UNCORRECTABLE      (1<<4)
> #define ACPI_EINJ_MEMORY_FATAL              (1<<5)
> #define ACPI_EINJ_PCIX_CORRECTABLE          (1<<6)
> #define ACPI_EINJ_PCIX_UNCORRECTABLE        (1<<7)
> #define ACPI_EINJ_PCIX_FATAL                (1<<8)
> #define ACPI_EINJ_PLATFORM_CORRECTABLE      (1<<9)
> #define ACPI_EINJ_PLATFORM_UNCORRECTABLE    (1<<10)
> #define ACPI_EINJ_PLATFORM_FATAL            (1<<11)
>=20
> edac.h
>=20
> enum hw_event_mc_err_type {
> HW_EVENT_ERR_CORRECTED,
> HW_EVENT_ERR_UNCORRECTED,
> HW_EVENT_ERR_FATAL,
> HW_EVENT_ERR_INFO,
> };
>=20
> ghes.h
> enum {
> GHES_SEV_NO =3D 0x0,
> GHES_SEV_CORRECTED =3D 0x1,
> GHES_SEV_RECOVERABLE =3D 0x2,
> GHES_SEV_PANIC =3D 0x3,
> };
>=20
> What's the meaning of GHES_SEV_PANIC ? Why not 'FATAL' , just as
> described in ACPI spec section 18.3.2.6.1,
> "
> Error Severity 4 16 Identifies the error severity of the reported err=
or:
> 0 =E2=80=93 Recoverable=EF=80=A0
> 1 =E2=80=93 Fatal=EF=80=A0
> 2 =E2=80=93 Corrected=EF=80=A0
> 3 =E2=80=93 None
> "
> If there is other intension, but could be seen translated into 'FATAL=
' later:
>=20
> case GHES_SEV_PANIC:
>   type =3D HW_EVENT_ERR_FATAL;
>=20
> And these looks reasonable,
> aer.h
>=20
> #define AER_NONFATAL 0
> #define AER_FATAL 1
> #define AER_CORRECTABLE 2

The definition of the GHES_SEV* matches up with the error severity
definition of the CPER records as defined in the UEFI spec section
N.2.1:
"Indicates the severity of the error condition. The severity of
the error record corresponds to the most severe error
section.
0 - Recoverable (also called non-fatal uncorrected)
1 - Fatal
2 - Corrected
3 - Informational
All other values are reserved.
Note that severity of "Informational" indicates that the record
could be safely ignored by error handling software."

The ghes code uses the CPER record's severity and always calls the
function ghes_severity() to convert to the GHES_SEV value. Since the
ACPI spec defines the GHES severity, it makes sense to maintain an enum
for it and use the ghes_severity() to convert where necessary. This is
what I am thinking:

Author: Betty Dall <betty.dall@hp.com>
Date:   Thu Dec 5 11:05:43 2013 -0700

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index a30bc31..c59144e 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -301,16 +301,18 @@ static inline int ghes_severity(int severity)
 {
        switch (severity) {
        case CPER_SEV_INFORMATIONAL:
-               return GHES_SEV_NO;
+               return GHES_SEV_NONE;
        case CPER_SEV_CORRECTED:
                return GHES_SEV_CORRECTED;
        case CPER_SEV_RECOVERABLE:
                return GHES_SEV_RECOVERABLE;
        case CPER_SEV_FATAL:
-               return GHES_SEV_PANIC;
+               return GHES_SEV_FATAL;
        default:
                /* Unknown, go panic */
-               return GHES_SEV_PANIC;
+               pr_warn(FW_WARN GHES_PFX
+                       "Invalid CPER severity: %d\n", severity);
+               return GHES_SEV_FATAL;
        }
 }
=20
@@ -828,7 +830,7 @@ static int ghes_notify_nmi(unsigned int cmd, struct
pt_regs *regs)
        if (ret =3D=3D NMI_DONE)
                goto out;
=20
-       if (sev_global >=3D GHES_SEV_PANIC) {
+       if (sev_global >=3D GHES_SEV_FATAL) {
                oops_begin();
                ghes_print_queued_estatus();
                __ghes_print_estatus(KERN_EMERG, ghes_global->generic,
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index dfd60d0..7cefa89 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -39,10 +39,10 @@ struct ghes_estatus_cache {
 };
=20
 enum {
-       GHES_SEV_NO =3D 0x0,
-       GHES_SEV_CORRECTED =3D 0x1,
-       GHES_SEV_RECOVERABLE =3D 0x2,
-       GHES_SEV_PANIC =3D 0x3,
+       GHES_SEV_RECOVERABLE =3D 0x0,
+       GHES_SEV_FATAL =3D 0x1,
+       GHES_SEV_CORRECTED =3D 0x2,
+       GHES_SEV_NONE =3D 0x3,
 };
=20
 /* From drivers/edac/ghes_edac.c */


-Betty


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
