From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: RV: differences between acpidump and disassembling
Date: Tue, 20 Apr 2004 23:15:19 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <408592E7.7050105@pca.it>
References: <000201c4271b$37662da0$0301a8c0@portatil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <000201c4271b$37662da0$0301a8c0-qXvZZVhXUsA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'acpi-devel' <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

on 04/20/04 23:05, Emilio Mejía Fernández de Velasco wrote:
> The only reason why I used 2.6.4 for acpi was that there was no patch to
> override the dsdt with initrd available for 2.6.5
if there's no patch available for the latest 2.6.5 it doesn't mean that the
patch for 2.6.4 doesn't work on 2.6.5. In fact this isn't correct: the contrary
is true, I successfully patched a vanilla 2.6.5 with the ACPI DSDT in initrd
patch for 2.6.4 (Jose Bernardo Silva one from http://gaugusch.at/kernel.shtml).

> Anyway, the only solution is to give up and wait until some kernel comes
> and works with my laptop -and acpi-.
Doesn't Sergio Monteiro Basto advise you that you don't need any custom DSDT?
You should be able to use any vanilla kernel + ACPI patches with the original DSDT.

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAhZLmVAp7Xm10JmkRAn+XAKCEiTsykWedAO1MgsuEM8GZ2xb4WwCggZzD
9z4quaMBDdGLXOjSlEBFqt8=
=w237
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
