From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: S3 suspend/resume driver questions
Date: Sun, 18 Apr 2004 12:50:45 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40825D85.1000702@pca.it>
References: <GMail.1082282809.299052003.09816679024@brewt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <GMail.1082282809.299052003.09816679024-CDLCgzMZgTDYtjvyW6yDsg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

on 04/18/04 12:06, Adrian Yee wrote:
> For the alsa intel8x0 driver, I just added code to save/restore the pci
> state on suspend and resume.  Is this the correct way to fix the problem?
mine isn't a technical reply, but you can post in the 'alsa-devel' mailing-list,
as it seems that Takashi Iwai is working on PM-lacking drivers. Here some links:
   http://sourceforge.net/mailarchive/forum.php?thread_id=4201761&forum_id=1752
   http://sourceforge.net/mailarchive/forum.php?thread_id=4107033&forum_id=1752

BTW-1, could you post your 'intel8x0' patch? I could give it a try ASAP...

BTW-2, in the few tests I made on my ASUS M6842NWH ('intel8x0' based), I have to
remove the sound modules even to have a successfull S1.

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAgl2FVAp7Xm10JmkRAtYxAJ4+uklo8A7tAxG9b1pgTiTpN/iNzwCfSEa8
cAGeBAq40j20Uyvdv8YMTXc=
=zQPa
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
