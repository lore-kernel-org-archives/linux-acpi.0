From: "Ketrenos, James P" <james.p.ketrenos-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Linux ACPI processor driver patch: user-definable power statelimit
Date: Mon, 8 Nov 2004 10:45:56 -0800
Message-ID: <DD755978BA8283409FB0087C39132BD104AEDC7C@fmsmsx404.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C4C5C3.2EB99B6F"
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
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jos Delbar <jos.delbar-Cru1EgDzd7c@public.gmane.org>, Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4C5C3.2EB99B6F
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Ok, I've implemented the ipw2100 side of the equation and have it out =
for testing with a few ipw users that have frequently encounter the =
problem; we should know how well its working soon.
=20
Attached is the patch against ipw2100 v0.60.
=20
James

________________________________

From: Len Brown [mailto:len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]
Sent: Fri 11/5/2004 4:58 PM
To: Jos Delbar; Andi Kleen; Moore, Robert; Ketrenos, James P
Cc: ACPI Developers
Subject: Re: Linux ACPI processor driver patch: user-definable power =
statelimit



Please try out this acpi_cstate_limit patch.

This applies to 2.6.8.1, but in the likely event
that may mailer wraps this patch or you need 2.6.9, go here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/csta=
te_limit/

thanks,
-Len

-----------
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/11/05 17:39:51-05:00 len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
#   [ACPI] Allow limiting idle C-States.
# =20
#   Useful to workaround C3 ipw2100 packet loss
#   and resonating noises heard on some laptops.
# =20
#   For static processor driver, boot cmdline:
#   processor.acpi_cstate_limit=3D2
# =20
#   For processor module, /etc/modprobe.conf:
#   options processor acpi_cstate_limit=3D2
# =20
#   For manual processor module load:
#   # modprobe processor acpi_cstate_limit=3D2
# =20
#   From kernel or kernel module:
#   #include <linux/acpi.h>
#   acpi_set_cstate_limit(2);
# =20
#   Inspired by patches from Jos Delbar and Andi Kleen
#   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
#
# include/linux/acpi.h
#   2004/11/05 17:39:45-05:00 len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org +26 -0
#   define API to set and get acpi_cstate_limit
#
# drivers/acpi/processor.c
#   2004/11/05 17:39:45-05:00 len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org +10 -1
#   set and obey acpi_cstate_limit
#
# drivers/acpi/osl.c
#   2004/11/05 17:39:45-05:00 len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org +9 -0
#   define acpi_cstate_limit
#
diff -Nru a/drivers/acpi/osl.c b/drivers/acpi/osl.c
--- a/drivers/acpi/osl.c        2004-11-05 17:40:07 -05:00
+++ b/drivers/acpi/osl.c        2004-11-05 17:40:07 -05:00
@@ -1078,3 +1078,12 @@

 __setup("acpi_leave_gpes_disabled", acpi_leave_gpes_disabled_setup);

+/*
+ * acpi_cstate_limit is defined in the base kernel so modules can
+ * change it w/o depending on the state of the processor module.
+ */
+unsigned int acpi_cstate_limit =3D ACPI_C_STATES_MAX;
+
+
+EXPORT_SYMBOL(acpi_cstate_limit);
+
diff -Nru a/drivers/acpi/processor.c b/drivers/acpi/processor.c
--- a/drivers/acpi/processor.c  2004-11-05 17:40:07 -05:00
+++ b/drivers/acpi/processor.c  2004-11-05 17:40:07 -05:00
@@ -459,8 +459,9 @@
         * Track the number of longs (time asleep is greater than =
threshold)
         * and promote when the count threshold is reached.  Note that =
bus
         * mastering activity may prevent promotions.
+        * Do not promote above acpi_cstate_limit.
         */
-       if (cx->promotion.state) {
+       if (cx->promotion.state && (cx->promotion.state <=3D =
acpi_cstate_limit))
{
                if (sleep_ticks > cx->promotion.threshold.ticks) {
                        cx->promotion.count++;
                        cx->demotion.count =3D 0;
@@ -498,6 +499,13 @@

 end:
        /*
+        * Demote if current state exceeds acpi_cstate_limit
+        */
+       if (pr->power.state > acpi_cstate_limit) {
+               next_state =3D acpi_cstate_limit;
+       }
+
+       /*
         * New Cx State?
         * -------------
         * If we're going to start using a new Cx state we must clean up
@@ -2441,5 +2449,6 @@

 module_init(acpi_processor_init);
 module_exit(acpi_processor_exit);
+module_param_named(acpi_cstate_limit, acpi_cstate_limit, uint, 0);

 EXPORT_SYMBOL(acpi_processor_set_thermal_limit);
diff -Nru a/include/linux/acpi.h b/include/linux/acpi.h
--- a/include/linux/acpi.h      2004-11-05 17:40:07 -05:00
+++ b/include/linux/acpi.h      2004-11-05 17:40:07 -05:00
@@ -471,4 +471,30 @@

 #endif /*!CONFIG_ACPI_INTERPRETER*/

+#define        ACPI_CSTATE_LIMIT_DEFINED       /* for driver builds */
+#ifdef CONFIG_ACPI
+
+/*
+ * Set highest legal C-state
+ * 0: C0 okay, but not C1
+ * 1: C1 okay, but not C2
+ * 2: C2 okay, but not C3 etc.
+ */
+
+extern unsigned int acpi_cstate_limit;
+
+static inline unsigned int acpi_get_cstate_limit(void)
+{
+       return acpi_cstate_limit;
+}
+static inline void acpi_set_cstate_limit(unsigned int new_limit)
+{
+       acpi_cstate_limit =3D new_limit;
+       return;
+}
+#else
+static inline unsigned int acpi_get_cstate_limit(void) { return 0; }
+static inline void acpi_set_cstate_limit(unsigned int new_limit) {
return; }
+#endif
+
 #endif /*_LINUX_ACPI_H*/






------_=_NextPart_001_01C4C5C3.2EB99B6F
Content-Type: text/plain;
	name="ipw2100-0.60-c3.patch"
Content-Transfer-Encoding: base64
Content-Description: ipw2100-0.60-c3.patch
Content-Disposition: attachment;
	filename="ipw2100-0.60-c3.patch"

VGhlIGZvbGxvd2luZyB3aWxsIG1vZGlmeSB0aGUgSVBXMjEwMCBkcml2ZXIgc3VjaCB0aGF0IGlu
IHRoZSBldmVudAp0aGF0IGEgUENJIGxhdGVuY3kgZXJyb3IgaXMgZGV0ZWN0ZWQgYXMgYSByZXN1
bHQgb2YgYSBDMyB0cmFuc2l0aW9uLApDMyB0cmFuc2lzdGlvbnMgd2lsbCBiZSBkaXNhYmxlZCBi
eSB0aGUgZHJpdmVyLCB1bnRpbCBpdCBpcyB1bmxvYWRlZCBvcgp0aGUgcmFkaW8gaXMgY3ljbGVk
ICh0dXJuZWQgb2ZmL29uKS4KCk5PVEU6ICBUaGlzIHJlcXVpcmVzIHRoZSBBQ1BJIGNvcmUgdG8g
YmUgcGF0Y2hlZCB3aXRoIHRoZSBDLXN0YXRlIGxpbWl0CnBhdGNoLgoKZGlmZiAtdSAtcCAtcjEu
MTE3MCBpcHcyMTAwLmMKLS0tIGlwdzIxMDAuYwk4IE5vdiAyMDA0IDE2OjM2OjQ3IC0wMDAwCTEu
MTE3MAorKysgaXB3MjEwMC5jCTggTm92IDIwMDQgMTc6MTA6MzUgLTAwMDAKQEAgLTE1OSw2ICsx
NTksNyBAQCB0aGF0IHByb3RlY3RzIHRoZSBmb2xsb3dpbmc6CiAjaWZuZGVmIENPTkZJR19JUFcy
MTAwX0xFR0FDWV9GV19MT0FECiAjaW5jbHVkZSA8bGludXgvZmlybXdhcmUuaD4KICNlbmRpZgor
I2luY2x1ZGUgPGxpbnV4L2FjcGkuaD4KICNpbmNsdWRlIDxsaW51eC9jdHlwZS5oPgogCiAjaW5j
bHVkZSAiaXB3MjEwMC5oIgpAQCAtMTc5MywxMSArMTc5NCwxMSBAQCBzdGF0aWMgdm9pZCBpcHcy
MTAwX2Rvd24oc3RydWN0IGlwdzIxMDBfCiAJaXB3MjEwMF9kaXNhYmxlX2ludGVycnVwdHMocHJp
dik7CiAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcHJpdi0+bG93X2xvY2ssIGZsYWdzKTsKIAot
I2lmZGVmIENPTkZJR19BQ1BJX0NTVEFURV9DT05UUk9MCisjaWZkZWYgQUNQSV9DU1RBVEVfTElN
SVRfREVGSU5FRAogCWlmIChwcml2LT5jb25maWcgJiBDRkdfQzNfRElTQUJMRUQpIHsKLQkJSVBX
X0RFQlVHX0lORk8oRFJWX05BTUUgIjogRW5hYmxpbmcgQzMgdHJhbnNpdGlvbnMuXG4iKTsKLQkJ
aWYgKGFjcGlfcHJvY2Vzc29yX3NldF9jM19hdmFpbCgxKSkKLQkJCXByaXYtPmNvbmZpZyAmPSB+
Q0ZHX0MzX0RJU0FCTEVEOworCQlJUFdfREVCVUdfSU5GTyhEUlZfTkFNRSAiOiBSZXNldHRpbmcg
QzMgdHJhbnNpdGlvbnMuXG4iKTsKKwkJYWNwaV9zZXRfY3N0YXRlX2xpbWl0KHByaXYtPmNzdGF0
ZV9saW1pdCk7CisJCXByaXYtPmNvbmZpZyAmPSB+Q0ZHX0MzX0RJU0FCTEVEOwogCX0KICNlbmRp
ZgogCkBAIC0yMjM2LDE0ICsyMjM3LDIxIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBpcHcyMTAwX2Nv
cnJ1cHRpb25fZGUKIAl1MzIgbWF0Y2gsIHJlZzsKIAlpbnQgajsKICNlbmRpZgorI2lmZGVmIEFD
UElfQ1NUQVRFX0xJTUlUX0RFRklORUQKKwlpbnQgbGltaXQ7CisjZW5kaWYKIAogCUlQV19ERUJV
R19JTkZPKERSVl9OQU1FICI6IFBDSSBsYXRlbmN5IGVycm9yIGRldGVjdGVkIGF0ICIKIAkJICAg
ICAgICIweCUwNFguXG4iLCBpICogc2l6ZW9mKHN0cnVjdCBpcHcyMTAwX3N0YXR1cykpOwogCi0j
aWZkZWYgQ09ORklHX0FDUElfQ1NUQVRFX0NPTlRST0wKKyNpZmRlZiBBQ1BJX0NTVEFURV9MSU1J
VF9ERUZJTkVECiAJSVBXX0RFQlVHX0lORk8oRFJWX05BTUUgIjogRGlzYWJsaW5nIEMzIHRyYW5z
aXRpb25zLlxuIik7Ci0JaWYgKGFjcGlfcHJvY2Vzc29yX3NldF9jM19hdmFpbCgwKSkKKwlsaW1p
dCA9IGFjcGlfZ2V0X2NzdGF0ZV9saW1pdCgpOworCWlmIChsaW1pdCA+IDIpIHsKKwkJcHJpdi0+
Y3N0YXRlX2xpbWl0ID0gbGltaXQ7CisJCWFjcGlfc2V0X2NzdGF0ZV9saW1pdCgyKTsKIAkJcHJp
di0+Y29uZmlnIHw9IENGR19DM19ESVNBQkxFRDsKKwl9CiAjZW5kaWYKIAogI2lmZGVmIENPTkZJ
R19JUFdfREVCVUdfQzMKZGlmZiAtdSAtcCAtcjEuMzc0IC1yMS4zNzUKLS0tIGlwdzIxMDAuaAk4
IE5vdiAyMDA0IDE2OjM2OjQ3IC0wMDAwCTEuMzc0CisrKyBpcHcyMTAwLmgJOCBOb3YgMjAwNCAx
NjozNjo1OCAtMDAwMAkxLjM3NQpAQCAtNTQ3LDYgKzU0Nyw3IEBAIHN0cnVjdCBpcHcyMTAwX3By
aXYgewogCXU4IGJzc2lkW0VUSF9BTEVOXTsKIAl1OCBjaGFubmVsOwogCWludCBsYXN0X21vZGU7
CisJaW50IGNzdGF0ZV9saW1pdDsKIAogCXVuc2lnbmVkIGxvbmcgY29ubmVjdF9zdGFydDsKIAl1
bnNpZ25lZCBsb25nIGxhc3RfcmVzZXQ7Cg==

------_=_NextPart_001_01C4C5C3.2EB99B6F--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
