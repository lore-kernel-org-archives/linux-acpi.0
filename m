From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Patch for IBM Thinkpad, Please help test
Date: Fri, 22 Aug 2003 18:52:48 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <571ACEFD467F7749BC50E0A98C17CDD8D5FD40@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C3689B.86ABDE80"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
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

This is a multi-part message in MIME format.

------_=_NextPart_001_01C3689B.86ABDE80
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C3689B.86ABDE80"


------_=_NextPart_002_01C3689B.86ABDE80
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

       In general, when you 'cat /proc/acpi/battery/BAT0/state' over one
time under IBM Thinkpad series, you will get error. I get a patch, which
can get rid of the battery error. This patch is for kernel
2.4.22-pre10-ac1, but other kernel version maybe can be applied.  Before
using this patch, you also need apply a patch in=20
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D98849.=20

   Any info will be appreciated.

=20

Thanks,

David(Shaohua)

=20


------_=_NextPart_002_01C3689B.86ABDE80
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">


<meta name=3DGenerator content=3D"Microsoft Word 10 (filtered)">

<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:&#23435;&#20307;;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@&#23435;&#20307;";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{font-family:Arial;
	color:windowtext;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi all,</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; In general, when =
you
&#8216;cat /proc/acpi/battery/BAT0/state&#8217; over one time under IBM =
Thinkpad series,
you will get error. I get a patch, which can get rid of the battery =
error. This
patch is for kernel 2.4.22-pre10-ac1, but other kernel version maybe can =
be
applied. &nbsp;Before using this patch, you also need apply a patch in =
<a
href=3D"https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D98849">htt=
ps://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D98849</a>.
</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; Any info will be =
appreciated.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks,</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>David(Shaohua)</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;</span></font></p>

</div>

</body>

</html>
=00
------_=_NextPart_002_01C3689B.86ABDE80--

------_=_NextPart_001_01C3689B.86ABDE80
Content-Type: application/octet-stream;
	name="t40-battery.patch"
Content-Transfer-Encoding: base64
Content-Description: t40-battery.patch
Content-Disposition: attachment;
	filename="t40-battery.patch"

ZGlmZiAtdXIgbGludXgtMi40LjIxL2RyaXZlcnMvYWNwaS91dGlsaXRpZXMvdXRkZWxldGUuYyBs
aW51eC0yLjQuMjEubmV3L2RyaXZlcnMvYWNwaS91dGlsaXRpZXMvdXRkZWxldGUuYw0KLS0tIGxp
bnV4LTIuNC4yMS9kcml2ZXJzL2FjcGkvdXRpbGl0aWVzL3V0ZGVsZXRlLmMJMjAwMy0wOC0yMiAx
MDoxNzoyNi4wMDAwMDAwMDAgKzA4MDANCisrKyBsaW51eC0yLjQuMjEubmV3L2RyaXZlcnMvYWNw
aS91dGlsaXRpZXMvdXRkZWxldGUuYwkyMDAzLTA4LTIyIDE1OjU0OjA5LjAwMDAwMDAwMCArMDgw
MA0KQEAgLTQxNiw3ICs0MTYsNyBAQA0KIAl1MzIgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGk7DQogCXVuaW9uIGFjcGlfZ2VuZXJpY19zdGF0ZSAgICAgICAgICpzdGF0ZV9saXN0ID0gTlVM
TDsNCiAJdW5pb24gYWNwaV9nZW5lcmljX3N0YXRlICAgICAgICAgKnN0YXRlOw0KLQ0KKwl1bmlv
biBhY3BpX29wZXJhbmRfb2JqZWN0CSp0bXA7DQogDQogCUFDUElfRlVOQ1RJT05fVFJBQ0VfUFRS
ICgidXRfdXBkYXRlX29iamVjdF9yZWZlcmVuY2UiLCBvYmplY3QpOw0KIA0KQEAgLTQ0OCw4ICs0
NDgsMTUgQEANCiAJCXN3aXRjaCAoQUNQSV9HRVRfT0JKRUNUX1RZUEUgKG9iamVjdCkpIHsNCiAJ
CWNhc2UgQUNQSV9UWVBFX0RFVklDRToNCiANCi0JCQlhY3BpX3V0X3VwZGF0ZV9yZWZfY291bnQg
KG9iamVjdC0+ZGV2aWNlLnN5c3RlbV9ub3RpZnksIGFjdGlvbik7DQotCQkJYWNwaV91dF91cGRh
dGVfcmVmX2NvdW50IChvYmplY3QtPmRldmljZS5kZXZpY2Vfbm90aWZ5LCBhY3Rpb24pOw0KKwkJ
CXRtcCA9IG9iamVjdC0+ZGV2aWNlLnN5c3RlbV9ub3RpZnk7DQorCQkJaWYodG1wICYmIHRtcC0+
Y29tbW9uLnJlZmVyZW5jZV9jb3VudDw9MSAmJiBhY3Rpb24gPT0gUkVGX0RFQ1JFTUVOVCkNCisJ
CQkJb2JqZWN0LT5kZXZpY2Uuc3lzdGVtX25vdGlmeSA9IE5VTEw7DQorCQkJYWNwaV91dF91cGRh
dGVfcmVmX2NvdW50ICh0bXAsIGFjdGlvbik7DQorDQorCQkJdG1wID0gb2JqZWN0LT5kZXZpY2Uu
ZGV2aWNlX25vdGlmeTsNCisJCQlpZih0bXAgJiYgdG1wLT5jb21tb24ucmVmZXJlbmNlX2NvdW50
IDw9MSAmJiBhY3Rpb24gPT0gUkVGX0RFQ1JFTUVOVCkNCisJCQkJb2JqZWN0LT5kZXZpY2UuZGV2
aWNlX25vdGlmeSA9IE5VTEw7DQorCQkJYWNwaV91dF91cGRhdGVfcmVmX2NvdW50ICh0bXAsIGFj
dGlvbik7DQogCQkJYnJlYWs7DQogDQogDQpAQCAtNDY3LDYgKzQ3NCw5IEBADQogCQkJCSAqLw0K
IAkJCQlzdGF0dXMgPSBhY3BpX3V0X2NyZWF0ZV91cGRhdGVfc3RhdGVfYW5kX3B1c2ggKA0KIAkJ
CQkJCSBvYmplY3QtPnBhY2thZ2UuZWxlbWVudHNbaV0sIGFjdGlvbiwgJnN0YXRlX2xpc3QpOw0K
KwkJCQl0bXAgPSBvYmplY3QtPnBhY2thZ2UuZWxlbWVudHNbaV07DQorCQkJCWlmKHRtcCAmJiB0
bXAtPmNvbW1vbi5yZWZlcmVuY2VfY291bnQ8PTEgICYmIGFjdGlvbiA9PSBSRUZfREVDUkVNRU5U
KSAvKnJlZmVyZW5jZSBjb3VudCBkaWRuJ3QgcmVmcmVzaCBub3cqLw0KKwkJCQkJb2JqZWN0LT5w
YWNrYWdlLmVsZW1lbnRzW2ldID0gTlVMTDsNCiAJCQkJaWYgKEFDUElfRkFJTFVSRSAoc3RhdHVz
KSkgew0KIAkJCQkJZ290byBlcnJvcl9leGl0Ow0KIAkJCQl9DQpAQCAtNDgxLDYgKzQ5MSw5IEBA
DQogCQkJaWYgKEFDUElfRkFJTFVSRSAoc3RhdHVzKSkgew0KIAkJCQlnb3RvIGVycm9yX2V4aXQ7
DQogCQkJfQ0KKwkJCXRtcCA9IG9iamVjdC0+YnVmZmVyX2ZpZWxkLmJ1ZmZlcl9vYmo7DQorCQkJ
aWYoIHRtcCAmJiB0bXAtPmNvbW1vbi5yZWZlcmVuY2VfY291bnQgPD0xICAmJiBhY3Rpb24gPT0g
UkVGX0RFQ1JFTUVOVCkvKnJlZmVyZW5jZSBjb3VudCBkaWRuJ3QgcmVmcmVzaCBub3cqLw0KKwkJ
CQlvYmplY3QtPmJ1ZmZlcl9maWVsZC5idWZmZXJfb2JqID0gTlVMTDsNCiAJCQlicmVhazsNCiAN
CiANCkBAIC00OTEsNiArNTA0LDkgQEANCiAJCQlpZiAoQUNQSV9GQUlMVVJFIChzdGF0dXMpKSB7
DQogCQkJCWdvdG8gZXJyb3JfZXhpdDsNCiAJCQl9DQorCQkJdG1wID0gb2JqZWN0LT5maWVsZC5y
ZWdpb25fb2JqOw0KKyAgICAgICAgICAgICAgICAgICAgICAgIGlmKCB0bXAgJiYgdG1wLT5jb21t
b24ucmVmZXJlbmNlX2NvdW50IDw9MSAgJiYgYWN0aW9uID09IFJFRl9ERUNSRU1FTlQpLypyZWZl
cmVuY2UgY291bnQgZGlkbid0IHJlZnJlc2ggbm93Ki8NCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIG9iamVjdC0+ZmllbGQucmVnaW9uX29iaiA9IE5VTEw7DQogCQkgICBicmVhazsN
CiANCiANCkBAIC01MDEsMTIgKzUxNywxOCBAQA0KIAkJCWlmIChBQ1BJX0ZBSUxVUkUgKHN0YXR1
cykpIHsNCiAJCQkJZ290byBlcnJvcl9leGl0Ow0KIAkJCX0NCisJCQl0bXAgPSBvYmplY3QtPmJh
bmtfZmllbGQuYmFua19vYmo7DQorICAgICAgICAgICAgICAgICAgICAgICAgaWYoIHRtcCAmJiB0
bXAtPmNvbW1vbi5yZWZlcmVuY2VfY291bnQgPD0xICAmJiBhY3Rpb24gPT0gUkVGX0RFQ1JFTUVO
VCkvKnJlZmVyZW5jZSBjb3VudCBkaWRuJ3QgcmVmcmVzaCBub3cqLw0KKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgb2JqZWN0LT5iYW5rX2ZpZWxkLmJhbmtfb2JqID0gTlVMTDsJCQkN
CiANCiAJCQlzdGF0dXMgPSBhY3BpX3V0X2NyZWF0ZV91cGRhdGVfc3RhdGVfYW5kX3B1c2ggKA0K
IAkJCQkJIG9iamVjdC0+YmFua19maWVsZC5yZWdpb25fb2JqLCBhY3Rpb24sICZzdGF0ZV9saXN0
KTsNCiAJCQlpZiAoQUNQSV9GQUlMVVJFIChzdGF0dXMpKSB7DQogCQkJCWdvdG8gZXJyb3JfZXhp
dDsNCiAJCQl9DQorCQkJdG1wID0gb2JqZWN0LT5iYW5rX2ZpZWxkLnJlZ2lvbl9vYmo7DQorICAg
ICAgICAgICAgICAgICAgICAgICAgaWYoIHRtcCAmJiB0bXAtPmNvbW1vbi5yZWZlcmVuY2VfY291
bnQgPD0xICAmJiBhY3Rpb24gPT0gUkVGX0RFQ1JFTUVOVCkvKnJlZmVyZW5jZSBjb3VudCBkaWRu
J3QgcmVmcmVzaCBub3cqLw0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgb2JqZWN0
LT5iYW5rX2ZpZWxkLnJlZ2lvbl9vYmogPSBOVUxMOw0KIAkJCWJyZWFrOw0KIA0KIA0KQEAgLTUx
NywxMiArNTM5LDE4IEBADQogCQkJaWYgKEFDUElfRkFJTFVSRSAoc3RhdHVzKSkgew0KIAkJCQln
b3RvIGVycm9yX2V4aXQ7DQogCQkJfQ0KKwkJCXRtcCA9IG9iamVjdC0+aW5kZXhfZmllbGQuaW5k
ZXhfb2JqOw0KKyAgICAgICAgICAgICAgICAgICAgICAgIGlmKCB0bXAgJiYgdG1wLT5jb21tb24u
cmVmZXJlbmNlX2NvdW50IDw9MSAgJiYgYWN0aW9uID09IFJFRl9ERUNSRU1FTlQpLypyZWZlcmVu
Y2UgY291bnQgZGlkbid0IHJlZnJlc2ggbm93Ki8NCisgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIG9iamVjdC0+aW5kZXhfZmllbGQuaW5kZXhfb2JqID0gTlVMTDsNCiANCiAJCQlzdGF0
dXMgPSBhY3BpX3V0X2NyZWF0ZV91cGRhdGVfc3RhdGVfYW5kX3B1c2ggKA0KIAkJCQkJIG9iamVj
dC0+aW5kZXhfZmllbGQuZGF0YV9vYmosIGFjdGlvbiwgJnN0YXRlX2xpc3QpOw0KIAkJCWlmIChB
Q1BJX0ZBSUxVUkUgKHN0YXR1cykpIHsNCiAJCQkJZ290byBlcnJvcl9leGl0Ow0KIAkJCX0NCisJ
CQl0bXAgPSBvYmplY3QtPmluZGV4X2ZpZWxkLmRhdGFfb2JqOw0KKyAgICAgICAgICAgICAgICAg
ICAgICAgIGlmKCB0bXAgJiYgdG1wLT5jb21tb24ucmVmZXJlbmNlX2NvdW50IDw9MSAgJiYgYWN0
aW9uID09IFJFRl9ERUNSRU1FTlQpLypyZWZlcmVuY2UgY291bnQgZGlkbid0IHJlZnJlc2ggbm93
Ki8NCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG9iamVjdC0+aW5kZXhfZmllbGQu
ZGF0YV9vYmogPSBOVUxMOw0KIAkJCWJyZWFrOw0KIA0KIA0K

------_=_NextPart_001_01C3689B.86ABDE80--


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
