From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v8 09/21] ARM64 / ACPI: Disable ACPI if FADT revision is
 less than 5.1
Date: Wed, 4 Feb 2015 13:06:26 +0000
Message-ID: <20150204130626.GE22035@red-moon>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <1422881149-8177-10-git-send-email-hanjun.guo@linaro.org>
 <20150203172047.GA13339@e104818-lin.cambridge.arm.com>
 <54D1E891.80405@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:41127 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965280AbbBDNGk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Feb 2015 08:06:40 -0500
Content-Disposition: inline
In-Reply-To: <54D1E891.80405@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Will Deacon <Will.Deacon@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>

On Wed, Feb 04, 2015 at 09:38:25AM +0000, Hanjun Guo wrote:
> On 2015=E5=B9=B402=E6=9C=8804=E6=97=A5 01:20, Catalin Marinas wrote:
> > On Mon, Feb 02, 2015 at 12:45:37PM +0000, Hanjun Guo wrote:
> >> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> >> index afe10b4..b9f64ec 100644
> >> --- a/arch/arm64/kernel/acpi.c
> >> +++ b/arch/arm64/kernel/acpi.c
> >> @@ -13,6 +13,8 @@
> >>    *  published by the Free Software Foundation.
> >>    */
> >>
> >> +#define pr_fmt(fmt) "ACPI: " fmt
> >> +
> >>   #include <linux/acpi.h>
> >>   #include <linux/bootmem.h>
> >>   #include <linux/cpumask.h>
> >> @@ -49,10 +51,32 @@ void __init __acpi_unmap_table(char *map, unsi=
gned long size)
> >>   	early_memunmap(map, size);
> >>   }
> >>
> >> +static int __init acpi_parse_fadt(struct acpi_table_header *table=
)
> >> +{
> >> +	struct acpi_table_fadt *fadt =3D (struct acpi_table_fadt *)table=
;
> >> +
> >> +	/*
> >> +	 * Revision in table header is the FADT Major revision, and ther=
e
> >> +	 * is a minor revision of FADT which was introduced by ACPI 5.1,
> >> +	 * we only deal with ACPI 5.1 or newer revision to get GIC and S=
MP
> >> +	 * boot protocol configuration data, or we will disable ACPI.
> >> +	 */
> >> +	if (table->revision > 5 ||
> >> +	    (table->revision =3D=3D 5 && fadt->minor_revision >=3D 1))
> >> +		return 0;
> >> +
> >> +	pr_warn("Unsupported FADT revision %d.%d, should be 5.1+, will d=
isable ACPI\n",
> >> +		table->revision, fadt->minor_revision);
> >> +	disable_acpi();
> >> +
> >> +	return -EINVAL;
> >> +}
> >> +
> >>   /*
> >>    * acpi_boot_table_init() called from setup_arch(), always.
> >>    *	1. find RSDP and get its address, and then find XSDT
> >>    *	2. extract all tables and checksums them all
> >> + *	3. check ACPI FADT revision
> >>    *
> >>    * We can parse ACPI boot-time tables such as MADT after
> >>    * this function is called.
> >> @@ -64,8 +88,16 @@ void __init acpi_boot_table_init(void)
> >>   		return;
> >>
> >>   	/* Initialize the ACPI boot-time table parser. */
> >> -	if (acpi_table_init())
> >> +	if (acpi_table_init()) {
> >> +		disable_acpi();
> >> +		return;
> >> +	}
> >> +
> >> +	if (acpi_table_parse(ACPI_SIG_FADT, acpi_parse_fadt)) {
> >> +		/* disable ACPI if no FADT is found */
> >>   		disable_acpi();
> >> +		pr_err("Can't find FADT\n");
> >> +	}
> >>   }
> >
> > It looks fine to call disable_acpi() here but a bit weird to call i=
t
> > again in acpi_parse_fadt(). I guess that's because acpi_table_parse=
()
> > ignores the return value of the handler() call. I think it's better=
 to
> > fix the core code (can be an additional patch on top of this series=
).
>=20
> I checked all the code calling acpi_table_parse() and I found that it
> will be no functional change if we return the value of handler(), but
> I need Rafael's confirm on it.

Are you sure ? All calls to acpi_table_parse() that checks the return
value are affected. I guess that depends on what an error return from
the handler means, from acpi_table_parse():

* Return 0 if table found, -errno if not.

So, if table is found but parsing fails that acpi_table_parse()
signature should be changed if the handler barfs with an error and
it is propagated. Still, I share Catalin's comment.

Have you thought about getting the FADT through:

acpi_get_table_with_size()

and check the revision there instead of going through acpi_table_parse(=
)
for that ?

I wonder if the revision information is not already available without
needing to retrieve the FADT again.

On top of that, this patch should be squashed, I have a feeling that
between patch 4 and 9, there is a window where ACPI versions predating
5.1 are ok on arm64, which is not the case. I do not think that's a
bisectable issue, but keep this in mind please.

Thanks,
Lorenzo
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
