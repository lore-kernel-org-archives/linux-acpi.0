From: Borislav Petkov <bp@alien8.de>
Subject: Re: [Patch] MCE, APEI: Don't enable CMCI when Firmware First mode is
 set in HEST for corrected machine checks
Date: Tue, 7 May 2013 20:51:51 +0200
Message-ID: <20130507185151.GE7633@pd.tnic>
References: <1367881102.4518.68.camel@oc3432500282.ibm.com>
 <20130506232537.GF22041@pd.tnic>
 <1367897566.4518.83.camel@oc3432500282.ibm.com>
 <20130507131946.GC7633@pd.tnic>
 <1367941214.4518.90.camel@oc3432500282.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:40725 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756226Ab3EGSvR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 May 2013 14:51:17 -0400
Content-Disposition: inline
In-Reply-To: <1367941214.4518.90.camel@oc3432500282.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Max Asbock <masbock@linux.vnet.ibm.com>
Cc: tony.luck@intel.com, linux-acpi@vger.kernel.org, ying.huang@intel.com, naveen.n.rao@in.ibm.com, ananth@in.ibm.com, lcm@linux.vnet.ibm.com

On Tue, May 07, 2013 at 08:40:14AM -0700, Max Asbock wrote:
> So something like the following patch might be closer:

Yep, we're getting there.

[ =E2=80=A6 ]

> +static bool cmc_firmware_first;

Why the global variable?

You can pass it as a pointer to apei_hest_parse so that
check_cmc_firmware_first can set its value. See below:

> +static int check_cmc_firmware_first(struct acpi_hest_header *hest_hd=
r, void *d)
> +{
> +	if (hest_hdr->type =3D=3D ACPI_HEST_TYPE_IA32_CORRECTED_CHECK) {
> +		struct acpi_hest_ia_corrected *cmc;
> +
> +		cmc =3D (struct acpi_hest_ia_corrected *)hest_hdr;
> +		if (cmc->flags & ACPI_HEST_FIRMWARE_FIRST) {
> +			cmc_firmware_first =3D true;
> +			return 1;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static void disable_cmci(void *data)
> +{
> +	if (!mce_available(__this_cpu_ptr(&cpu_info)))
> +		return;
> +	cmci_clear();
> +}
> +
> +static __init int honor_cmc_firmware_first(void)
> +{
> +	apei_hest_parse(check_cmc_firmware_first, NULL);

> +
> +	if (cmc_firmware_first && !mca_cfg.cmci_disabled) {
> +		on_each_cpu(disable_cmci, NULL, 1);
> +		mca_cfg.cmci_disabled =3D true;

Well, in looking at the code more, there's set_cmci_disabled() in mce.c=
=2E
You can make a helper which contains only the meat of this function
without the buffer parsing and export it to users.

This way you don't need to touch anything else in mce.c - only this
helper.

IOW, I think it can be as simple as this:

static __init int honor_cmc_firmware_first(void)
{
	bool ff =3D false;

	/*
	 * XXX: you need to check error code here and return early accordingly
	 */
	apei_hest_parse(check_cmc_firmware_first, &ff);

	if (ff)
		disable_cmci();		/* <--- helper */

	/*
	 * Perhaps an informational message here:
	 */
	pr_info("APEI: Switching to Firmware-First mode.\n");

	return 0;
}
late_initcall(honor_cmc_firmware_first);

And this chunk should be in drivers/acpi/apei/ and not in arch/x86/.

Thanks.

--=20
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
