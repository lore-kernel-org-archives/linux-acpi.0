From: Masanori Kanaoka <kanaoka-Y4eNCM2L5QUzdwRXePBTQw@public.gmane.org>
Subject: Re: Fix wake GPE enabling
Date: Sat, 10 Apr 2004 08:27:55 +0900 (JST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040410.082755.189733959.kanaoka@ann.hi-ho.ne.jp>
References: <37F890616C995246BE76B3E6B2DBE0554F207E@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: Multipart/Signed; protocol="application/pgp-signature";
 micalg=pgp-sha1;
 boundary="--Security_Multipart(Sat_Apr_10_08_27_55_2004_102)--"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <37F890616C995246BE76B3E6B2DBE0554F207E-sBd4vmA9Se5Qxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
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

----Security_Multipart(Sat_Apr_10_08_27_55_2004_102)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

       From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    Subject: RE: [ACPI] Fix wake GPE enabling
      Date : Fri, 09 Apr 2004 09:57:01 -0700
 Message-ID: <37F890616C995246BE76B3E6B2DBE0554F207E-sBd4vmA9Se5Qxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>

$ GPE 09 with _L09 looks OK, it is clearly a wake GPE (because all the
$ Notify statements within it are of the form Notify(XXXX, 2) -- 2 means
$ "wake".

$ GPE 1A appears to be a runtime GPE, therefore the _PWR method under _LID
$ looks suspicious.

Thank you for detailed explanation.
I see this. 

So with acpica 20040326 or later, GPE does not enabled on My libretto L3.
I set FLASE to AcpiGbl_LeaveWakeGpesDisabled to avoid this problem.

I don't know whether it is right way or not.
Any suggestions?

Best Regards.
---
 Masanori Kanaoka	kanaoka-Y4eNCM2L5QUzdwRXePBTQw@public.gmane.org



----Security_Multipart(Sat_Apr_10_08_27_55_2004_102)--
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (NetBSD)

iQEVAwUAQHcxhaZTiBfoL27MAQJq3Qf/axnPZKaqzP91raLKkm969aZniHVJwYBi
jAAB6Hck/DTQTz+qihd9sBY3FMz9wQ1lvRzTF/x0x7wrChGSLBDom65dULwxYN99
maa4NdZJazWa0l2BfLILQVJC7ABCleFNGSs6D3izDt0At4rWPQ/fxv1167mKtvP3
8vPv1JKQAG80+8hYSbO3mYe16jVQHw2A/PKo84VlOmfrF7gsheJ1Niu6DbmAsphs
zTVnZOgsU6CI0MDjbsVe0Gz7aB3GjHb2ihs/IgFC9bgxpxWRuDup1uwlxgSccCvE
K5iXRBMfkwIyPVK6l7evKnvRKTRWpMPcoQGr/mXwr5hmlfOVgv/wBQ==
=oAAN
-----END PGP SIGNATURE-----

----Security_Multipart(Sat_Apr_10_08_27_55_2004_102)----


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
