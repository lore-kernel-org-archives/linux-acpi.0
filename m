From: eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org
Subject: [PATCH] ACPI/Processor: C1/C3 states promotion and demotion
Date: Mon,  9 Feb 2004 15:07:19 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1076335639.40279417dabd5@mailetu.utc.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="-MOQ10763356399e8609a79e93f8b7fbef69671405ef26"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This message is in MIME format.

---MOQ10763356399e8609a79e93f8b7fbef69671405ef26
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,

Some processors seems to support only C1 and C3 states, for instance... m=
ine ;-)
(Pentium III Coppermine). The problem is that, in this case, no promotion=
 or
demotion are linking those two states, therefore the preocessor never goe=
s to C3!

The attached patch (against kernel 2.6.1) should do the trick, that's mai=
nly a
copy-paste of the C2/C3 code. It works fine on my computer (and the tempe=
rature
really goes down :-) ).

Hopefully you'll like it,
Eric Piel

---MOQ10763356399e8609a79e93f8b7fbef69671405ef26
Content-Type: text/x-patch; name="acpi-processor-c1-c3-promotion.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="acpi-processor-c1-c3-promotion.patch"

LS0tIGRyaXZlcnMvYWNwaS9wcm9jZXNzb3IuYy5vcmlnCTIwMDQtMDItMDUgMTk6Mzg6MDYuMDAw
MDAwMDAwICswMTAwCisrKyBkcml2ZXJzL2FjcGkvcHJvY2Vzc29yLmMJMjAwNC0wMi0wOCAyMjo0
NjozOC43MjgyNTk5ODQgKzAxMDAKQEAgLTU4Niw2ICs1ODYsMjYgQEAKIAkJcHItPnBvd2VyLnN0
YXRlc1tBQ1BJX1NUQVRFX0MzXS5kZW1vdGlvbi50aHJlc2hvbGQuYm0gPSAweDBGOwogCQlwci0+
cG93ZXIuc3RhdGVzW0FDUElfU1RBVEVfQzNdLmRlbW90aW9uLnN0YXRlID0gQUNQSV9TVEFURV9D
MjsKIAl9CisJLyoKKwkgKiBDMS9DMworCSAqIC0tLS0tCisJICogU2V0IHByb21vdGlvbiBhbmQg
ZGVtb3Rpb24gYmV0d2VlbiBDMSBhbmQgQzMgaW4gY2FzZSB0aGVyZSBpc24ndAorCSAqIGFueSBD
MiBzdGF0ZSBhdmFpbGFibGUKKwkgKi8KKwlpZiAoKCFwci0+cG93ZXIuc3RhdGVzW0FDUElfU1RB
VEVfQzJdLnZhbGlkKSAmJgorCQkocHItPnBvd2VyLnN0YXRlc1tBQ1BJX1NUQVRFX0MzXS52YWxp
ZCkpIHsKKwkJcHItPnBvd2VyLnN0YXRlc1tBQ1BJX1NUQVRFX0MxXS5wcm9tb3Rpb24udGhyZXNo
b2xkLmNvdW50ID0gNDA7CisJCXByLT5wb3dlci5zdGF0ZXNbQUNQSV9TVEFURV9DMV0ucHJvbW90
aW9uLnRocmVzaG9sZC50aWNrcyA9CisJCQlwci0+cG93ZXIuc3RhdGVzW0FDUElfU1RBVEVfQzNd
LmxhdGVuY3lfdGlja3M7CisJCXByLT5wb3dlci5zdGF0ZXNbQUNQSV9TVEFURV9DMV0ucHJvbW90
aW9uLnRocmVzaG9sZC5ibSA9IDB4MEY7CisJCXByLT5wb3dlci5zdGF0ZXNbQUNQSV9TVEFURV9D
MV0ucHJvbW90aW9uLnN0YXRlID0gQUNQSV9TVEFURV9DMzsKKworCQlwci0+cG93ZXIuc3RhdGVz
W0FDUElfU1RBVEVfQzNdLmRlbW90aW9uLnRocmVzaG9sZC5jb3VudCA9IDE7CisJCXByLT5wb3dl
ci5zdGF0ZXNbQUNQSV9TVEFURV9DM10uZGVtb3Rpb24udGhyZXNob2xkLnRpY2tzID0KKwkJCXBy
LT5wb3dlci5zdGF0ZXNbQUNQSV9TVEFURV9DM10ubGF0ZW5jeV90aWNrczsKKwkJcHItPnBvd2Vy
LnN0YXRlc1tBQ1BJX1NUQVRFX0MzXS5kZW1vdGlvbi50aHJlc2hvbGQuYm0gPSAweDBGOworCQlw
ci0+cG93ZXIuc3RhdGVzW0FDUElfU1RBVEVfQzNdLmRlbW90aW9uLnN0YXRlID0gQUNQSV9TVEFU
RV9DMTsKKwl9CiAKIAlyZXR1cm5fVkFMVUUoMCk7CiB9Cg==

---MOQ10763356399e8609a79e93f8b7fbef69671405ef26--



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
