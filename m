From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: ASUS M6800N: processor has only C1
Date: Thu, 04 Mar 2004 14:53:44 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <404734E8.7080104@pca.it>
References: <404459FD.1000406@pca.it> <20040302110946.GF2869@poupinou.org> <40448169.6090507@pca.it> <40449D8E.4060402@pca.it> <20040303103528.GG2869@poupinou.org> <40463D80.8040800@pca.it> <20040304111240.GN2869@poupinou.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000801030508080503040006"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040304111240.GN2869-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------000801030508080503040006
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

on 03/04/04 12:12, Bruno Ducrot wrote:
> Could you please try:
>
> --- linux-2.6-bk/drivers/acpi/processor.c	2004/03/04 11:05:47	1.2
> +++ linux-2.6-bk/drivers/acpi/processor.c	2004/03/04 11:09:21
> @@ -649,8 +649,8 @@ acpi_processor_get_power_info_cst (
>
>  	count = cst->package.elements[0].integer.value;
>
> -	/* There must be at least 2 power states. */
> -	if (count <= 1 || count != cst->package.count - 1) {
> +	/* There must be at least one power state (some bios forgot C1), and
validate count */
> +	if (count < 1 || count != cst->package.count - 1) {
>  		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _CST data\n"));
>  		status = -EFAULT;
>  		goto end;
no problem, I forgot to advise you that I can make all the necessary tests to
bring my new laptop to a completely ACPI working system :-)

> I think also that the bios will only allow C2, not C3 nor C4 if you are on AC.
You're right, but even on battery I get only C1 & C2 (as from the attached).

> Could you then try on battery also?  Note that I have not implemented
> yet the reevaluation of _CST in case of AC/battery switch...
As above, it doesn't matter if I'm on battery or on AC: it's the same, but
anyway I have no more the _CST error message, but only the PBLK length one.

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFARzTnVAp7Xm10JmkRAo/2AJ93Hek8RsyZvF2hlrVjgAdVAsWSsACeILws
mLV3QeCgx3/wbW6onD3ZX8k=
=Mhm+
-----END PGP SIGNATURE-----

--------------000801030508080503040006
Content-Type: application/x-gzip;
 name="2.6.4-rc1.processor-cst.20040304.battery.script.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="2.6.4-rc1.processor-cst.20040304.battery.script.gz"

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
--------------000801030508080503040006--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
