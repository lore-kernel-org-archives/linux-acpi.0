From: "Ow Mun Heng" <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Subject: latest ACPI CA Patch (20040311) - Where??
Date: Fri, 12 Mar 2004 11:32:29 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C386328088ED7F4E9F81AFBABDDF60DA04A92629@wdmyexch02.my.asia.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Acpi-List (E-mail)" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi All,

Received this  based on bug #2066

http://bugme.osdl.org/show_bug.cgi?id=3D2066

I would like to try it out. I can't seem to find it on the =
DL/sourceforge
site. All I could find was 20040220 based on 2.6.4 kernel.

BTW, I'm using 2.6.3 and 20040211 patch and the few patches from Luming=20
for this bug.

------- Additional Comments From Robert.Moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org  2004-03-11 =
14:55
-------

Should be fixed in CA version 20040311:


Fixed a problem where errors occurring during the parse phase of control =

method execution did not abort cleanly.  For example, objects created =
and=20
installed in the namespace were not deleted.  This caused all subsequent =

invocations of the method to return the AE_ALREADY_EXISTS exception.

Implemented a mechanism to force a control method to "Serialized" =
execution
if=20
the method attempts to create namespace objects. (The root of the=20
AE_ALREADY_EXISTS problem.)

=3D----------------------------------

Cheers,                                                 .^.
Mun Heng, Ow                                            /V\
H/M Engineering                                       /(   )\
Western Digital M'sia                                  ^^-^^
DID : 03-7870 5168                          The Linux Advocate

       =20


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
