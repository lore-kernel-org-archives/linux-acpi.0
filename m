From: "Ow Mun Heng" <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Subject: RE: Thinkpad T40 Fan
Date: Fri, 6 Feb 2004 11:16:09 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C386328088ED7F4E9F81AFBABDDF60DA03F9E35B@wdmyexch02.my.asia.wdc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C3EC5F.91210164"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ben lamothe <blamothe-DPNOqEs/LNQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C3EC5F.91210164
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Hmm, how can Windows keep the fan off but Linux can't?
>=20
> As there is no ACPI fan device, there must be a different method to
> control the fan on this box.
>=20
> 1. It may be some i2c device that Windows knows about but Linux does
> not?
>    Maybe IBM ships some platform specific software with windows?
>    Would be interesting to know if a from-scratch install of the
>    generic non-IBM windows was still able to keep the fan off.
>=20
> 2. It may be some BIOS code using SMM that Linux somehow breaks?
>=20
> 3. It may be done entirely in hardware without the knowledge=20
> of the OS?
>=20
> I'm hopeful that it is #3, and that Windows is simply doing better
> passive cooling than Linux -- and perhaps we can perhaps improve our
> passive cooling...
>=20
> Can you run some experiments?  Maybe you can monitor the=20
> temperature in
> windows to see if it really is cooler.  Perhaps you can=20
> experiment with
> the power management policy settings such that it is in=20
> high-power mode
> instead of maximum battery mode and observe the temperature rises, and
> at what temperature the fan starts running?


Hi,

	Mine's a D600 which DSDT also does not have fan control. (currently=20
using i8kfanutil to control it) Under windows it works fine. The fan=20
can/will come on/off whenever it gets hot (I didn't do the experiments
casuse I use Linux 95% of the time) The fan _can_ be controlled using a =
3rd
party util called FanGui if IIRC. (sort of like i8kfan) but it works =
fine=20
generally on it's own without it.=20

I was under the impression that it was the BIOS that does this.


------_=_NextPart_001_01C3EC5F.91210164
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IikDAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEAHAAAAFJFOiBbQUNQSV0gVGhpbmtw
YWQgVDQwIEZhbgAmCAEFgAMADgAAANQHAgAGAAsAEAAJAAUADAEBIIADAA4AAADUBwIABgALABAA
CQAFAAwBAQmAAQAhAAAAMUNDNEQ3MDc0Q0VENDA0Mzg2NTQ2MjMyNUQzRUFGQUIANwcBA5AGALAK
AAAzAAAACwACAAEAAAADACYAAAAAAAsAKwAAAAAAAwAuAAAAAAADADYAAAAAAEAAOQBkASGRX+zD
AR4APQABAAAABQAAAFJFOiAAAAAAAgFHAAEAAAApAAAAYz1VUzthPSA7bD1XRE1ZRVhDSDAyLTA0
MDIwNjAzMTYwOVotMzQ3NAAAAAAeAHAAAQAAABgAAABbQUNQSV0gVGhpbmtwYWQgVDQwIEZhbgAC
AXEAAQAAABYAAAABw+xfkHPpa0/RIEpKJYfYZ4I5br6VAAAeABoMAQAAAAwAAABPdyBNdW4gSGVu
ZwAeAB0OAQAAABgAAABbQUNQSV0gVGhpbmtwYWQgVDQwIEZhbgACAQkQAQAAABwFAAAYBQAAXggA
AExaRnWaBZ1KAwAKAHJjcGcxMjXiMgNDdGV4BUEBAwH3/wqAAqQD5AcTAoAP8wBQBFY/CFUHshEl
DlEDAQIAY2jhCsBzZXQyBgAGwxEl9jMERhO3MBIsETMI7wn3tjsYHw4wNREiDGBjAFDzCwkBZDM2
FlALpgrjCoRRCoA+IC0d0k8FEGcPC4AHQAXQB5BzYWdlSx3THVZGA2E6IADQcARpLQEAdmVsLWEk
ZG0LgEBsBAB0c3QucwhhYwEQBbAfAC4GbhQgHVZIbW0sIFRobwfgYwORVwuAZAsjkAQgawngcCB0
aChlIGYDkW8BICBiSnUFQEwLgHV4I7In7HQ/HVYdVkEEICTRGCAiIAQAIG5vEMBDUG5JJQMgoQ3g
ZSNgJ8RtbnUhgCWAJPBhKQAGkGZfJ+ECMCngFCAjgGQkwG//HVYFoAIwA2ADICTXA6Ak0BMoIQbg
eC4mnjEuIPJJKxFheSoyIcAHgCgQ7DJjKQUkwWEFQCQHKFD/JFEBoAhgKiElpyQwB5AdVjcoUCZ4
NHFNL3AqQUlC9k0vwC2AcAQgL9MLUQAw9QWwbS/AcAWQBpAN4C/B/QGAdwrAJPAD8CTQN6EkI/Uz
+lcIYGwrgCpBC4AOsPcYICGAC4BnK5ExkygQJXD7KnADUi0E8TDwE9A5sSGA/wdAAyAlUCTCNAkf
ACKABRBzMEAoUG4tNRI4BTegYe81kTowPHEBoGwwsTqRJJ3FLf8yLx9CSU8F8AWgzQEAICoAOkJT
TTUwMNOXJdQv0iOCYhggYWs4aF0dVjNCeiQwIoAgKvFp/RggbC+AC4AjcAsRN2cyInck0jGiP/Bk
HwAnBzykIHNDoEZfSSc2cCOANqBmzzlQMMQ3wCgSIzMjYABw7yuBMOooIQCQbQtQL4AkMH86QipA
AkAEkB1WCrAEEGn/IMAsMQbwOkMT4AOgJdQd0NtO8zagchPgNYF3UlEDkX9UFlBRA2BSQQhhUX9S
hC4rV6AmnkMDkXkIYCBy/nUDoC/TDsBUEQdxAjA4YP80llkSI8IEYAMAK6AFwCTS/x1WDrBQYASQ
MPAIcDmiHVb/PrY6gRQQKAElcE5hRgE8cJ9I8QQgUnIEkEJwIFBUJb9bJh1WWeg3o1xnJOFwI5C/
EoEDgR7xYqNj8CFgYy+A/xQROjI1kRrQN+BOGUkRHVbxLYBnaC1j9QRxHVY8Iq9GECuAPKEAwHgH
cHU2cD5iMPA54S+ABGJO829ifRQQclJBJNJc6gUQFBBz907jHVYw8Xcw4lzqJNY8QX8AIAQgWVED
ADpQTEUc+kg8aSxwuwGRBdALgGUn+THhIEQcMBZQbjAN4Dfg0ERTRFQgQGwhwDLzPzOySTFSQSUS
LEVCcChjHwhwKuJI4Rz0RCRpOGs/JREloAMROoEsRjfAKSDeVSQgEoE+tk5hdwWwRjB3JQBzIUJw
VCTlHPQjwS/fA/A8cQWgL/ECIC8lUm4w/z3BIMAFwE5hHwBwASOABUD2KCiwKpBkJlEy8STDWel/
fAZmABQQLyBEESTwJdQ5fDUlS6Y6MAeAeZB7hl99I8FfKjIsRUrRRBUqcDP3CyIdEgqxdC+AeHMj
wITTIkYAcEd1aTrySUn8UkN2gSHAACA8kiFgJID/eAV5kCWSepsc5T2zX7MtQf83wHNRI5ADoEnW
N8BCcBz6fyiwPzJZYHnSJNJVgh7Baf8tQ040PzIk0kODMNN08y1yC1fFHPR9ktAeADUQAQAAAEYA
AAA8QzM4NjMyODA4OEVEN0Y0RTlGODFBRkJBQkRERjYwREEwM0Y5RTM1QkB3ZG15ZXhjaDAyLm15
LmFzaWEud2RjLmNvbT4AAAAeAEIQAQAAAEAAAAA8QkYxRkUxODU1MzUwQTA0NzkwOTdCM0EwRDJB
ODBFRTBDQzhBQjVAaGRzbXN4NDAyLmhkLmludGVsLmNvbT4AAwCAEP////8fAPMQAQAAAEQAAABS
AEUAJQAzAEEAIABbAEEAQwBQAEkAXQAgAFQAaABpAG4AawBwAGEAZAAgAFQANAAwACAARgBhAG4A
LgBFAE0ATAAAAAsA9hAAAAAAQAAHMBCfHpFf7MMBQAAIMFh2NpFf7MMBAwDeP59OAAADAPE/CQQA
AB4A+D8BAAAADAAAAE93IE11biBIZW5nAAIB+T8BAAAASgAAAAAAAADcp0DIwEIQGrS5CAArL+GC
AQAAAAAAAAAvTz1XREMvT1U9V0RFWENIL0NOPVJFQ0lQSUVOVFMvQ049T1cuTVVOLkhFTkcAAAAe
APo/AQAAABUAAABTeXN0ZW0gQWRtaW5pc3RyYXRvcgAAAAACAfs/AQAAAB4AAAAAAAAA3KdAyMBC
EBq0uQgAKy/hggEAAAAAAAAALgAAAAMA/T/kBAAAAwAZQAAAAAADABpAAAAAAB4AMEABAAAADAAA
AE9XLk1VTi5IRU5HAB4AMUABAAAADAAAAE9XLk1VTi5IRU5HAB4AOEABAAAADAAAAE9XLk1VTi5I
RU5HAB4AOUABAAAAAgAAAC4AAAADAAlZAQAAAAsAZoEIIAYAAAAAAMAAAAAAAABGAAAAAA6FAAAA
AAAAAwB+gQggBgAAAAAAwAAAAAAAAEYAAAAAUoUAAH1uAQAeAH+BCCAGAAAAAADAAAAAAAAARgAA
AABUhQAAAQAAAAQAAAA5LjAAAwDCgQggBgAAAAAAwAAAAAAAAEYAAAAAAYUAAAAAAAALAMeBCCAG
AAAAAADAAAAAAAAARgAAAAADhQAAAAAAAAMAzIEIIAYAAAAAAMAAAAAAAABGAAAAABGFAAAAAAAA
AwDRgQggBgAAAAAAwAAAAAAAAEYAAAAAEIUAAAAAAAADANiBCCAGAAAAAADAAAAAAAAARgAAAAAY
hQAAAAAAAAsADIIIIAYAAAAAAMAAAAAAAABGAAAAAAaFAAAAAAAACwApAAAAAAALACMAAAAAAAMA
BhCXezupAwAHEPAEAAADABAQAQAAAAMAERABAAAAHgAIEAEAAABlAAAALS0tLS1PUklHSU5BTE1F
U1NBR0UtLS0tLUZST006QUNQSS1ERVZFTC1BRE1JTkBMSVNUU1NPVVJDRUZPUkdFTkVUSE1NLEhP
V0NBTldJTkRPV1NLRUVQVEhFRkFOT0ZGQlVUTAAAAAACAX8AAQAAAEYAAAA8QzM4NjMyODA4OEVE
N0Y0RTlGODFBRkJBQkRERjYwREEwM0Y5RTM1QkB3ZG15ZXhjaDAyLm15LmFzaWEud2RjLmNvbT4A
AACgsg==

------_=_NextPart_001_01C3EC5F.91210164--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
