From: <HurryLin-6hSdJfI2Hxp9nmWX13WWKA@public.gmane.org>
Subject: SuSE AMD x86-64 bits installation issue
Date: Tue, 4 Nov 2003 17:34:23 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <6A7AB4426712514F9E2AB28C407285FA04EBB91B@exchtp02.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C3A2B6.D4D0C94A"
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
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: DreamKu-6hSdJfI2Hxp9nmWX13WWKA@public.gmane.org, StephenChen-6hSdJfI2Hxp9nmWX13WWKA@public.gmane.org, PearHuang-6hSdJfI2Hxp9nmWX13WWKA@public.gmane.org, NormanChung-6hSdJfI2Hxp9nmWX13WWKA@public.gmane.org, KenCho-6hSdJfI2Hxp9nmWX13WWKA@public.gmane.org, ak-l3A5Bk7waGM@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C3A2B6.D4D0C94A
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C3A2B6.D4D0C94A"


------_=_NextPart_002_01C3A2B6.D4D0C94A
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

Dear ACPI developers:

	I am VIA bios engineer. We have APCI problem for SuSe.  We need your =
kindly support.=20

	Now we meet a installation issue in APIC mode when we install SuSe 9.0 =
beta 3 on VIA platform. In ACPI part of BIOS, each interrupt pin (i.e. =
INTA, INTB, INTC, INTD ) of the device will get a assigned IRQ when we =
will claim device's IRQ routing on _PRT device configuration object. If =
interrupt pins of the device is dynamically decided IRQ through device =
object, then the system will hang during installation after _CRS control =
method is executed by OS on the refered device object and the current =
IRQ is returned. If we directly assign IRQ number to each interrupt pin =
of the device, the installation is OK. We think some problems on ACPI =
parsing duing installation.

	We also find another problem about the behavior of different OS =
version. For SuSe 9.0 beta 3, the devices can operate in APIC mode =
(above IRQ 16) when we directly assign IRQ number to each interrupt pin =
of the device. The system will hang when interrupt pins of the device is =
dynamically decided IRQ through device object. For SuSe 9.0 beta 6 and =
final version, the device always only operate in PIC mode. Customers =
can't accept our chipset that the IRQ routing of the devices is limited =
operated in PIC mode. We hope the IRQ routing results of the PCI devices =
to go back SuSe 9.0 beta 3 for future SuSe OS version. Let our platform =
operate in APIC mode. We have at least chance to operate in APIC mode =
for VIA chipset when interrupt pins of the device is directly assigned =
to IRQ number.=20

	The "SuSE AMD x86-64 bits installation issue.txt" is more detailed =
descriptions about above problems and our analysis The "log.txt" is the =
log file gotten from the beta3 which we think the real problem existed =
in ACPI kernel.  If you have any questions please let me know. Thanks !

 <<SuSE AMD x86-64 bits installation issue.txt>>  <<log.txt>>=20
=09
=09
Best Regards,

=AAL=B5q=B5Y            Hurry Hao-Lin Lin
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Software BIOS Team, System Platform, R & D Division, VIA Technologies, =
Inc.
8F, 533, Chung-Cheng Rd., Hsin-Tien,
Taipei, Taiwan, R.O.C.
Tel : 886-2-22185452 EXT. 7619
Fax: 886-2-8667-1061



------_=_NextPart_002_01C3A2B6.D4D0C94A
Content-Type: text/html;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dbig5">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.0.6249.1">
<TITLE>SuSE AMD x86-64 bits installation issue</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Dear ACPI developers:</FONT>
</P>

<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">I am VIA bios engineer. We have APCI problem for =
SuSe.&nbsp; We need your kindly support. </FONT>
</P>

<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">Now we meet a installation issue in APIC mode when we =
install SuSe 9.0 beta 3 on VIA platform. In ACPI part of BIOS, each =
interrupt pin (i.e. INTA, INTB, INTC, INTD ) of the device will get a =
assigned IRQ when we will claim device's IRQ routing on _PRT device =
configuration object. If interrupt pins of the device is dynamically =
decided IRQ through device object, then the system will hang during =
installation after _CRS control method is executed by OS on the refered =
device object and the current IRQ is returned. If we directly assign IRQ =
number to each interrupt pin of the device, the installation is OK. We =
think some problems on ACPI parsing duing installation.</FONT></P>

<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">We also find another problem about the behavior of =
different OS version. For SuSe 9.0 beta 3, the devices can operate in =
APIC mode (above IRQ 16) when we directly assign IRQ number to each =
interrupt pin of the device. The system will hang when interrupt pins of =
the device is dynamically decided IRQ through device object. For SuSe =
9.0 beta 6 and final version, the device always only operate in PIC =
mode. Customers can't accept our chipset that the IRQ routing of the =
devices is limited operated in PIC mode. We hope the IRQ routing results =
of the PCI devices to go back SuSe 9.0 beta 3 for future SuSe OS =
version. Let our platform operate in APIC mode. We have at least chance =
to operate in APIC mode for VIA chipset when interrupt pins of the =
device is directly assigned to IRQ number. </FONT></P>

<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<SPAN =
LANG=3D"zh-tw"></SPAN><SPAN LANG=3D"zh-tw"> <FONT SIZE=3D2 =
FACE=3D"Arial">The &quot;SuSE AMD x86-64 bits installation =
issue.txt&quot; is more detailed descriptions about above problems and =
our analysis The &quot;log.txt&quot; is the log file gotten from the =
beta3 which we think the real problem existed in ACPI kernel.&nbsp; If =
you have any questions please let me know. Thanks !</FONT></SPAN></P>

<P><SPAN LANG=3D"en-us"><FONT FACE=3D"MingLiu" SIZE=3D2 =
COLOR=3D"#000000"> &lt;&lt;SuSE AMD x86-64 bits installation =
issue.txt&gt;&gt; </FONT><FONT FACE=3D"MingLiu" SIZE=3D2 =
COLOR=3D"#000000"> &lt;&lt;log.txt&gt;&gt; </FONT></SPAN>

<BR><SPAN LANG=3D"en-us">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</SPAN>

<BR><SPAN =
LANG=3D"en-us">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</SPAN><SPAN =
LANG=3D"zh-tw"></SPAN><SPAN LANG=3D"zh-tw"> </SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Times New Roman">Best =
Regards,</FONT></SPAN>
</P>

<P><SPAN LANG=3D"zh-tw"><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"=B7s=B2=D3=A9=FA=C5=E9">=AAL=B5q=B5Y&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT COLOR=3D"#0000FF" =
SIZE=3D2 FACE=3D"Times New Roman">Hurry Hao-Lin Lin</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT COLOR=3D"#008080" SIZE=3D2 FACE=3D"Times =
New =
Roman">=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Times New =
Roman">Software </FONT><FONT COLOR=3D"#FF0000" SIZE=3D2 FACE=3D"Times =
New Roman">BIOS</FONT><FONT SIZE=3D2 FACE=3D"Times New Roman"> Team, =
System Platform, R &amp; D Division, VIA Technologies, =
Inc.</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Times New Roman">8F, =
533, Chung-Cheng Rd., Hsin-Tien,</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Times New Roman">Taipei, =
Taiwan, R.O.C.</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Times New Roman">Tel : =
886-2-22185452 EXT. </FONT><FONT COLOR=3D"#FF00FF" SIZE=3D2 =
FACE=3D"Times New Roman">7619</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Times New Roman">Fax: =
886-2-8667-1061</FONT></SPAN><SPAN LANG=3D"zh-tw"></SPAN><SPAN =
LANG=3D"zh-tw"></SPAN><SPAN LANG=3D"zh-tw"></SPAN>
</P>
<BR>

</BODY>
</HTML>
------_=_NextPart_002_01C3A2B6.D4D0C94A--

------_=_NextPart_001_01C3A2B6.D4D0C94A
Content-Type: text/plain;
	name="SuSE AMD x86-64 bits installation issue.txt"
Content-Transfer-Encoding: base64
Content-Description: SuSE AMD x86-64 bits installation issue.txt
Content-Disposition: attachment;
	filename="SuSE AMD x86-64 bits installation issue.txt"

DQpXZSByb3VnaGx5IGRlc2NyaWJlIGZvciBJUlEgcm91dGluZyBiZWxvdy4NCkluIEFDUEkgMS4w
YiwgdGhlcmUgYXJlIHR3byBtZXRob2RzIHRvIGFzc2lnbiBJUlEgbnVtYmVyIGZvciBQQ0kgZGV2
aWNlcy4NCjEuCVdlIGNsYWltIGRldmljZSBvYmplY3QgZm9yIGVhY2ggaW50ZXJydXB0IHBpbiwg
UENJIGRldmljZXMgY2FuIHJlZmVyIHRoZXNlIGRldmljZSBvYmplY3RzIHRvIGR5bmFtaWNhbGx5
IGRldGVybWluZSBpdHMgSVJRIG51bWJlciBhY2NvcmRpbmcgdG8gdGhlIG1ldGhvZHMgb2YgdGhl
c2UgZGV2aWNlIG9iamVjdHMuIEluIGN1cnJlbnQgYmlvcywgaW50ZXJuYWwgZGV2aWNlcyhzdWNo
IGFzIElERSwgTEFOLCBVU0IsIEF1ZGlvKSB3aWxsIGJlIGR5bmFtaWNhbGx5IGRlY2lkZWQgSVJR
IG51bWJlcnMgYWNjb3JkaW5nIHRvIGRpZmZlcmVudCBTQi4gCQ0KDQpFeGFtcGxlOg0KDQpEZXZp
Y2UoQUxLRCkNCnsNCglOYW1lKF9ISUQsIEVJU0FJRCgiUE5QMEMwRiIpKSAgICAgICAgICAgICAg
ICAgICAgICAgICAgLy8gUENJIGludGVycnVwdCBsaW5rDQoJTmFtZShfVUlELCA4KQ0KICAgICAg
ICAgICAgTWV0aG9kKF9QUlMsIFJlc291cmNlVGVtcGxhdGUoKSB7ICAgICAgICAgICAgICAgICAN
CiAgICAgICAgICAgICAgICAgICAgSW50ZXJydXB0KFJlc291cmNlQ29uc3VtZXIsTGV2ZWwsQWN0
aXZlTG93LFNoYXJlZCkgezIxfSAgDQogICAgICAgICAgICB9KQ0KICAgICAgICAgICAgTWV0aG9k
KF9ESVMpe30NCiAgICAgICAgICAgIE1ldGhvZChfQ1JTLDApew0KICAgICAgICAgICAgICAgICAg
ICAgTmFtZShCNzdELCBSZXNvdXJjZVRlbXBsYXRlKCkgeyAgICAgICAgICAgICAgICAgDQogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSW50ZXJydXB0KFJlc291cmNlQ29uc3VtZXIs
TGV2ZWwsQWN0aXZlTG93LFNoYXJlZCwsLElSRDIpIHswfQ0KICAgICAgICAgICAgICAgICAgICAg
fSkNCiAgICAgICAgICAgICAgICAgICAgIENyZWF0ZVdvcmRGaWVsZChCNzdELElSRDIuX0lOVCxJ
UkVJKQ0KICAgICAgICAgICAgICAgICAgICAgaWYoTEdyZWF0ZXIoU0JGTCwgMHgxKSl7ICAvLyBD
aGVjayBpZiBTQiBpcyBhZnRlciAxNzcgDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgIElm
KExOb3RFcXVhbChcX1NCLlBDSTAuVVNCMy5VM0lSLDB4MDApKXsgICAgLy9DaGVjayBpZiBVU0In
cyBJUlEgaXMgMCB0aGVuIHJldHVybiAwIGVsc2UgcmV0dXJuIFVTQidzIElSUSANCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTdG9yZShcX1NCLlBDSTAuVVNCMy5VM0lS
LCBJUkVJKSAgICAgLy9VU0IzIElSUQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9DQog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIElmKExOb3RFcXVhbChcX1NCLlBDSTAuVVNCNC5V
NElSLDB4MDApKXsNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTdG9y
ZShcX1NCLlBDSTAuVVNCNC5VNElSLCBJUkVJKSAgICAgICAgVVNCNCBJUlENCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJZihMTm90
RXF1YWwoXF9TQi5QQ0kwLlVTQjUuVTVJUiwweDAwKSl7DQogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgU3RvcmUoXF9TQi5QQ0kwLlVTQjUuVTVJUiwgSVJFSSkgICAgICAg
IFVTQjUgSVJRDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0NCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgSWYoTE5vdEVxdWFsKFxfU0IuUENJMC5VU0I2LlU2SVIsMHgwMCkpew0K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFN0b3JlKFxfU0IuUENJMC5V
U0I2LlU2SVIsIElSRUkpICAgICAgICBVU0I2IElSUQ0KICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB9DQogICAgICAgICAgICAgICAgICAgICAJICAgICBSZXR1cm4oQjc3RCkgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAgICAgICAgICAgICAgIH0NCiAgICAg
ICAgICAgICAgfSAvLyBFbmQgb2YgX0NSUw0KfQ0KICAgICAgICAgICAgICAgIA0KRGV2aWNlKFBD
STApew0KICAgICAgICAgIC4uLiAgICANCiAgICAgICAgICBOYW1lKF9QUlQsIFBhY2thZ2UoKXsg
ICANCgkuLi4NCiAgICAgICAgICAJUGFja2FnZSgpezB4MDBbVlQ4MjM1X1VTQl9JRF1mZmZmLCAw
LCBBTEtELCAwfSwgIC8vIFZUODIzNSBVU0IJDQogICAgICAgICAgCVBhY2thZ2UoKXsweDAwW1ZU
ODIzNV9VU0JfSURdZmZmZiwgMSwgQUxLRCwgMH0sICAvLyBWVDgyMzUgVVNCDQogICAgICAgICAg
CVBhY2thZ2UoKXsweDAwW1ZUODIzNV9VU0JfSURdZmZmZiwgMiwgQUxLRCwgMH0sICAvLyBWVDgy
MzUgVVNCDQogICAgICAgICAgCVBhY2thZ2UoKXsweDAwW1ZUODIzNV9VU0JfSURdZmZmZiwgMywg
QUxLRCwgMH0sICAvLyBWVDgyMzUgVVNCDQogICAgICAgICAgfQ0KfQ0KCQkNCjIuICAgV2UgY2Fu
IGFsc28gZGlyZWN0bHkgYXNzaWduIGltbWVkaWF0ZSB2YWx1ZSB0byBQQ0kgZGV2aWNlcy4gSW4g
Y3VycmVudCBiaW9zLCB3ZSBmaXggdGhlIElSUSByb3V0aW5nIGZvciBQQ0kgc2xvdHMuDQoNCkV4
YW1wbGU6DQoNCkRldmljZShQQ0kwKXsNCiAgICAgICAgICAuLi4gICAgDQogICAgICAgICAgTmFt
ZShfUFJULCBQYWNrYWdlKCl7ICAgDQoJLi4uDQogICAgICAgICAgCVBhY2thZ2UoKXsweDAwW1NM
T1QxX0lEXWZmZmYsIDAsIDAsIDB4MTB9LCAJLy8gU2xvdCAxLCBJTlRBDQoJUGFja2FnZSgpezB4
MDBbU0xPVDFfSURdZmZmZiwgMSwgMCwgMHgxMX0sIAkvLyBTbG90IDEsIElOVEINCglQYWNrYWdl
KCl7MHgwMFtTTE9UMV9JRF1mZmZmLCAyLCAwLCAweDEyfSwgCS8vIFNsb3QgMSwgSU5UQw0KCVBh
Y2thZ2UoKXsweDAwW1NMT1QxX0lEXWZmZmYsIDMsIDAsIDB4MTN9LCAJLy8gU2xvdCAxLCBJTlRE
DQoNCiAgICAgICAgICB9DQp9DQoNCkFib3V0IGludGVybmFsIGRldmljZXMsIHdlIHN1bW1hcml6
ZSB0aGUgaW5zdGFsbGF0aW9uIHJlc3VsdHMgYmV0d2VlbiB0aGUgT1MgdmVyc2lvbiBhbmQgSVJR
IGFzc2lnbm1lbnQuDQogDQoJCVN1U2UgOC4yCQlTdVNlIDkuMCBiZXRhIDMJCVN1U2UgOS4wIGJl
dGEgNgkgICANCkRldmljZSBvYmplY3RzCUNhbqGmdCBpbnN0YWxsCQlDYW6hpnQgaW5zdGFsbAkJ
UElDIG1vZGUJICAgDQpJbW1lZGlhdGUgdmFsdWUJQVBJQyBtb2RlCQlBUElDIG1vZGUJCVBJQyBt
b2RlCSANCg0KRnJvbSB0aGUgYWJvdmUgdGFibGUsIHdlIGhhdmUgc29tZSBhbmFseXNpcyBzaG93
biBhcyBmb2xsb3dzOg0KDQoxLglGb3IgU3VTZSA5LjAgYmV0YSA2LCBpbnN0YWxsYXRpb24gZmFp
bCBpc3N1ZSBoYXMgYmVlbiBmaXhlZCB3aXRoIG9yaWdpbmFsIGJpb3MgdGhhdCBjYW6hpnQgaW5z
dGFsbCBvbiBTdVNlIDguMi4gV2UgY2FuIGluc3RhbGwgU3VTZSA5LjAgYmV0YSA2IGJ1dCB0aGUg
ZGV2aWNlcyBhcmUgb25seSBpbiBQSUMgbW9kZSBldmVuIHdlIGFzc2lnbiBpbW1lZGlhdGUgdmFs
dWVzIChhYm92ZSBJUlEgbnVtYmVyIDE2KS4gRnJvbSBvdXIgdmlld3BvaW50LCBDdXN0b21lcnMg
Y2FuJ3QgYWNjZXB0IG91ciBjaGlwc2V0IHRoYXQgdGhlIElSUSByb3V0aW5nIG9mIHRoZSBkZXZp
Y2VzIGlzIGxpbWl0ZWQgb3BlcmF0ZWQgaW4gUElDIG1vZGUuIFdlIGhvcGUgdGhlIElSUSByb3V0
aW5nIHJlc3VsdHMgb2YgdGhlIFBDSSBkZXZpY2VzIHRvIGdvIGJhY2sgU3VTZSA5LjAgYmV0YSAz
LiBTbyB3ZSBob3BlIHRoYXQgU3VTZSBkZXZlbG9wZXIgY2FuIHByb3ZpZGUgYSBtZXRob2Qgd2Ug
Y2FuIHJlLW9wZXJhdGUgaW4gQVBJQyBtb2RlIGZvciBpbnRlcm5hbCBkZXZpY2VzLiBUaHVzIHdl
IGNhbiBjb250aW51ZSB0byBkZWJ1ZyBvdXIgQVNMIGNvZGUuIA0KDQoyLglJbiBTdVNlIDkuMCBi
ZXRhIDMgaW5zdGFsbGF0aW9uLCB3ZSB1c2Ugb3JpZ2luYWwgYmlvcyB0aGF0IGludGVybmFsIGRl
dmljZXMgd2lsbCByZWZlciBkZXZpY2Ugb2JqZWN0IG9mIGludGVycnVwdCBwaW4gdG8gZGV0ZXJt
aW5lIGl0cyBJUlEgbnVtYmVyLiAgV2UgZGVidWcgdGhlIGNvbnRyb2wgbWV0aG9kcyBvZiBkZXZp
Y2Ugb2JqZWN0cyByZWZlcmVkIGJ5IGludGVybmFsIGRldmljZXMuIFdlIGZpbmQgdGhhdCBPUyBl
eGVjdXRlIHRoZSBpbnRlcm5hbCBkZXZpY2VzoaYgUENJIElSUSByb3V0aW5nIG9mIHRoZSBBU0wg
Y29kZSB0aGUgc2VxdWVuY2UgaXMgX1NUQSwgIF9QUlMsICBfU1RBLCAgX0NSUywgIF9TUlMsICBf
U1RBLCAgX0NSUywgdGhlbiB0aGUgc3lzdGVtIHdpbGwgaGFuZyBhZnRlciBBU0wgY29kZSByZXR1
cm4gcmVzb3VyY2UgaW4gX0NSUyBjb250cm9sIG1ldGhvZC4gVGhlIGF0dGFjaGVkIGZpbGUgaXMg
bG9nIHRoYXQgcmVjb3JkcyBlbnRpcmUgcmVzdWx0IGJlZm9yZSBzeXN0ZW0gaGFuZy4gV2UgaG9w
ZSB0aGUgaW5mb3JtYXRpb24gY2FuIGdpdmUgeW91IHNvbWUgaWRlYSB0byBkZWJ1Zy4NCg0KIA0K

------_=_NextPart_001_01C3A2B6.D4D0C94A
Content-Type: text/plain;
	name="log.txt"
Content-Transfer-Encoding: base64
Content-Description: log.txt
Content-Disposition: attachment;
	filename="log.txt"

b2sNCkJvb3RkYXRhIG9rIChjb21tYW5kIGxpbmUgaXMgQk9PVF9JTUFHRT1saW51eCBTdVNFPSwx
MjA3MzAwMjAwLDgxODY3MjM0LiwgaW5pdHJkDQo9aW5pdHJkIHJhbWRpc2tfc2l6ZT02NTUzNiB2
Z2E9MHgzMWEgc3BsYXNoPXNpbGVudCBlYXJseXByaW50az1zZXJpYWwsdHR5UzAsMzg0MA0KMCBj
b25zb2xlPXR0eVMwLDM4NDAwKQ0KYm9vdGluZyB4ODZfNjQga2VybmVsLi4uIExpbnV4IHZlcnNp
b24gMi40LjIxLTY5LWRlZmF1bHQgKHJvb3RAeDg2XzY0LnN1c2UuZGUpICgNCmdjYyB2ZXJzaW9u
IDMuMy4xIChTdVNFIExpbnV4KSkgIzEgU01QIFdlZCBTZXAgMTAgMDA6MTM6MTYgVVRDIDIwMDMN
CkJJT1MtcHJvdmlkZWQgcGh5c2ljYWwgUkFNIG1hcDoNCiBCSU9TLWU4MjA6IDAwMDAwMDAwMDAw
MDAwMDAgLSAwMDAwMDAwMDAwMDlmYzAwICh1c2FibGUpDQogQklPUy1lODIwOiAwMDAwMDAwMDAw
MDlmYzAwIC0gMDAwMDAwMDAwMDBhMDAwMCAocmVzZXJ2ZWQpDQogQklPUy1lODIwOiAwMDAwMDAw
MDAwMGYwMDAwIC0gMDAwMDAwMDAwMDEwMDAwMCAocmVzZXJ2ZWQpDQogQklPUy1lODIwOiAwMDAw
MDAwMDAwMTAwMDAwIC0gMDAwMDAwMDAwZmZmMDAwMCAodXNhYmxlKQ0KIEJJT1MtZTgyMDogMDAw
MDAwMDAwZmZmMDAwMCAtIDAwMDAwMDAwMGZmZjMwMDAgKEFDUEkgTlZTKQ0KIEJJT1MtZTgyMDog
MDAwMDAwMDAwZmZmMzAwMCAtIDAwMDAwMDAwMTAwMDAwMDAgKEFDUEkgZGF0YSkNCiBCSU9TLWU4
MjA6IDAwMDAwMDAwZmVjMDAwMDAgLSAwMDAwMDAwMGZlYzAxMDAwIChyZXNlcnZlZCkNCiBCSU9T
LWU4MjA6IDAwMDAwMDAwZmVlMDAwMDAgLSAwMDAwMDAwMGZlZTAxMDAwIChyZXNlcnZlZCkNCiBC
SU9TLWU4MjA6IDAwMDAwMDAwZmZmZjAwMDAgLSAwMDAwMDAwMTAwMDAwMDAwIChyZXNlcnZlZCkN
Cmtlcm5lbCBkaXJlY3QgbWFwcGluZyB0YWJsZXMgdXB0byAxMDEwMDAwMDAwMCBAIDgwMDAtYjAw
MA0KU2NhbiBTTVAgZnJvbSAwMDAwMDEwMDAwMDAwMDAwIGZvciAxMDI0IGJ5dGVzLg0KU2NhbiBT
TVAgZnJvbSAwMDAwMDEwMDAwMDlmYzAwIGZvciAxMDI0IGJ5dGVzLg0KU2NhbiBTTVAgZnJvbSAw
MDAwMDEwMDAwMGYwMDAwIGZvciA2NTUzNiBieXRlcy4NCmZvdW5kIFNNUCBNUC10YWJsZSBhdCAw
MDAwMDAwMDAwMGY1M2EwDQpobSwgcGFnZSAwMDBmNTAwMCByZXNlcnZlZCB0d2ljZS4NCmhtLCBw
YWdlIDAwMGY2MDAwIHJlc2VydmVkIHR3aWNlLg0KaG0sIHBhZ2UgMDAwZjAwMDAgcmVzZXJ2ZWQg
dHdpY2UuDQpobSwgcGFnZSAwMDBmMTAwMCByZXNlcnZlZCB0d2ljZS4NCk9uIG5vZGUgMCB0b3Rh
bHBhZ2VzOiA2NTUyMA0Kem9uZSgwKTogNDA5NiBwYWdlcy4NCnpvbmUoMSk6IDYxNDI0IHBhZ2Vz
Lg0Kem9uZSgyKTogMCBwYWdlcy4NCkFDUEk6IFJTRFAgKHYwMDAgVklBSzggICAgICAgICAgICAg
ICAgICAgICAgKSBAIDB4MDAwMDAwMDAwMDBmNmUxMA0KQUNQSTogUlNEVCAodjAwMSBWSUFLOCAg
QVdSREFDUEkgMTY5NDQuMTE4MjUpIEAgMHgwMDAwMDAwMDBmZmYzMDAwDQpBQ1BJOiBGQURUICh2
MDAxIFZJQUs4ICBBV1JEQUNQSSAxNjk0NC4xMTgyNSkgQCAweDAwMDAwMDAwMGZmZjMwNDANCkFD
UEk6IE1BRFQgKHYwMDEgVklBSzggIEFXUkRBQ1BJIDE2OTQ0LjExODI1KSBAIDB4MDAwMDAwMDAw
ZmZmOTE0MA0KQUNQSTogRFNEVCAodjAwMSBWSUFLOCAgQVdSREFDUEkgMDAwMDAuMDQwOTYpIEAg
MHgwMDAwMDAwMDAwMDAwMDAwDQpBQ1BJOiBMb2NhbCBBUElDIGFkZHJlc3MgMHhmZWUwMDAwMA0K
QUNQSTogTEFQSUMgKGFjcGlfaWRbMHgwMF0gbGFwaWNfaWRbMHgwMF0gZW5hYmxlZCkNClByb2Nl
c3NvciAjMCAxNTo0IEFQSUMgdmVyc2lvbiAxNg0KQUNQSTogSU9BUElDIChpZFsweDAyXSBhZGRy
ZXNzWzB4ZmVjMDAwMDBdIGdsb2JhbF9pcnFfYmFzZVsweDBdKQ0KSU9BUElDWzBdOiBBc3NpZ25l
ZCBhcGljX2lkIDINCklPQVBJQ1swXTogYXBpY19pZCAyLCB2ZXJzaW9uIDMsIGFkZHJlc3MgMHhm
ZWMwMDAwMCwgSVJRIDAtMjMNCkFDUEk6IElOVF9TUkNfT1ZSIChidXNbMF0gaXJxWzB4MF0gZ2xv
YmFsX2lycVsweDJdIHBvbGFyaXR5WzB4MF0gdHJpZ2dlclsweDBdKQ0KQUNQSTogSU5UX1NSQ19P
VlIgKGJ1c1swXSBpcnFbMHg5XSBnbG9iYWxfaXJxWzB4OV0gcG9sYXJpdHlbMHgzXSB0cmlnZ2Vy
WzB4M10pDQpVc2luZyBBQ1BJIChNQURUKSBmb3IgU01QIGNvbmZpZ3VyYXRpb24gaW5mb3JtYXRp
b24NCkNoZWNraW5nIGFwZXJ0dXJlLi4uDQpDUFUgMDogYXBlcnR1cmUgQCBkMDAwMDAwMCBzaXpl
IDEyOCBNQg0KQnVpbGRpbmcgem9uZWxpc3QgZm9yIG5vZGUgOiAwDQpLZXJuZWwgY29tbWFuZCBs
aW5lOiBCT09UX0lNQUdFPWxpbnV4IFN1U0U9LDEyMDczMDAyMDAsODE4NjcyMzQuLCBpbml0cmQ9
aW5pdHJkDQpyYW1kaXNrX3NpemU9NjU1MzYgdmdhPTB4MzFhIHNwbGFzaD1zaWxlbnQgZWFybHlw
cmludGs9c2VyaWFsLHR0eVMwLDM4NDAwIGNvbnNvbA0KZT10dHlTMCwzODQwMA0KYm9vdHNwbGFz
aDogc2lsZW50IG1vZGUuDQpJbml0aWFsaXppbmcgQ1BVIzANCnRpbWUuYzogRGV0ZWN0ZWQgMS4x
OTMxODIgTUh6IFBJVCB0aW1lci4NCnRpbWUuYzogRGV0ZWN0ZWQgMTU5NS40OTMgTUh6IFRTQyB0
aW1lci4NCkRpc2FibGluZyBlYXJseSBjb25zb2xlDQpvaw0KQm9vdGRhdGEgb2sgKGNvbW1hbmQg
bGluZSBpcyBCT09UX0lNQUdFPWxpbnV4IFN1U0U9LDEyMDczMDAyMDAsODE4NjcyMzQuLCBpbml0
cmQNCj1pbml0cmQgcmFtZGlza19zaXplPTY1NTM2IHZnYT0weDMxYSBzcGxhc2g9c2lsZW50IGVh
cmx5cHJpbnRrPXNlcmlhbCx0dHlTMCwzODQwDQowIGNvbnNvbGU9dHR5UzAsMzg0MDApDQpMaW51
eCB2ZXJzaW9uIDIuNC4yMS02OS1kZWZhdWx0IChyb290QHg4Nl82NC5zdXNlLmRlKSAoZ2NjIHZl
cnNpb24gMy4zLjEgKFN1U0UgTA0KaW51eCkpICMxIFNNUCBXZWQgU2VwIDEwIDAwOjEzOjE2IFVU
QyAyMDAzDQpCSU9TLXByb3ZpZGVkIHBoeXNpY2FsIFJBTSBtYXA6DQogQklPUy1lODIwOiAwMDAw
MDAwMDAwMDAwMDAwIC0gMDAwMDAwMDAwMDA5ZmMwMCAodXNhYmxlKQ0KIEJJT1MtZTgyMDogMDAw
MDAwMDAwMDA5ZmMwMCAtIDAwMDAwMDAwMDAwYTAwMDAgKHJlc2VydmVkKQ0KIEJJT1MtZTgyMDog
MDAwMDAwMDAwMDBmMDAwMCAtIDAwMDAwMDAwMDAxMDAwMDAgKHJlc2VydmVkKQ0KIEJJT1MtZTgy
MDogMDAwMDAwMDAwMDEwMDAwMCAtIDAwMDAwMDAwMGZmZjAwMDAgKHVzYWJsZSkNCiBCSU9TLWU4
MjA6IDAwMDAwMDAwMGZmZjAwMDAgLSAwMDAwMDAwMDBmZmYzMDAwIChBQ1BJIE5WUykNCiBCSU9T
LWU4MjA6IDAwMDAwMDAwMGZmZjMwMDAgLSAwMDAwMDAwMDEwMDAwMDAwIChBQ1BJIGRhdGEpDQog
QklPUy1lODIwOiAwMDAwMDAwMGZlYzAwMDAwIC0gMDAwMDAwMDBmZWMwMTAwMCAocmVzZXJ2ZWQp
DQogQklPUy1lODIwOiAwMDAwMDAwMGZlZTAwMDAwIC0gMDAwMDAwMDBmZWUwMTAwMCAocmVzZXJ2
ZWQpDQogQklPUy1lODIwOiAwMDAwMDAwMGZmZmYwMDAwIC0gMDAwMDAwMDEwMDAwMDAwMCAocmVz
ZXJ2ZWQpDQprZXJuZWwgZGlyZWN0IG1hcHBpbmcgdGFibGVzIHVwdG8gMTAxMDAwMDAwMDAgQCA4
MDAwLWIwMDANClNjYW4gU01QIGZyb20gMDAwMDAxMDAwMDAwMDAwMCBmb3IgMTAyNCBieXRlcy4N
ClNjYW4gU01QIGZyb20gMDAwMDAxMDAwMDA5ZmMwMCBmb3IgMTAyNCBieXRlcy4NClNjYW4gU01Q
IGZyb20gMDAwMDAxMDAwMDBmMDAwMCBmb3IgNjU1MzYgYnl0ZXMuDQpmb3VuZCBTTVAgTVAtdGFi
bGUgYXQgMDAwMDAwMDAwMDBmNTNhMA0KaG0sIHBhZ2UgMDAwZjUwMDAgcmVzZXJ2ZWQgdHdpY2Uu
DQpobSwgcGFnZSAwMDBmNjAwMCByZXNlcnZlZCB0d2ljZS4NCmhtLCBwYWdlIDAwMGYwMDAwIHJl
c2VydmVkIHR3aWNlLg0KaG0sIHBhZ2UgMDAwZjEwMDAgcmVzZXJ2ZWQgdHdpY2UuDQpPbiBub2Rl
IDAgdG90YWxwYWdlczogNjU1MjANCnpvbmUoMCk6IDQwOTYgcGFnZXMuDQp6b25lKDEpOiA2MTQy
NCBwYWdlcy4NCnpvbmUoMik6IDAgcGFnZXMuDQpBQ1BJOiBSU0RQICh2MDAwIFZJQUs4ICAgICAg
ICAgICAgICAgICAgICAgICkgQCAweDAwMDAwMDAwMDAwZjZlMTANCkFDUEk6IFJTRFQgKHYwMDEg
VklBSzggIEFXUkRBQ1BJIDE2OTQ0LjExODI1KSBAIDB4MDAwMDAwMDAwZmZmMzAwMA0KQUNQSTog
RkFEVCAodjAwMSBWSUFLOCAgQVdSREFDUEkgMTY5NDQuMTE4MjUpIEAgMHgwMDAwMDAwMDBmZmYz
MDQwDQpBQ1BJOiBNQURUICh2MDAxIFZJQUs4ICBBV1JEQUNQSSAxNjk0NC4xMTgyNSkgQCAweDAw
MDAwMDAwMGZmZjkxNDANCkFDUEk6IERTRFQgKHYwMDEgVklBSzggIEFXUkRBQ1BJIDAwMDAwLjA0
MDk2KSBAIDB4MDAwMDAwMDAwMDAwMDAwMA0KQUNQSTogTG9jYWwgQVBJQyBhZGRyZXNzIDB4ZmVl
MDAwMDANCkFDUEk6IExBUElDIChhY3BpX2lkWzB4MDBdIGxhcGljX2lkWzB4MDBdIGVuYWJsZWQp
DQpQcm9jZXNzb3IgIzAgMTU6NCBBUElDIHZlcnNpb24gMTYNCkFDUEk6IElPQVBJQyAoaWRbMHgw
Ml0gYWRkcmVzc1sweGZlYzAwMDAwXSBnbG9iYWxfaXJxX2Jhc2VbMHgwXSkNCklPQVBJQ1swXTog
QXNzaWduZWQgYXBpY19pZCAyDQpJT0FQSUNbMF06IGFwaWNfaWQgMiwgdmVyc2lvbiAzLCBhZGRy
ZXNzIDB4ZmVjMDAwMDAsIElSUSAwLTIzDQpBQ1BJOiBJTlRfU1JDX09WUiAoYnVzWzBdIGlycVsw
eDBdIGdsb2JhbF9pcnFbMHgyXSBwb2xhcml0eVsweDBdIHRyaWdnZXJbMHgwXSkNCkFDUEk6IElO
VF9TUkNfT1ZSIChidXNbMF0gaXJxWzB4OV0gZ2xvYmFsX2lycVsweDldIHBvbGFyaXR5WzB4M10g
dHJpZ2dlclsweDNdKQ0KVXNpbmcgQUNQSSAoTUFEVCkgZm9yIFNNUCBjb25maWd1cmF0aW9uIGlu
Zm9ybWF0aW9uDQpDaGVja2luZyBhcGVydHVyZS4uLg0KQ1BVIDA6IGFwZXJ0dXJlIEAgZDAwMDAw
MDAgc2l6ZSAxMjggTUINCkJ1aWxkaW5nIHpvbmVsaXN0IGZvciBub2RlIDogMA0KS2VybmVsIGNv
bW1hbmQgbGluZTogQk9PVF9JTUFHRT1saW51eCBTdVNFPSwxMjA3MzAwMjAwLDgxODY3MjM0Liwg
aW5pdHJkPWluaXRyZA0KcmFtZGlza19zaXplPTY1NTM2IHZnYT0weDMxYSBzcGxhc2g9c2lsZW50
IGVhcmx5cHJpbnRrPXNlcmlhbCx0dHlTMCwzODQwMCBjb25zb2wNCmU9dHR5UzAsMzg0MDANCmJv
b3RzcGxhc2g6IHNpbGVudCBtb2RlLg0KSW5pdGlhbGl6aW5nIENQVSMwDQp0aW1lLmM6IERldGVj
dGVkIDEuMTkzMTgyIE1IeiBQSVQgdGltZXIuDQp0aW1lLmM6IERldGVjdGVkIDE1OTUuNDkzIE1I
eiBUU0MgdGltZXIuDQpEaXNhYmxpbmcgZWFybHkgY29uc29sZQ0KQ29uc29sZTogY29sb3VyIGR1
bW15IGRldmljZSA4MHgyNQ0KQ2FsaWJyYXRpbmcgZGVsYXkgbG9vcC4uLiAzMTg1LjA0IEJvZ29N
SVBTDQpNZW1vcnk6IDI0NTA5MmsvMjYyMDgwayBhdmFpbGFibGUgKDE4ODhrIGtlcm5lbCBjb2Rl
LCAxNDQyOGsgcmVzZXJ2ZWQsIDEyMTBrIGRhdA0KYSwgMTcyayBpbml0KQ0KRGVudHJ5IGNhY2hl
IGhhc2ggdGFibGUgZW50cmllczogMzI3NjggKG9yZGVyOiA3LCA1MjQyODggYnl0ZXMpDQpJbm9k
ZSBjYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDE2Mzg0IChvcmRlcjogNiwgMjYyMTQ0IGJ5dGVz
KQ0KTW91bnQgY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiAyNTYgKG9yZGVyOiAwLCA0MDk2IGJ5
dGVzKQ0KQnVmZmVyLWNhY2hlIGhhc2ggdGFibGUgZW50cmllczogMTYzODQgKG9yZGVyOiA1LCAx
MzEwNzIgYnl0ZXMpDQpQYWdlLWNhY2hlIGhhc2ggdGFibGUgZW50cmllczogNjU1MzYgKG9yZGVy
OiA3LCA1MjQyODggYnl0ZXMpDQpDUFU6IEwxIEkgQ2FjaGU6IDY0SyAoNjQgYnl0ZXMvbGluZS8y
IHdheSksIEQgY2FjaGUgNjRLICg2NCBieXRlcy9saW5lLzIgd2F5KQ0KQ1BVOiBMMiBDYWNoZTog
MTAyNEsgKDY0IGJ5dGVzL2xpbmUvOCB3YXkpDQpNYWNoaW5lIENoZWNrIFJlcG9ydGluZyBlbmFi
bGVkIGZvciBDUFUjMA0KUE9TSVggY29uZm9ybWFuY2UgdGVzdGluZyBieSBVTklGSVgNCm10cnI6
IHYyLjAyICgyMDAyMDcxNikpDQpDUFU6IEwxIEkgQ2FjaGU6IDY0SyAoNjQgYnl0ZXMvbGluZS8y
IHdheSksIEQgY2FjaGUgNjRLICg2NCBieXRlcy9saW5lLzIgd2F5KQ0KQ1BVOiBMMiBDYWNoZTog
MTAyNEsgKDY0IGJ5dGVzL2xpbmUvOCB3YXkpDQpDUFUwOiBBTUQgQXRobG9uKHRtKSA2NCBQcm9j
ZXNzb3IgMjgwMCsgc3RlcHBpbmcgMDANCnBlci1DUFUgdGltZXNsaWNlIGN1dG9mZjogNTEyMS4y
NSB1c2Vjcy4NCnRhc2sgbWlncmF0aW9uIGNhY2hlIGRlY2F5IHRpbWVvdXQ6IDEwIG1zZWNzLg0K
T25seSBvbmUgcHJvY2Vzc29yIGZvdW5kLg0KRU5BQkxJTkcgSU8tQVBJQyBJUlFzDQouLlRJTUVS
OiB2ZWN0b3I9MHgzMSBwaW4xPTIgcGluMj0wDQp0ZXN0aW5nIHRoZSBJTyBBUElDLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4NCg0KLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uIGRv
bmUuDQpVc2luZyBsb2NhbCBBUElDIHRpbWVyIGludGVycnVwdHMuDQpEZXRlY3RlZCAxMi40NjQg
TUh6IEFQSUMgdGltZXIuDQpjcHU6IDAsIGNsb2NrczogMTk5NDM2Niwgc2xpY2U6IDk5NzE4Mw0K
Q1BVMDxUMDoxOTk0MzUyLFQxOjk5NzE2OCxEOjEsUzo5OTcxODMsQzoxOTk0MzY2Pg0KdGltZS5j
OiBVc2luZyBQSVQvVFNDIGJhc2VkIHRpbWVrZWVwaW5nLg0KbWlncmF0aW9uX3Rhc2sgMCBvbiBj
cHU9MA0KQUNQSTogU3Vic3lzdGVtIHJldmlzaW9uIDIwMDMwNjE5DQpQQ0k6IFVzaW5nIGNvbmZp
Z3VyYXRpb24gdHlwZSAxDQpMb29raW5nIGZvciBEU0RUIGluIGluaXRyZCAuLi4gbm90IGZvdW5k
IQ0KQUNQSTogSW50ZXJwcmV0ZXIgZW5hYmxlZA0KQUNQSTogVXNpbmcgSU9BUElDIGZvciBpbnRl
cnJ1cHQgcm91dGluZw0KQUNQSTogU3lzdGVtIFtBQ1BJXSAoc3VwcG9ydHMgUzAgUzEgUzQgUzUp
DQpBQ1BJOiBQQ0kgUm9vdCBCcmlkZ2UgW1BDSTBdICgwMDowMCkNClBDSTogUHJvYmluZyBQQ0kg
aGFyZHdhcmUgKGJ1cyAwMCkNCkFDUEk6IFBDSSBJbnRlcnJ1cHQgTGluayBbTE5LQV0gKElSUXMg
MyA0IDYgNyAxMCAxMSAxMikNCkFDUEk6IFBDSSBJbnRlcnJ1cHQgTGluayBbTE5LQl0gKElSUXMg
MyA0IDYgNyAxMCAqMTEgMTIpDQpBQ1BJOiBQQ0kgSW50ZXJydXB0IExpbmsgW0xOS0NdIChJUlFz
IDMgNCA2IDcgMTAgKjExIDEyKQ0KQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtMTktEXSAoSVJR
cyAzIDQgNiA3IDEwIDExIDEyKQ0KQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtMTktFXSAoSVJR
cyAzIDQgNiA3IDEwIDExIDEyKQ0KQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtMTktGXSAoSVJR
cyAzIDQgNiA3IDEwIDExIDEyKQ0KQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtMTkswXSAoSVJR
cyAzIDQgNiA3IDEwIDExIDEyKQ0KQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtMTksxXSAoSVJR
cyAzIDQgNiA3IDEwIDExIDEyKQ0KQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtBTEtBXSAoSVJR
cyAyMCkNCkFDUEk6IFBDSSBJbnRlcnJ1cHQgTGluayBbQUxLQl0gKElSUXMgMjMpDQpBQ1BJOiBQ
Q0kgSW50ZXJydXB0IExpbmsgW0FMS0NdIChJUlFzIDIyKQ0KQUNQSTogUENJIEludGVycnVwdCBM
aW5rIFtBTEtEXSAoSVJRcyAyMSkNClBDSTogVXNpbmcgY29uZmlndXJhdGlvbiB0eXBlIDENClBD
STogUHJvYmluZyBQQ0kgaGFyZHdhcmUNCkFDUEk6IFBDSSBJbnRlcnJ1cHQgTGluayBbQUxLQV0g
ZW5hYmxlZCBhdCBJUlEgMTENCkxp

------_=_NextPart_001_01C3A2B6.D4D0C94A--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
