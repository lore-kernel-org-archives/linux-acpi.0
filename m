From: Hrvoje Habjanic <hrvoje.habjanic-wUpq2f5uKgb0NTdHYsHBKg@public.gmane.org>
Subject: Oopses enterning S5 state
Date: Fri, 20 Jun 2003 09:20:27 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200306200920.27877.hrvoje.habjanic@zg.hinet.hr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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


Hi!

Compaq Armada M700, 2.4.21 kernel with acpi-20030523-2.4.21-rc3.
(for additional info - http://free-zg.htnet.hr/HrvojeHabjanic/acpi ).

echo "5" > /proc/acpi/sleep

and then:

[ACPI Debug] String: _PTS:  Enter
[ACPI Debug] Integer: 0000000000000005
[ACPI Debug] String: Going into SOFTOFF State
[ACPI Debug] String: _PTS:  Exit
[ACPI Debug] String: _WAK:  Enter
[ACPI Debug] Integer: 0000000000000005
[ACPI Debug] String: _WAK:  Exit
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c011409b
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c011409b>]    Not tainted
EFLAGS: 00010002
eax: 00000000   ebx: 00000005   ecx: 00000000   edx: 00000000
esi: 00000005   edi: 00000005   ebp: c12cc780   esp: ce3aff1c
ds: 0018   es: 0018   ss: 0018
Process bash (pid: 637, stackpage=ce3af000)
Stack: c01b9df9 00000005 00000001 c01b9f3c 00000005 00000005 00000005 00000005 
       00000002 ce3aff50 ce3aff60 c01ba7d0 00000005 02000000 c0283b1e c0283a15 
       ce4d26c0 00000a35 00000000 00000000 ce4d26c0 00000000 cf405b60 ffffffea 
Call Trace:    [<c01b9df9>] [<c01b9f3c>] [<c01ba7d0>] [<c015c520>] [<c013b403>]
  [<c010740f>]

Code: 89 02 0f 20 d8 0f 22 d8 31 d2 a1 24 f7 30 c0 e9 f1 0e 02 00 


S3 doesn't work either, but that is (maybe) because there isn't partition defined for suspend-2-disk.

Hrvoje


p.s. New acpi kernel patch soon?



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
