From: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>
Subject: [ACPI]: save_flags Macro and 2.5.28
Date: Fri, 26 Jul 2002 16:54:02 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200207261357.g6QDvVZ05963@pfn1.pefnos>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_2YZUE13RIXAI0QCEBSGG"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--------------Boundary-00=_2YZUE13RIXAI0QCEBSGG
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: 8bit

I just got the 2.5.28 patch and tried to compile it.
Note that 2.5.27 must have some serious bug and is seriously unstable, don't
use it!
As from 2.5.28 the save_flags()/restore_flags() macros are being deprecated.
I had to do the attached quick hack to compile the kernel.  There is a text
file in the 2.5.28 to read: 'Documentation/cli-sti-removal.txt'.

For the record, S1 seems to work, S3 still doesn't  (didn't work before
either) with that patch.

Can you comment on that hack? It *must* be wrong, how should it be?


This message is being sent for the second time. Sorry if it reaches you twice.
--------------Boundary-00=_2YZUE13RIXAI0QCEBSGG
Content-Type: text/x-diff;
  charset="iso-8859-7";
  name="acpi-system.c.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="acpi-system.c.diff"

LS0tIHN5c3RlbS5jLm9yaWcJVHVlIEp1biAxOCAxNDoxODo0NyAyMDAyCisrKyBzeXN0ZW0uYwlU
aHUgSnVsIDI1IDEzOjAwOjA4IDIwMDIKQEAgLTI2NSw3ICsyNTYsOCBAQAogCWFjcGlfc3RhdHVz
CQlzdGF0dXMgPSBBRV9FUlJPUjsKIAl1bnNpZ25lZCBsb25nCQlmbGFncyA9IDA7CgotCXNhdmVf
ZmxhZ3MoZmxhZ3MpOworCS8qc2F2ZV9mbGFncyhmbGFncyk7Ki8KKwlsb2NhbF9pcnFfc2F2ZShm
bGFncyk7CgogCXN3aXRjaCAoc3RhdGUpCiAJewpAQCAtMjc5LDcgKzI3MSw4IEBACiAJCWRvX3N1
c3BlbmRfbG93bGV2ZWwoMCk7CiAJCWJyZWFrOwogCX0KLQlyZXN0b3JlX2ZsYWdzKGZsYWdzKTsK
KwkvKnJlc3RvcmVfZmxhZ3MoZmxhZ3MpOyovCisJbG9jYWxfaXJxX3Jlc3RvcmUoZmxhZ3MpOwoK
IAlyZXR1cm4gc3RhdHVzOwogfQo=

--------------Boundary-00=_2YZUE13RIXAI0QCEBSGG--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
