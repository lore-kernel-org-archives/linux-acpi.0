From: =?ISO-8859-1?Q?Dennis_Lichtenth=E4ler?=
 <dennis.lichtenthaeler-ml43uUC8Ylsb1SvskN2V4Q@public.gmane.org>
Subject: ACPI preventing hotplug from working
Date: Wed, 18 Aug 2004 00:36:19 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <41228863.3070101@pfarroli.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi everyone!
I'm not sure I'm right on this list but neither the gentoo nor the
hotplug-guys were able to help me out...

Whenever I plug a USB device in _before_ boot it gets recognized as soon as
the hotplug-script is loaded, the modules get loaded and everything works like
a charm. If I plug the device in _after_ boot, nothing happens. There is no
sign at all that linux recognized me changing something.

I have tried the usual suspects and found out that it obviously had something
to do with ACPI as switching it off at boot (with acpi=off) fixes the problem.
I googled a bit and found that problems like this could be caused by a buggy
DSDT. After some more googling I found out how to disassemble it, did so,
found four or five errors, fixed them, recompiled the DSDT, had it load by the
kernel but - nothing changed. I'm told that the default DSDT is overridden by
a user-defined one (ACPI-0291: *** Info: Table [DSDT] replaced by host OS) so
my patching actually worked but it doesn't solve the problem.

Booting with
acpi_os_name="Microsoft Windows XP"
hasn't worked either.

I've tried different kernels now, the gentoo-supplied 2.6 one (I think it was
2.6.5) as well as the most recent 2.6.7-gentoo-r14. The same problem also
appeared on a default install of SuSE 9.1.
It is definitely not a hardware problem since with WinXP Home and with ACPI
disabled (on any kernel) hotplug works.

What makes this problem so incredibly annoying is that I can't seem to find
any starting point for debugging as there is no reaction to my plugging
in/plugging out at all.

Any tips would be greatly appreciated!
Dennis
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBIohjIYGOmjAGFHMRAjdcAKCyUCDwpiXpRA7VZnQskRzUv/oxSgCfbkJS
q+Ox2aP1nORPxks2KF/R2mc=
=G6DQ
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
