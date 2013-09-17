From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 11/14] ACPICA: Tables: Cleanup RSDP signature codes.
Date: Tue, 17 Sep 2013 01:11:42 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E8802463F9A@SHSMSX101.ccr.corp.intel.com>
References: <cover.1377844863.git.lv.zheng@intel.com>
	<fb939442320d1f3f68250b4a33fd4e97f6f689d9.1377844863.git.lv.zheng@intel.com>
 <CAJvTdKkwNXZQXz1A2zB8se=gfCT-K_=xsLRyyd44TEvPjAismw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:63897 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751517Ab3IQBLs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Sep 2013 21:11:48 -0400
In-Reply-To: <CAJvTdKkwNXZQXz1A2zB8se=gfCT-K_=xsLRyyd44TEvPjAismw@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "Brown, Len" <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

> From: lenb417@gmail.com [mailto:lenb417@gmail.com] On Behalf Of Len Brown
> Sent: Tuesday, September 17, 2013 8:52 AM
> 
> On Thu, Sep 12, 2013 at 4:55 AM, Lv Zheng <lv.zheng@intel.com> wrote:
> > This patch introduces new macors to handle RSDP signature and cleans up the
> > affected codes.  Lv Zheng.
> >
> > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> > Signed-off-by: Bob Moore <robert.moore@intel.com>
> > ---
> >  drivers/acpi/acpica/tbprint.c  |    2 +-
> >  drivers/acpi/acpica/tbxfroot.c |    3 +--
> >  include/acpi/actypes.h         |    5 +++++
> >  3 files changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/acpi/acpica/tbprint.c b/drivers/acpi/acpica/tbprint.c
> > index 499759a..9a47715 100644
> > --- a/drivers/acpi/acpica/tbprint.c
> > +++ b/drivers/acpi/acpica/tbprint.c
> > @@ -138,7 +138,7 @@ acpi_tb_print_table_header(acpi_physical_address address,
> >                 ACPI_INFO((AE_INFO, "%4.4s %p %05X",
> >                            header->signature, ACPI_CAST_PTR(void, address),
> >                            header->length));
> > -       } else if (ACPI_COMPARE_NAME(header->signature, ACPI_SIG_RSDP)) {
> > +       } else if (ACPI_VALIDATE_RSDP_SIG(header->signature)) {
> >
> >                 /* RSDP has no common fields */
> >
> > diff --git a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
> > index 948c95e..1c95fab 100644
> > --- a/drivers/acpi/acpica/tbxfroot.c
> > +++ b/drivers/acpi/acpica/tbxfroot.c
> > @@ -68,8 +68,7 @@ acpi_status acpi_tb_validate_rsdp(struct acpi_table_rsdp *rsdp)
> >          * Note: Sometimes there exists more than one RSDP in memory; the valid
> >          * RSDP has a valid checksum, all others have an invalid checksum.
> >          */
> > -       if (ACPI_STRNCMP((char *)rsdp->signature, ACPI_SIG_RSDP,
> > -                        sizeof(ACPI_SIG_RSDP) - 1) != 0) {
> > +       if (!ACPI_VALIDATE_RSDP_SIG(rsdp->signature)) {
> >
> >                 /* Nope, BAD Signature */
> >
> > diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
> > index 850f750..5400672 100644
> > --- a/include/acpi/actypes.h
> > +++ b/include/acpi/actypes.h
> > @@ -474,6 +474,11 @@ typedef u64 acpi_integer;
> >  #define ACPI_MOVE_NAME(dest,src)        (ACPI_STRNCPY (ACPI_CAST_PTR (char, (dest)), ACPI_CAST_PTR (char, (src)),
> ACPI_NAME_SIZE))
> >  #endif
> >
> > +/* Support for the special RSDP signature (8 characters) */
> > +
> > +#define ACPI_VALIDATE_RSDP_SIG(a)       (!ACPI_STRNCMP (ACPI_CAST_PTR (char, (a)), ACPI_SIG_RSDP, 8))
> > +#define ACPI_MAKE_RSDP_SIG(dest)        (ACPI_MEMCPY (ACPI_CAST_PTR (char, (dest)), ACPI_SIG_RSDP, 8))
> 
> is ACPI_MAKE_RSDP_SIGI(), defined, but not used?
> If so, don't define it.

The macro is used by ACPICA user space utilities like AcpiDump.
We've a plan to update the AcpiDump in the tools/acpi folder.
So it's likely we'll see users of this macro in the kernel tree.

And, if we delete the piece of codes like this, then it will generate new source code differences between Linux and ACPICA, which will hurt the automation of the ACPICA release process.
I'm sorry for that.

Thanks and best regards
-Lv

> 
> Len Brown, Intel Open Source Technology Center
