From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI processor module enhancements
Date: Sat, 9 Oct 2004 18:04:54 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8405BD11BF@pdsmsx403>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C4ADE7.71B14531"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4ADE7.71B14531
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>
>> >8.) Support for WBINVD-based C3
>> >
>> >Only enabled on UP if users explicitely requests it, but=20
>> >always available
>> >on multiprocessor systems.
>>=20
>> IIR Luming was looking into this area.

I recall I have ever made a patch to remove:

               else if (!pr->flags.bm_control)
                       ACPI_DEBUG_PRINT((ACPI_DB_INFO,
                               "C3 support requires bus mastering
control\n"));

The patch is simple, And I haven't started to eliminate " "C3 not
supported in SMP mode".

Thanks,
Luming

diff -Bru 2.6.new/drivers/acpi/processor.c
patched/drivers/acpi/processor.c
--- 2.6.new/drivers/acpi/processor.c    2004-04-28 11:45:02.000000000
+0800
+++ patched/drivers/acpi/processor.c    2004-05-26 14:38:05.000000000
+0800
@@ -428,8 +428,12 @@
                break;

        case ACPI_STATE_C3:
-               /* Disable bus master arbitration */
-               acpi_set_register(ACPI_BITREG_ARB_DISABLE, 1,
ACPI_MTX_DO_NOT_LOCK);
+
+               if(pr->flags.bm_control)
+                       acpi_set_register(ACPI_BITREG_ARB_DISABLE, 1,
ACPI_MTX_DO_NOT_LOCK); /* Disable bus master arbitration */
+               else
+                       ACPI_FLUSH_CPU_CACHE ();
+
                /* Get start time (ticks) */
                t1 =3D inl(acpi_fadt.xpm_tmr_blk.address);
                /* Invoke C3 */
@@ -438,8 +442,10 @@
                t2 =3D inl(acpi_fadt.xpm_tmr_blk.address);
                /* Get end time (ticks) */
                t2 =3D inl(acpi_fadt.xpm_tmr_blk.address);
-               /* Enable bus master arbitration */
-               acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0,
ACPI_MTX_DO_NOT_LOCK);
+
+               if(pr->flags.bm_control)
+                       acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0,
ACPI_MTX_DO_NOT_LOCK); /* Enable bus master arbitration */
+
                /* Re-enable interrupts */
                local_irq_enable();
                /* Compute time (ticks) that we were actually asleep */
@@ -676,14 +682,7 @@
                        ACPI_DEBUG_PRINT((ACPI_DB_INFO,
                                "C3 latency too large [%d]\n",
                                acpi_fadt.plvl3_lat));
-               /*
-                * Only support C3 when bus mastering arbitration
control
-                * is present (able to disable bus mastering to maintain
-                * cache coherency while in C3).
-                */
-               else if (!pr->flags.bm_control)
-                       ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-                               "C3 support requires bus mastering
control\n"));
+
                /*
                 * Only support C3 on UP systems, as bm_control is only
viable
                 * on a UP system and flushing caches (e.g. WBINVD) is
simply

------_=_NextPart_001_01C4ADE7.71B14531
Content-Type: application/octet-stream;
	name="c3_wbinvd.patch"
Content-Transfer-Encoding: base64
Content-Description: c3_wbinvd.patch
Content-Disposition: attachment;
	filename="c3_wbinvd.patch"

ZGlmZiAtQnJ1IDIuNi5uZXcvZHJpdmVycy9hY3BpL3Byb2Nlc3Nvci5jIHBhdGNoZWQvZHJpdmVy
cy9hY3BpL3Byb2Nlc3Nvci5jCi0tLSAyLjYubmV3L2RyaXZlcnMvYWNwaS9wcm9jZXNzb3IuYwky
MDA0LTA0LTI4IDExOjQ1OjAyLjAwMDAwMDAwMCArMDgwMAorKysgcGF0Y2hlZC9kcml2ZXJzL2Fj
cGkvcHJvY2Vzc29yLmMJMjAwNC0wNS0yNiAxNDozODowNS4wMDAwMDAwMDAgKzA4MDAKQEAgLTQy
OCw4ICs0MjgsMTIgQEAKIAkJYnJlYWs7CiAKIAljYXNlIEFDUElfU1RBVEVfQzM6Ci0JCS8qIERp
c2FibGUgYnVzIG1hc3RlciBhcmJpdHJhdGlvbiAqLwotCQlhY3BpX3NldF9yZWdpc3RlcihBQ1BJ
X0JJVFJFR19BUkJfRElTQUJMRSwgMSwgQUNQSV9NVFhfRE9fTk9UX0xPQ0spOworCisJCWlmKHBy
LT5mbGFncy5ibV9jb250cm9sKQorCQkJYWNwaV9zZXRfcmVnaXN0ZXIoQUNQSV9CSVRSRUdfQVJC
X0RJU0FCTEUsIDEsIEFDUElfTVRYX0RPX05PVF9MT0NLKTsgLyogRGlzYWJsZSBidXMgbWFzdGVy
IGFyYml0cmF0aW9uICovCisJCWVsc2UKKwkJCUFDUElfRkxVU0hfQ1BVX0NBQ0hFICgpOworCiAJ
CS8qIEdldCBzdGFydCB0aW1lICh0aWNrcykgKi8KIAkJdDEgPSBpbmwoYWNwaV9mYWR0LnhwbV90
bXJfYmxrLmFkZHJlc3MpOwogCQkvKiBJbnZva2UgQzMgKi8KQEAgLTQzOCw4ICs0NDIsMTAgQEAK
IAkJdDIgPSBpbmwoYWNwaV9mYWR0LnhwbV90bXJfYmxrLmFkZHJlc3MpOwogCQkvKiBHZXQgZW5k
IHRpbWUgKHRpY2tzKSAqLwogCQl0MiA9IGlubChhY3BpX2ZhZHQueHBtX3Rtcl9ibGsuYWRkcmVz
cyk7Ci0JCS8qIEVuYWJsZSBidXMgbWFzdGVyIGFyYml0cmF0aW9uICovCi0JCWFjcGlfc2V0X3Jl
Z2lzdGVyKEFDUElfQklUUkVHX0FSQl9ESVNBQkxFLCAwLCBBQ1BJX01UWF9ET19OT1RfTE9DSyk7
CisKKwkJaWYocHItPmZsYWdzLmJtX2NvbnRyb2wpCisJCQlhY3BpX3NldF9yZWdpc3RlcihBQ1BJ
X0JJVFJFR19BUkJfRElTQUJMRSwgMCwgQUNQSV9NVFhfRE9fTk9UX0xPQ0spOyAvKiBFbmFibGUg
YnVzIG1hc3RlciBhcmJpdHJhdGlvbiAqLworCiAJCS8qIFJlLWVuYWJsZSBpbnRlcnJ1cHRzICov
CiAJCWxvY2FsX2lycV9lbmFibGUoKTsKIAkJLyogQ29tcHV0ZSB0aW1lICh0aWNrcykgdGhhdCB3
ZSB3ZXJlIGFjdHVhbGx5IGFzbGVlcCAqLwpAQCAtNjc2LDE0ICs2ODIsNyBAQAogCQkJQUNQSV9E
RUJVR19QUklOVCgoQUNQSV9EQl9JTkZPLAogCQkJCSJDMyBsYXRlbmN5IHRvbyBsYXJnZSBbJWRd
XG4iLCAKIAkJCQlhY3BpX2ZhZHQucGx2bDNfbGF0KSk7Ci0JCS8qCi0JCSAqIE9ubHkgc3VwcG9y
dCBDMyB3aGVuIGJ1cyBtYXN0ZXJpbmcgYXJiaXRyYXRpb24gY29udHJvbAotCQkgKiBpcyBwcmVz
ZW50IChhYmxlIHRvIGRpc2FibGUgYnVzIG1hc3RlcmluZyB0byBtYWludGFpbgotCQkgKiBjYWNo
ZSBjb2hlcmVuY3kgd2hpbGUgaW4gQzMpLgotCQkgKi8KLQkJZWxzZSBpZiAoIXByLT5mbGFncy5i
bV9jb250cm9sKQotCQkJQUNQSV9ERUJVR19QUklOVCgoQUNQSV9EQl9JTkZPLAotCQkJCSJDMyBz
dXBwb3J0IHJlcXVpcmVzIGJ1cyBtYXN0ZXJpbmcgY29udHJvbFxuIikpOworCiAJCS8qCiAJCSAq
IE9ubHkgc3VwcG9ydCBDMyBvbiBVUCBzeXN0ZW1zLCBhcyBibV9jb250cm9sIGlzIG9ubHkgdmlh
YmxlCiAJCSAqIG9uIGEgVVAgc3lzdGVtIGFuZCBmbHVzaGluZyBjYWNoZXMgKGUuZy4gV0JJTlZE
KSBpcyBzaW1wbHkgCg==

------_=_NextPart_001_01C4ADE7.71B14531--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
