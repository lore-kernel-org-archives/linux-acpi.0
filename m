From: Frank Mehnert <fm3-IG//nw+yl+iQIjdd1DhZXWfrygkm6VTR@public.gmane.org>
Subject: Re: IBM T41 + ACPI + APIC
Date: Thu, 12 Aug 2004 21:56:38 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200408122156.42419.fm3@os.inf.tu-dresden.de>
References: <F760B14C9561B941B89469F59BA3A8470726A996@orsmsx401.amr.corp.intel.com> <411BA242.6010103@optonline.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_6t8GBxRC5RQ35PL";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <411BA242.6010103-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Boundary-02=_6t8GBxRC5RQ35PL
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 12 August 2004 19:00, Nathan Bryant wrote:
> Grover, Andrew wrote:
> > You need an IOAPIC. The local APIC is basically just the part of the CPU
> > that receives messages from the IOAPIC, if present.
>
> By the way, it is a bad idea to use front-side-bus interrupt delivery on
> some (all?) Intel mobile processors/chipsets. This prevents entering C3,
> if I remember correctly. The real details are in the i850-M databook...

BTW: Why does Linux not use the Local APIC timer as a source for timer=20
interrupts? Using the Local APIC timer saves the kernel from acknowledging
the PIT IRQ. Acknowledging the Local APIC IRQ is _much_ cheaper.

=46rank
=2D-=20
## Dept. of Computer Science, Dresden University of Technology, Germany ##
## http://os.inf.tu-dresden.de/~fm3                                     ##

--Boundary-02=_6t8GBxRC5RQ35PL
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBG8t66z8pigLf3EcRAnucAJ4vdOZc3lWPXAC+dwVZF8sA2/NIDQCfQcqY
VcZCWUQKsGdjaDrN+KiKHuc=
=NtPN
-----END PGP SIGNATURE-----

--Boundary-02=_6t8GBxRC5RQ35PL--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
