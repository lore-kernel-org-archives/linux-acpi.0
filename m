From: "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>
Subject: Re: acpi-20040715: functional regression on ASUS M2N
Date: Fri, 06 Aug 2004 22:50:34 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m3r7qkt2hx.fsf@reason.gnu-hamburg>
References: <4112814C.2070808@optonline.net>
	<m37jsc3424.fsf@reason.gnu-hamburg> <41138944.3060309@optonline.net>
	<m3u0vgurzy.fsf@reason.gnu-hamburg> <4113BAD5.1030909@optonline.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4113BAD5.1030909-p32f3XyCuykqcZcGjlUOXw@public.gmane.org> (Nathan Bryant's message of
	"Fri, 06 Aug 2004 13:07:33 -0400")
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=

 || On Fri, 06 Aug 2004 13:07:33 -0400
 || Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org> wrote: 

 >> Here is what it said for my machine during resume from suspend to
 >> ram: i8259: saving ELCR: 0xfffffff0 0x0a

 nb> Interesting. That translates into the following IRQ's set to level trigger:

 nb> 4
 nb> 5
 nb> 6 (!) floppy controller?
 nb> 7
 nb> 9
 nb> 11

Actually, this laptop has no floppy. In case it helps: 

--=-=-=
Content-Disposition: attachment
Content-Description: cat /proc/interrupts

           CPU0
  0:   13849154          XT-PIC  timer
  1:        595          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  4:          0          XT-PIC  ehci_hcd
  5:          0          XT-PIC  uhci_hcd
  6:          0          XT-PIC  Intel 82801DB-ICH4, yenta
  7:     146446          XT-PIC  uhci_hcd, yenta, eth1
  8:          4          XT-PIC  rtc
  9:     155025          XT-PIC  acpi
 11:       1019          XT-PIC  uhci_hcd, ohci1394, eth0
 12:       8438          XT-PIC  i8042
 14:      44918          XT-PIC  ide0
 15:        219          XT-PIC  ide1
NMI:          0
LOC:    2095462
ERR:          0
MIS:          0

--=-=-=
Content-Disposition: inline



 nb> But I don't think there's anything wrong with that. It does seem
 nb> that Matthew Garrett's message holds the key:
 nb> [...]

So should I try to change line 310 of drivers/base/sys.c to
list_for_each_entry_reverse and try again? 

Will this be useful to anyone to resolve things?

Regards,
Georg

-- 
Georg C. F. Greve                                       <greve-mXXj517/zsQ@public.gmane.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBE+8abvivwoZXSsoRAj50AJ9oKv9tNN+IfJjE0ABvDirt8L4lkACguIRb
4x3M9Egia3alr0CfZyngXFo=
=B53i
-----END PGP SIGNATURE-----
--==-=-=--


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
