From: "Thomas, Sujith" <sujith.thomas@intel.com>
Subject: RE: [patch 4/6] ACPI processor: extract return values using PTR_ERR
Date: Fri, 15 Feb 2008 16:16:06 +0530
Message-ID: <05B550FD4BD2014E841D83547B62600802AA6942@bgsmsx411.gar.corp.intel.com>
References: <05B550FD4BD2014E841D83547B62600802AA6506@bgsmsx411.gar.corp.intel.com> <1203058278.4013.4.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C86FBF.F33F4D1A"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:49610 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757784AbYBOKrO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Feb 2008 05:47:14 -0500
Content-class: urn:content-classes:message
In-Reply-To: <1203058278.4013.4.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhao, Yakui" <yakui.zhao@intel.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, "Zhang, Rui" <rui.zhang@intel.com>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C86FBF.F33F4D1A
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=20

> -----Original Message-----
> From: Zhao, Yakui=20
> Sent: Friday, February 15, 2008 12:21 PM
> To: Thomas, Sujith
> Cc: lenb@kernel.org; linux-acpi@vger.kernel.org; Zhang, Rui
> Subject: Re: [patch 4/6] ACPI processor: extract return=20
> values using PTR_ERR
>=20
> On Fri, 2008-02-15 at 10:54 +0530, Thomas, Sujith wrote:
> > From: Thomas Sujith <sujith.thomas@intel.com>
> >=20
> > Need to extract errors using PTR_ERR macro and
> > process accordingly.thermal_cooling_device_register
> > returning NULL means that CONFIG_THERMAL=3Dn and in that
> > case no need to create symbolic links.

> Very good. But is it necessary to check whether the cooling device
> exists before it is unregistered?=20

I agree; resending the patch

Subject: ACPI processor : extract return values using PTR_ERR
From: Thomas Sujith <sujith.thomas@intel.com>

Need to extract errors using PTR_ERR macro and
process accordingly.thermal_cooling_device_register
returning NULL means that CONFIG_THERMAL=3Dn and in that
case no need to create symbolic links.

Signed-off-by: Thomas Sujith <sujith.thomas@intel.com>
 drivers/acpi/processor_core.c |   37
++++++++++++++++++++++---------------
 1 files changed, 22 insertions(+), 15 deletions(-)

Index: linux-2.6.24/drivers/acpi/processor_core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.24.orig/drivers/acpi/processor_core.c
+++ linux-2.6.24/drivers/acpi/processor_core.c
@@ -670,21 +670,26 @@ static int __cpuinit acpi_processor_star
=20
 	pr->cdev =3D thermal_cooling_device_register("Processor", device,
 						&processor_cooling_ops);
-	if (pr->cdev)
+	if (IS_ERR(pr->cdev)) {
+		result =3D PTR_ERR(pr->cdev);
+		goto end;
+	}
+	if (pr->cdev) {
 		printk(KERN_INFO PREFIX
 			"%s is registered as cooling_device%d\n",
 			device->dev.bus_id, pr->cdev->id);
-	else
-		goto end;
=20
-	result =3D sysfs_create_link(&device->dev.kobj,
&pr->cdev->device.kobj,
-					"thermal_cooling");
-	if (result)
-		return result;
-	result =3D sysfs_create_link(&pr->cdev->device.kobj,
&device->dev.kobj,
-					"device");
-	if (result)
-		return result;
+		result =3D sysfs_create_link(&device->dev.kobj,
+					   &pr->cdev->device.kobj,
+					   "thermal_cooling");
+		if (result)
+			return result;
+		result =3D sysfs_create_link(&pr->cdev->device.kobj,
+					   &device->dev.kobj,
+					   "device");
+		if (result)
+			return result;
+	}
=20
 	if (pr->flags.throttling) {
 		printk(KERN_INFO PREFIX "%s [%s] (supports",
@@ -809,10 +814,12 @@ static int acpi_processor_remove(struct=20
=20
 	acpi_processor_remove_fs(device);
=20
-	sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
-	sysfs_remove_link(&pr->cdev->device.kobj, "device");
-	thermal_cooling_device_unregister(pr->cdev);
-	pr->cdev =3D NULL;
+	if (pr->cdev) {
+		sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
+		sysfs_remove_link(&pr->cdev->device.kobj, "device");
+		thermal_cooling_device_unregister(pr->cdev);
+		pr->cdev =3D NULL;
+	}
=20
 	processors[pr->id] =3D NULL;
=20

------_=_NextPart_001_01C86FBF.F33F4D1A
Content-Type: application/octet-stream;
	name="[patch 4 of 6] ACPI processor - extract return value using PTR_ERR"
Content-Transfer-Encoding: base64
Content-Description: [patch 4 of 6] ACPI processor - extract return value using PTR_ERR
Content-Disposition: attachment;
	filename="[patch 4 of 6] ACPI processor - extract return value using PTR_ERR"

U3ViamVjdDogQUNQSSBwcm9jZXNzb3IgOiBleHRyYWN0IHJldHVybiB2YWx1ZXMgdXNpbmcgUFRS
X0VSUgpGcm9tOiBUaG9tYXMgU3VqaXRoIDxzdWppdGgudGhvbWFzQGludGVsLmNvbT4KCk5lZWQg
dG8gZXh0cmFjdCBlcnJvcnMgdXNpbmcgUFRSX0VSUiBtYWNybyBhbmQKcHJvY2VzcyBhY2NvcmRp
bmdseS50aGVybWFsX2Nvb2xpbmdfZGV2aWNlX3JlZ2lzdGVyCnJldHVybmluZyBOVUxMIG1lYW5z
IHRoYXQgQ09ORklHX1RIRVJNQUw9biBhbmQgaW4gdGhhdApjYXNlIG5vIG5lZWQgdG8gY3JlYXRl
IHN5bWJvbGljIGxpbmtzLgoKU2lnbmVkLW9mZi1ieTogVGhvbWFzIFN1aml0aCA8c3VqaXRoLnRo
b21hc0BpbnRlbC5jb20+CiBkcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2NvcmUuYyB8ICAgMzcgKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCAyMiBp
bnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkKCkluZGV4OiBsaW51eC0yLjYuMjQvZHJpdmVy
cy9hY3BpL3Byb2Nlc3Nvcl9jb3JlLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgtMi42LjI0Lm9yaWcv
ZHJpdmVycy9hY3BpL3Byb2Nlc3Nvcl9jb3JlLmMKKysrIGxpbnV4LTIuNi4yNC9kcml2ZXJzL2Fj
cGkvcHJvY2Vzc29yX2NvcmUuYwpAQCAtNjcwLDIxICs2NzAsMjYgQEAgc3RhdGljIGludCBfX2Nw
dWluaXQgYWNwaV9wcm9jZXNzb3Jfc3RhcgogCiAJcHItPmNkZXYgPSB0aGVybWFsX2Nvb2xpbmdf
ZGV2aWNlX3JlZ2lzdGVyKCJQcm9jZXNzb3IiLCBkZXZpY2UsCiAJCQkJCQkmcHJvY2Vzc29yX2Nv
b2xpbmdfb3BzKTsKLQlpZiAocHItPmNkZXYpCisJaWYgKElTX0VSUihwci0+Y2RldikpIHsKKwkJ
cmVzdWx0ID0gUFRSX0VSUihwci0+Y2Rldik7CisJCWdvdG8gZW5kOworCX0KKwlpZiAocHItPmNk
ZXYpIHsKIAkJcHJpbnRrKEtFUk5fSU5GTyBQUkVGSVgKIAkJCSIlcyBpcyByZWdpc3RlcmVkIGFz
IGNvb2xpbmdfZGV2aWNlJWRcbiIsCiAJCQlkZXZpY2UtPmRldi5idXNfaWQsIHByLT5jZGV2LT5p
ZCk7Ci0JZWxzZQotCQlnb3RvIGVuZDsKIAotCXJlc3VsdCA9IHN5c2ZzX2NyZWF0ZV9saW5rKCZk
ZXZpY2UtPmRldi5rb2JqLCAmcHItPmNkZXYtPmRldmljZS5rb2JqLAotCQkJCQkidGhlcm1hbF9j
b29saW5nIik7Ci0JaWYgKHJlc3VsdCkKLQkJcmV0dXJuIHJlc3VsdDsKLQlyZXN1bHQgPSBzeXNm
c19jcmVhdGVfbGluaygmcHItPmNkZXYtPmRldmljZS5rb2JqLCAmZGV2aWNlLT5kZXYua29iaiwK
LQkJCQkJImRldmljZSIpOwotCWlmIChyZXN1bHQpCi0JCXJldHVybiByZXN1bHQ7CisJCXJlc3Vs
dCA9IHN5c2ZzX2NyZWF0ZV9saW5rKCZkZXZpY2UtPmRldi5rb2JqLAorCQkJCQkgICAmcHItPmNk
ZXYtPmRldmljZS5rb2JqLAorCQkJCQkgICAidGhlcm1hbF9jb29saW5nIik7CisJCWlmIChyZXN1
bHQpCisJCQlyZXR1cm4gcmVzdWx0OworCQlyZXN1bHQgPSBzeXNmc19jcmVhdGVfbGluaygmcHIt
PmNkZXYtPmRldmljZS5rb2JqLAorCQkJCQkgICAmZGV2aWNlLT5kZXYua29iaiwKKwkJCQkJICAg
ImRldmljZSIpOworCQlpZiAocmVzdWx0KQorCQkJcmV0dXJuIHJlc3VsdDsKKwl9CiAKIAlpZiAo
cHItPmZsYWdzLnRocm90dGxpbmcpIHsKIAkJcHJpbnRrKEtFUk5fSU5GTyBQUkVGSVggIiVzIFsl
c10gKHN1cHBvcnRzIiwKQEAgLTgwOSwxMCArODE0LDEyIEBAIHN0YXRpYyBpbnQgYWNwaV9wcm9j
ZXNzb3JfcmVtb3ZlKHN0cnVjdCAKIAogCWFjcGlfcHJvY2Vzc29yX3JlbW92ZV9mcyhkZXZpY2Up
OwogCi0Jc3lzZnNfcmVtb3ZlX2xpbmsoJmRldmljZS0+ZGV2LmtvYmosICJ0aGVybWFsX2Nvb2xp
bmciKTsKLQlzeXNmc19yZW1vdmVfbGluaygmcHItPmNkZXYtPmRldmljZS5rb2JqLCAiZGV2aWNl
Iik7Ci0JdGhlcm1hbF9jb29saW5nX2RldmljZV91bnJlZ2lzdGVyKHByLT5jZGV2KTsKLQlwci0+
Y2RldiA9IE5VTEw7CisJaWYgKHByLT5jZGV2KSB7CisJCXN5c2ZzX3JlbW92ZV9saW5rKCZkZXZp
Y2UtPmRldi5rb2JqLCAidGhlcm1hbF9jb29saW5nIik7CisJCXN5c2ZzX3JlbW92ZV9saW5rKCZw
ci0+Y2Rldi0+ZGV2aWNlLmtvYmosICJkZXZpY2UiKTsKKwkJdGhlcm1hbF9jb29saW5nX2Rldmlj
ZV91bnJlZ2lzdGVyKHByLT5jZGV2KTsKKwkJcHItPmNkZXYgPSBOVUxMOworCX0KIAogCXByb2Nl
c3NvcnNbcHItPmlkXSA9IE5VTEw7CiAK

------_=_NextPart_001_01C86FBF.F33F4D1A--
