From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI-0361: *** Error: GPE0 block overlaps the GPE1 blo
	 ck
Date: Wed, 23 Oct 2002 09:52:45 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19B889@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'Paul Hernandez' <ph-zlWNigPkEOiLxM0KKU+/dQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Apparently, this machine has a GPE1 block but no GPE0 block.  We will post a
patch that handles this case correctly.

Bob Moore


-----Original Message-----
From: Moore, Robert [mailto:robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org] 
Sent: Friday, October 18, 2002 9:14 AM
To: 'Paul Hernandez'; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: RE: [ACPI] ACPI-0361: *** Error: GPE0 block overlaps the GPE1 blo
ck


Paul,

Looking at the code in evevent.c, I have a theory about why this may be
happening.  It would help greatly if you can send the binary FADT from this
system.

Thanks,
Bob Moore


-----Original Message-----
From: Paul Hernandez [mailto:ph-zlWNigPkEOiLxM0KKU+/dQ@public.gmane.org] 
Sent: Friday, October 18, 2002 8:38 AM
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [ACPI] ACPI-0361: *** Error: GPE0 block overlaps the GPE1 block


Hello,

Received the  following is dmesg output:

 ACPI: Subsystem revision 20020829
 PCI: PCI BIOS revision 2.10 entry at 0xfd921, last bus=4
 PCI: Using configuration type 1
       ACPI-0361: *** Error: GPE0 block overlaps the GPE1 block
 ACPI: Unable to start the ACPI Interpreter

Using: 2.4.19.SuSE  (SuSE 8.1)
Motherboard: Intel SE7500CW2 Dual CPU Xeon Server board
with latest bios patch from Intel

Will happily test patches for you if you'd like.

Regards,

		Paul Hernandez  408-374-8686  x202
		Campbell, CA



|
| Does your patch resolve this as well?

Nope, it does not.  I don't know anything about that one.
If you want to follow-up on that problem, please send an
email about it to acpi-devel-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org .

~Randy




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
