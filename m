From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Re: S3 resume on Fujitsu-Siemens Amilo A7620 (CONTINUES)
Date: Tue, 30 Nov 2004 19:39:03 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC0CA@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alberto Piai <albeclemit-whZMOeQn8C0@public.gmane.org>
Cc: pavel-AlSwsSmVLrQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>Update:
>2.6.9, with pushl and popl lines commented out:

http://bugzilla.kernel.org/show_bug.cgi?id=3D3586

How could pushl	$0 cause reboot in real mode?
I guess it is in protect mode.

I suggest you to try the following patch to see if "pushl $0" still
cause=20
reboot.

--- linux-2.6.10-rc2/arch/i386/kernel/acpi/wakeup.S.orig
2004-12-02=20
18:18:01.132147992 -0800
+++ linux-2.6.10-rc2/arch/i386/kernel/acpi/wakeup.S	2004-12-02=20
18:17:34.872140120 -0800
@@ -20,6 +20,8 @@
 	wakeup_code_start =3D .
 	.code16
=20
+	xor	%eax, %eax
+	movl	%eax, %cr0
  	movw	$0xb800, %ax
 	movw	%ax,%fs
 	movw	$0x0e00 + 'L', %fs:(0x10)


Thanks,
Luming


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
