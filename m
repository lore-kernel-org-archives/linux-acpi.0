From: Galin Yordanov <galin-Dn6zUBO643CDvotElmWtJA@public.gmane.org>
Subject: Re: Speedstep-centrino problems
Date: Thu, 10 Feb 2005 06:30:09 -0500
Message-ID: <200502100630.10529.galin@platformis.com>
References: <0FEA36BB2ABDF44FAAFEB7A75367C07A0117D810@alaska.condis.es>
Reply-To: galin-Dn6zUBO643CDvotElmWtJA@public.gmane.org
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_CX0CCvSzbH1dYFc"
In-Reply-To: <0FEA36BB2ABDF44FAAFEB7A75367C07A0117D810-0IKPNnIBiwz73juT6mD8XA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--Boundary-00=_CX0CCvSzbH1dYFc
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I have Acer TM4500 with Centrino 1.6 (Dothan)and i had the same problem ..
then i found this patch (attached), cannot remember where i found it but it 
works ;)

Regards,
Galin
On Thursday 10 February 2005 04:38 am, Simon Moore wrote:
> Hi,
>
> I'm trying to get acpi cpu throttling working for my Dell Inspiron 510m
> with a Pentium M Centrino 1.6 Ghz cpu.
>
> I have tried a number of possibilites but have not got anywhere. I have
> an open case over at the gentoo forums but we have not had success in
> resolving this problem.
>
> This is my last ditch attempt to try and find a solution to this
> problem. I think I have exhausted most possible avenues so I'm trying to
> get some kernel hacker on board and help me with this.
>
> I would very much appreciate it if someone could take a look at this
> thread and possbily come up with a suggestion of what might be causing
> this. (http://forums.gentoo.org/viewtopic.php?p=2076710) I have a lot of
> info in that thread that you should find useful but if there's any other
> info you require I'll post it tonight.
>
> For what it's worth I hope it intrigues some of you enough to help me
> out.
>
> Thanks all the same,
>
> Regards,
>
> Saimon
>
>
> --------------------------
> Saimon Moore
> Departamento TI
> CondisLine e-Commerce S.A.
>
> telf./fax: 93 565 3400 ext. 473 / 935752325
> http://www.condisline.com
> mailto://simon_moore-HnN13UdsTkzz1n+OaKNE4w@public.gmane.org

-- 
[In Linux We Trust]
Galin Yordanov
galin-Dn6zUBO643CDvotElmWtJA@public.gmane.org

--Boundary-00=_CX0CCvSzbH1dYFc
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="03-cpufreq-speedstep-dothan-3.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="03-cpufreq-speedstep-dothan-3.patch"

LS0tIC4vYXJjaC9pMzg2L2tlcm5lbC9jcHUvY3B1ZnJlcS9zcGVlZHN0ZXAtY2VudHJpbm8uYy5v
cmlnCTIwMDQtMDgtMDYgMTg6NDI6MTUuMDAwMDAwMDAwICswODAwCisrKyAuL2FyY2gvaTM4Ni9r
ZXJuZWwvY3B1L2NwdWZyZXEvc3BlZWRzdGVwLWNlbnRyaW5vLmMJMjAwNC0wOC0wNiAxODo0NDoy
OC4wMDAwMDAwMDAgKzA4MDAKQEAgLTE5NSw2ICsxOTUsODIgQEAKIAlPUCgxNzAwLCAxNDg0KSwK
IAl7IC5mcmVxdWVuY3kgPSBDUFVGUkVRX1RBQkxFX0VORCB9CiB9OworCisjdW5kZWYgT1AKKwor
LyogRG90aGFuIHByb2Nlc3NvciBkYXRhc2hlZXQgMzAyMTg5MDMucGRmIGRlZmluZXMgNCB2b2x0
YWdlcyBmb3IgZWFjaAorICAgZnJlcXVlbmN5IChWSUQjQSB0aHJvdWdoIFZJRCNEKSAtIHRoaXMg
bWFjcm8gYWxsb3dzIHVzIHRvIGRlZmluZSBhbGwKKyAgIG9mIHRoZXNlIGJ1dCB3ZSBvbmx5IHVz
ZSB0aGUgVklEI0Mgdm9sdGFnZXMgYXQgY29tcGlsZSB0aW1lIC0gdGhpcyBtYXkKKyAgIG5lZWQg
c29tZSB3b3JrIGlmIHdlIHdhbnQgdG8gc2VsZWN0IHRoZSB2b2x0YWdlIHByb2ZpbGUgYXQgcnVu
dGltZS4gKi8KKworI2RlZmluZSBPUChtaHosIG12YSwgbXZiLCBtdmMsIG12ZCkJCQkJCVwKKwl7
CQkJCQkJCQlcCisJCS5mcmVxdWVuY3kgPSAobWh6KSAqIDEwMDAsCQkJCVwKKwkJLmluZGV4ID0g
KCgobWh6KS8xMDApIDw8IDgpIHwgKChtdmMgLSA3MDApIC8gMTYpICAgICAgIAlcCisJfQorCisv
KiBJbnRlbCBQZW50aXVtIE0gcHJvY2Vzc29yIDcxNSAvIDEuNTBHSHogKERvdGhhbikgKi8KK3N0
YXRpYyBzdHJ1Y3QgY3B1ZnJlcV9mcmVxdWVuY3lfdGFibGUgZG90aGFuXzE1MDBbXSA9Cit7CisJ
T1AoIDYwMCwgIDk4OCwgIDk4OCwgIDk4OCwgIDk4OCksCisJT1AoIDgwMCwgMTA2OCwgMTA2OCwg
MTA2OCwgMTA1MiksCisJT1AoMTAwMCwgMTE0OCwgMTE0OCwgMTEzMiwgMTExNiksCisJT1AoMTIw
MCwgMTIyOCwgMTIxMiwgMTIxMiwgMTE4MCksCisJT1AoMTUwMCwgMTM0MCwgMTMyNCwgMTMwOCwg
MTI3NiksCisJeyAuZnJlcXVlbmN5ID0gQ1BVRlJFUV9UQUJMRV9FTkQgfQorfTsKKworLyogSW50
ZWwgUGVudGl1bSBNIHByb2Nlc3NvciA3MjUgLyAxLjYwR0h6IChEb3RoYW4pICovCitzdGF0aWMg
c3RydWN0IGNwdWZyZXFfZnJlcXVlbmN5X3RhYmxlIGRvdGhhbl8xNjAwW10gPQoreworCU9QKCA2
MDAsICA5ODgsICA5ODgsICA5ODgsICA5ODgpLAorCU9QKCA4MDAsIDEwNjgsIDEwNjgsIDEwNTIs
IDEwNTIpLAorCU9QKDEwMDAsIDExMzIsIDExMzIsIDExMTYsIDExMTYpLAorCU9QKDEyMDAsIDEy
MTIsIDExOTYsIDExODAsIDExNjQpLAorCU9QKDE0MDAsIDEyNzYsIDEyNjAsIDEyNDQsIDEyMjgp
LAorCU9QKDE2MDAsIDEzNDAsIDEzMjQsIDEzMDgsIDEyNzYpLAorCXsgLmZyZXF1ZW5jeSA9IENQ
VUZSRVFfVEFCTEVfRU5EIH0KK307CisKKy8qIEludGVsIFBlbnRpdW0gTSBwcm9jZXNzb3IgNzM1
IC8gMS43MEdIeiAoRG90aGFuKSAqLworc3RhdGljIHN0cnVjdCBjcHVmcmVxX2ZyZXF1ZW5jeV90
YWJsZSBkb3RoYW5fMTcwMFtdID0KK3sKKwlPUCggNjAwLCAgOTg4LCAgOTg4LCAgOTg4LCAgOTg4
KSwKKwlPUCggODAwLCAxMDUyLCAxMDUyLCAxMDUyLCAxMDUyKSwKKwlPUCgxMDAwLCAxMTE2LCAx
MTE2LCAxMTE2LCAxMTAwKSwKKwlPUCgxMjAwLCAxMTgwLCAxMTgwLCAxMTY0LCAxMTQ4KSwKKwlP
UCgxNDAwLCAxMjQ0LCAxMjQ0LCAxMjI4LCAxMjEyKSwKKwlPUCgxNzAwLCAxMzQwLCAxMzI0LCAx
MzA4LCAxMjc2KSwKKwl7IC5mcmVxdWVuY3kgPSBDUFVGUkVRX1RBQkxFX0VORCB9Cit9OworCisv
KiBJbnRlbCBQZW50aXVtIE0gcHJvY2Vzc29yIDc0NSAvIDEuODBHSHogKERvdGhhbikgKi8KK3N0
YXRpYyBzdHJ1Y3QgY3B1ZnJlcV9mcmVxdWVuY3lfdGFibGUgZG90aGFuXzE4MDBbXSA9Cit7CisJ
T1AoIDYwMCwgIDk4OCwgIDk4OCwgIDk4OCwgIDk4OCksCisJT1AoIDgwMCwgMTA1MiwgMTA1Miwg
MTA1MiwgMTAzNiksCisJT1AoMTAwMCwgMTExNiwgMTEwMCwgMTEwMCwgMTA4NCksCisJT1AoMTIw
MCwgMTE2NCwgMTE2NCwgMTE0OCwgMTEzMiksCisJT1AoMTQwMCwgMTIyOCwgMTIxMiwgMTIxMiwg
MTE4MCksCisJT1AoMTYwMCwgMTI5MiwgMTI3NiwgMTI2MCwgMTIyOCksCisJT1AoMTgwMCwgMTM0
MCwgMTMyNCwgMTMwOCwgMTI3NiksCisJeyAuZnJlcXVlbmN5ID0gQ1BVRlJFUV9UQUJMRV9FTkQg
fQorfTsKKworLyogSW50ZWwgUGVudGl1bSBNIHByb2Nlc3NvciA3NTUgLyAyLjAwR0h6IChEb3Ro
YW4pICovCitzdGF0aWMgc3RydWN0IGNwdWZyZXFfZnJlcXVlbmN5X3RhYmxlIGRvdGhhbl8yMDAw
W10gPQoreworCU9QKCA2MDAsICA5ODgsICA5ODgsICA5ODgsICA5ODgpLAorCU9QKCA4MDAsIDEw
NTIsIDEwMzYsIDEwMzYsIDEwMzYpLAorCU9QKDEwMDAsIDExMDAsIDEwODQsIDEwODQsIDEwODQp
LAorCU9QKDEyMDAsIDExNDgsIDExMzIsIDExMzIsIDExMTYpLAorCU9QKDE0MDAsIDExOTYsIDEx
ODAsIDExODAsIDExNjQpLAorCU9QKDE2MDAsIDEyNDQsIDEyMjgsIDEyMjgsIDExOTYpLAorCU9Q
KDE4MDAsIDEyOTIsIDEyNzYsIDEyNzYsIDEyNDQpLAorCU9QKDIwMDAsIDEzNDAsIDEzMjQsIDEz
MDgsIDEyNzYpLAorCXsgLmZyZXF1ZW5jeSA9IENQVUZSRVFfVEFCTEVfRU5EIH0KK307CisKICN1
bmRlZiBPUAogCiAjZGVmaW5lIF9CQU5JQVMoY3B1aWQsIG1heCwgbmFtZSkJXApAQCAtMjA1LDYg
KzI4MSwxMyBAQAogfQogI2RlZmluZSBCQU5JQVMobWF4KQlfQkFOSUFTKCZjcHVfaWRzW0NQVV9C
QU5JQVNdLCBtYXgsICNtYXgpCiAKKyNkZWZpbmUgRE9USEFOKGNwdWlkLCBtYXgsIG5hbWUpCVwK
K3sJLmNwdV9pZAkJPSBjcHVpZCwJXAorCS5tb2RlbF9uYW1lCT0gIkludGVsKFIpIFBlbnRpdW0o
UikgTSBwcm9jZXNzb3IgIiBuYW1lICJHSHoiLCBcCisJLm1heF9mcmVxCT0gKG1heCkqMTAwMCwJ
XAorCS5vcF9wb2ludHMJPSBkb3RoYW5fIyNtYXgsCVwKK30KKwogLyogQ1BVIG1vZGVscywgdGhl
aXIgb3BlcmF0aW5nIGZyZXF1ZW5jeSByYW5nZSwgYW5kIGZyZXEvdm9sdGFnZQogICAgb3BlcmF0
aW5nIHBvaW50cyAqLwogc3RhdGljIHN0cnVjdCBjcHVfbW9kZWwgbW9kZWxzW10gPQpAQCAtMjE4
LDYgKzMwMSwxMSBAQAogCUJBTklBUygxNTAwKSwKIAlCQU5JQVMoMTYwMCksCiAJQkFOSUFTKDE3
MDApLAorCURPVEhBTigmY3B1X2lkc1tDUFVfRE9USEFOX0IwXSwgMTUwMCwgIjEuNTAiKSwKKwlE
T1RIQU4oJmNwdV9pZHNbQ1BVX0RPVEhBTl9CMF0sIDE2MDAsICIxLjYwIiksCisJRE9USEFOKCZj
cHVfaWRzW0NQVV9ET1RIQU5fQjBdLCAxNzAwLCAiMS43MCIpLAorCURPVEhBTigmY3B1X2lkc1tD
UFVfRE9USEFOX0IwXSwgMTgwMCwgIjEuODAiKSwKKwlET1RIQU4oJmNwdV9pZHNbQ1BVX0RPVEhB
Tl9CMF0sIDIwMDAsICIyLjAwIiksCiAKIAkvKiBOVUxMIG1vZGVsX25hbWUgaXMgYSB3aWxkY2Fy
ZCAqLwogCXsgJmNwdV9pZHNbQ1BVX0RPVEhBTl9BMV0sIE5VTEwsIDAsIE5VTEwgfSwKQEAgLTIy
Nyw2ICszMTUsNyBAQAogfTsKICN1bmRlZiBfQkFOSUFTCiAjdW5kZWYgQkFOSUFTCisjdW5kZWYg
RE9USEFOCiAKIHN0YXRpYyBpbnQgY2VudHJpbm9fY3B1X2luaXRfdGFibGUoc3RydWN0IGNwdWZy
ZXFfcG9saWN5ICpwb2xpY3kpCiB7Cg==

--Boundary-00=_CX0CCvSzbH1dYFc--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
