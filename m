From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: Poweroff works intermittently
Date: Tue, 30 Mar 2004 15:59:16 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40697D34.9050507@pca.it>
References: <40696F10.7020009@tiscali.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <40696F10.7020009-IWqWACnzNjyonA0d6jMUrA@public.gmane.org>
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

on 03/30/04 14:58, Nico wrote:
> halt doesn't always shut down the system, instead it hangs after having
> written "entering sleep state s5" on the console.
well, IMHO it doesn't hang, it "just" doesn't turn off the machine, but all the
rest is ok. You can verify at next boot: normally the HD is ok and there's no
check for errors (like any other machine-freezing).

I had the same problem on my ASUS laptop (M6842NWH). There're 2 possible solutions:

- - disable APIC/Local-APIC (at boot with 'noapic/nolapic' or in the kernel), in
  many cases (as in mine) this solves the problem

- - using Hartwig Felger's patch, other infos
	http://marc.theaimsgroup.com/?l=acpi4linux&m=107842464918369&w=2
	http://bugme.osdl.org/show_bug.cgi?id=2109

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAaX0zVAp7Xm10JmkRAmVUAJsFVa4KLtVg3pWIJtavQO1EzsnDHwCgg01n
3PPBOC1ZUIPRI5ad6Yl1Lak=
=aIyo
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
