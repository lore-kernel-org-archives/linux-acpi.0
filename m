From: "Paul Hernandez" <ph-zlWNigPkEOiLxM0KKU+/dQ@public.gmane.org>
Subject: ACPI-0361: *** Error: GPE0 block overlaps the GPE1 block
Date: Fri, 18 Oct 2002 08:38:26 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <FMEDJKFPPLANNCCEABDMEEKECBAA.ph@digitalquake.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


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
