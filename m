From: Masanori Kanaoka <kanaoka-Y4eNCM2L5QUzdwRXePBTQw@public.gmane.org>
Subject: Re: Fix wake GPE enabling
Date: Fri, 09 Apr 2004 19:10:44 +0900 (JST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040409.191044.193699980.kanaoka@ann.hi-ho.ne.jp>
References: <37F890616C995246BE76B3E6B2DBE0554F1A3B@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: Multipart/Signed; protocol="application/pgp-signature";
 micalg=pgp-sha1;
 boundary="--Security_Multipart(Fri_Apr__9_19_10_44_2004_542)--"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <37F890616C995246BE76B3E6B2DBE0554F1A3B-sBd4vmA9Se5Qxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: kochi-S783fYmB3Ccdnm+yROfE0A@public.gmane.org, linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

----Security_Multipart(Fri_Apr__9_19_10_44_2004_542)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi

       From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    Subject: RE: [ACPI] Fix wake GPE enabling
      Date : Thu, 08 Apr 2004 09:32:35 -0700
 Message-ID: <37F890616C995246BE76B3E6B2DBE0554F1A3B-sBd4vmA9Se5Qxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>

$ Found something in the ACPI Specification:

$ Section 5.6.2.2.1, "Wake Events" (Under "General-Purpose Event Handling)

$ "Events that wake may not be intermixed with non-wake events on the same
$ GPE input. Also, all wake events not exclusively tied to a GPE input
$ (for example, one input is shared for multiple wake events) need to have
$ individual enable and status bits in order to properly handle the
$ semantics used by the system."

$ Bob

I found same section in ACPI-2.0a.pdf(20020331).

On My TOSHIBA Libretto L3, 
  - _GPE has two Methods(_L09 and _L1A).
  - USB1,ASND,LAN_ and CBC0 have _PWR that a first element is 0x09.
  - _LID has _PWR that a first element is 0x1A.
  - _GPE notify some devices(include _LID) via _L1A.

Is it broken?
TOSHIBA Libretto L1, L2 seem same.

You can find My LibrettoL3.asl and .dsdt file at:
  http://www.ann.hi-ho.ne.jp/~kanaoka/librettoL3.{asl,dsdt}

and also find LibrettoL1/L2's file at:
  http://www.jp.freebsd.org/cgi/cvsweb.cgi/ACPI/data/Libretto-L1-060TNMM.asl?cvsroot=freebsd-jp
  http://www.jp.freebsd.org/cgi/cvsweb.cgi/ACPI/data/Libretto-L1-060TNMM.dsdt?cvsroot=freebsd-jp
  http://www.jp.freebsd.org/cgi/cvsweb.cgi/ACPI/data/Libretto-L2-060TNML.asl?cvsroot=freebsd-jp
  http://www.jp.freebsd.org/cgi/cvsweb.cgi/ACPI/data/Libretto-L2-060TNML.dsdt?cvsroot=freebsd-jp

If it is broken, How can I avoid this problem ?
Any suggestions ?

Best Regards
---
 Masanori Kanaoka	kanaoka-Y4eNCM2L5QUzdwRXePBTQw@public.gmane.org


----Security_Multipart(Fri_Apr__9_19_10_44_2004_542)--
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (NetBSD)

iQEVAwUAQHZ2uaZTiBfoL27MAQIBxAgAmv8UnHVWKlZwo7hWQxsPyUvPmO9V2r+f
HDSJfhkIm/kI3vvsNcTJiYicurJ/qenhMGUaNVs8CrUbxqlKjUZVTFhrzVsMZuvT
tKIdPGU1h0CE2eRVgrsjyaPhvKS3rIkNHcOZnbk6E1XmxOZek+6MiUaaxMXG1AhA
hQMIj57gwaDDQWFsr9CpjjXWjQbdNoYHxx7Sd9uLaYlkkYExD+SHvxHoORPMKip0
Mw5y+LK2VYrzvFMarccMT7Esw+jmSIidLNZK1CpqMk5vgdmRwfzgwaU7X7MRNHlI
j7mXxoKOcUSr2GaP6goPWnKtmpRADA+EH7J8kRZFRC7eAZgKLkSHQw==
=cF5t
-----END PGP SIGNATURE-----

----Security_Multipart(Fri_Apr__9_19_10_44_2004_542)----


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
