From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: ASUS M6800N: battery0 not present
Date: Wed, 18 Feb 2004 18:13:45 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40339D49.4030002@pca.it>
References: <40324F44.60006@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <40324F44.60006-wlebWZzHoyE@public.gmane.org>
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

on 02/17/04 18:28, Luca Capello wrote:
> Now, the real problem is in these lines:
>>>Feb 16 16:42:40 localhost kernel: ACPI: Looking for DSDT in initrd ...
> found customized DSDT with 22420 bytes!
> <cut>
>>>Feb 16 16:42:40 localhost kernel: ACPI: Subsystem revision 20040211
>>>Feb 16 16:42:40 localhost kernel: ACPI: Using customized DSDT
>>>Feb 16 16:42:40 localhost kernel:    tbget-0299: *** Info: Table
>> [DSDT] replaced by host OS
>>>Feb 16 16:42:40 localhost kernel:  tbxface-0117 [03] acpi_load_tables
>
>      : ACPI Tables successfully acquired
>
> /et-voilà/: the kernel reads my customized DSDT, but after it doesn't
> used it (the 'replaced by host OS' message), so I've the corrected DSDT
> in /proc/acpi/dsdt, but not used. Am I right? In fact, I get all the
> errors I've with the original DSDT (which I'd like to correct, but after
> having booted with the new DSDT).
sorry, but reading 'drivers/acpi/table/tbget.c' let me know that the
message above is the correct one: the DSDT in the BIOS is replaced with
the new one, which in my case is taken via the initrd patch. If this is
not true, please someone could correct me?

So, now the problem is that I can't use Andre's DSDT, I mean, I can use
it, but with no changes. I suppose this is due to the more recent BIOS I
use, am I right?

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAM51IVAp7Xm10JmkRAqNrAKCKjEMzjIy7jH53cLeeViaLs2jZ/gCfdahm
sxaaG90KNyn+RFfE34FoUGg=
=Xsog
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
