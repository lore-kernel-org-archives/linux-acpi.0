From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI: S3 and PAE do not like each other for now, S3 disabled.
Date: Wed, 28 Jul 2004 17:27:43 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B44D37711ED29844BEA67908EAF36F036BD577@pdsmsx401.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C47485.2313146F"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C47485.2313146F
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
The patch is very sample. Tested in one desktop (Dell precision 350).

Thanks,
Shaohua

=3D=3D=3D=3D=3D arch/i386/kernel/acpi/sleep.c 1.4 vs edited =
=3D=3D=3D=3D=3D
--- 1.4/arch/i386/kernel/acpi/sleep.c	2003-08-06 02:29:57 +08:00
+++ edited/arch/i386/kernel/acpi/sleep.c	2004-07-28 17:15:45
+08:00
@@ -77,10 +77,7 @@ void __init acpi_reserve_bootmem(void)
 		printk(KERN_ERR "ACPI: Wakeup code way too big, S3
disabled.\n");
 		return;
 	}
-#ifdef CONFIG_X86_PAE
-	printk(KERN_ERR "ACPI: S3 and PAE do not like each other for
now, S3 disabled.\n");
-	return;
-#endif
+
 	acpi_wakeup_address =3D (unsigned
long)alloc_bootmem_low(PAGE_SIZE);
 	if (!acpi_wakeup_address)
 		printk(KERN_ERR "ACPI: Cannot allocate lowmem, S3
disabled.\n");


>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
>admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Pavel Machek
>Sent: Wednesday, July 28, 2004 4:29 PM
>To: Li, Shaohua
>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: [ACPI] ACPI: S3 and PAE do not like each other for now, S3
>disabled.
>
>Hi!
>
>> I did test it in my desktop (disabling HT and removing the check),
and
>> it worked. Is there any special reason that you disabled it before?
>
>That reason no longer applies. Can you submit a patch?
>								Pavel
>
>--
>People were complaining that M$ turns users into beta-testers...
>...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by BEA Weblogic Workshop
>FREE Java Enterprise J2EE developer tools!
>Get your free copy of BEA WebLogic Workshop 8.1 today.
>http://ads.osdn.com/?ad_id=3D4721&alloc_id=3D10040&op=3Dclick
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel

------_=_NextPart_001_01C47485.2313146F
Content-Type: application/octet-stream;
	name="pae.patch"
Content-Transfer-Encoding: base64
Content-Description: pae.patch
Content-Disposition: attachment;
	filename="pae.patch"

PT09PT0gYXJjaC9pMzg2L2tlcm5lbC9hY3BpL3NsZWVwLmMgMS40IHZzIGVkaXRlZCA9PT09PQot
LS0gMS40L2FyY2gvaTM4Ni9rZXJuZWwvYWNwaS9zbGVlcC5jCTIwMDMtMDgtMDYgMDI6Mjk6NTcg
KzA4OjAwCisrKyBlZGl0ZWQvYXJjaC9pMzg2L2tlcm5lbC9hY3BpL3NsZWVwLmMJMjAwNC0wNy0y
OCAxNzoxNTo0NSArMDg6MDAKQEAgLTc3LDEwICs3Nyw3IEBAIHZvaWQgX19pbml0IGFjcGlfcmVz
ZXJ2ZV9ib290bWVtKHZvaWQpCiAJCXByaW50ayhLRVJOX0VSUiAiQUNQSTogV2FrZXVwIGNvZGUg
d2F5IHRvbyBiaWcsIFMzIGRpc2FibGVkLlxuIik7CiAJCXJldHVybjsKIAl9Ci0jaWZkZWYgQ09O
RklHX1g4Nl9QQUUKLQlwcmludGsoS0VSTl9FUlIgIkFDUEk6IFMzIGFuZCBQQUUgZG8gbm90IGxp
a2UgZWFjaCBvdGhlciBmb3Igbm93LCBTMyBkaXNhYmxlZC5cbiIpOwotCXJldHVybjsKLSNlbmRp
ZgorCiAJYWNwaV93YWtldXBfYWRkcmVzcyA9ICh1bnNpZ25lZCBsb25nKWFsbG9jX2Jvb3RtZW1f
bG93KFBBR0VfU0laRSk7CiAJaWYgKCFhY3BpX3dha2V1cF9hZGRyZXNzKQogCQlwcmludGsoS0VS
Tl9FUlIgIkFDUEk6IENhbm5vdCBhbGxvY2F0ZSBsb3dtZW0sIFMzIGRpc2FibGVkLlxuIik7Cg==

------_=_NextPart_001_01C47485.2313146F--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
