From: "Patrick Chemla" <patrick.chemla-GILi49z+0PNQFI55V6+gNQ@public.gmane.org>
Subject: RE : ACPI on VAIO GRX516 doesn't work with klaptop
Date: Fri, 27 Dec 2002 14:49:59 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <!~!AAAAAHHfNonLyrhKpjF+kbT0Zz3kRCUA@mensys.fr>
References: <1040996539.2211.0.camel@lgge-pc176.obs.ujf-grenoble.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_000E_01C2ADB7.3DB15F10"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1040996539.2211.0.camel-EOLtR9nHC0w7VkuvlHBOUdBf7emC4R2pl6ge6I993lI@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Frederic.Parrenin-uJC2I/HWIrG1lNqXp+/2b1AUjnlXr6A1@public.gmane.org
Cc: 'acpi-devel' <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_000E_01C2ADB7.3DB15F10
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



Hi,

Yes it seems to be a klaptop issue. Does anyone knows any other tool =
that
could replace klaptopdaemon ?

Patrick=20
=20

-----Message d'origine-----
De=A0: Parrenin Fr=E9d=E9ric [mailto:parrenin-6cgPr1GgFWewRP7jdkWmCvzYAJ16yAcp@public.gmane.org]=20
Envoy=E9=A0: vendredi 27 d=E9cembre 2002 14:42
=C0=A0: Patrick Chemla
Cc=A0: acpi-devel
Objet=A0: Re: [ACPI] ACPI on VAIO GRX516 doesn't work with klaptop

It is more a klaptop issue.

Regards.

	Frederic


Le mer 25/12/2002 =E0 13:09, Patrick Chemla a =E9crit :
>  =20
> Hi,
> =20
> I have a VAIO PCG-GRX516SP, latest SONY laptop, with P4 2Ghz, 512Mb
memory,
> 60Gb HD, .. A really fine laptop.
> =20
> I first installed a RedHat 8.0 last distribution, updated with latest
> patches on kernel 2.4.18-8-0-18.
> =20
> I downloaded a 2.4.20 kernel from kernel.org, updated with last acpi
patches
> acpi-20021202-2.4.20.diff
> =20
> I build and rebuild my kernel with/out ACPI, with/out APM.
> =20
> Latest status is that /proc/acpi directory contains all info and =
events,
> working well when I plug in/out the AC adapter, when I let the battery
> discharged, I can see battery status, but KLaptopdaemon says that ACPI
seems
> to be partially installed, info not available, no battery.
> =20
> It seems that the problem doesn't come from ACPI drivers themselves, =
but
> from Kalptopdaemon. I have applied some patches on Klaptop that give =
the
> right directory path (/proc/acpi instead of /proc/sys/acpi). Doesn't =
work.

> =20
> Do you have any idea ?
> =20
> Thanks for help.
> =20
>=20
> Patrick Chemla
> =20


------=_NextPart_000_000E_01C2ADB7.3DB15F10
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="winmail.dat"

eJ8+IgQNAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEGAAcAAQAAAAAAAAEGgAMADgAAANIHDAAb
AA4AMQAAAAUARAEBA5AGAEwKAAAuAAAACwACAAEAAAALACMAAAAAAAMAJgAAAAAACwApAAAAAAAD
AC4AAAAAAAIBMQABAAAAGAAAAAAAAABx3zaJy8q4SqYxfpG09Gc95EQlAAMANgAAAAAAHgBwAAEA
AAA1AAAAW0FDUEldIEFDUEkgb24gVkFJTyBHUlg1MTYgZG9lc24ndCB3b3JrIHdpdGgga2xhcHRv
cAAAAAACAXEAAQAAABYAAAABwq2uo1vh+OnNhhdJZYC1l7uVcCgLAAACAR0MAQAAAB4AAABTTVRQ
OlBBVFJJQ0suQ0hFTUxBQE1FTlNZUy5GUgAAAAsAAQ4AAAAAQAAGDgAudLWurcIBAgEKDgEAAAAY
AAAAAAAAAHHfNonLyrhKpjF+kbT0Zz3CgAAAAwAUDgAAAAALAB8OAQAAAB4AKA4BAAAALgAAADAw
MDAwMDAzAXBhdHJpY2suY2hlbWxhQG1lbnN5cy5mcgFNYWlsIE1lblN5cwAAAB4AKQ4BAAAALgAA
ADAwMDAwMDAzAXBhdHJpY2suY2hlbWxhQG1lbnN5cy5mcgFNYWlsIE1lblN5cwAAAAIBCRABAAAA
5QQAAOEEAAATCAAATFpGdagIC4YDAAoAcmNwZzEyNeIyA0N0ZXgFQQEDAfdPCoACpAPjAgBjaArA
c/BldDAgBxMCgA/zAFB/BFYIVQeyEcUOUQMBEMcy9wYABsMRxTMERhDJEtsR09sI7wn3Oxi/DjA1
EcIMYM5jAFALCQFkMzYRUAumRwrjCoQKgEhpLB2aWU0HkWkFQBEgZW0EIHQAbyBiZSBhIGtzC2AF
MG9wH3AEEApQLtggRG8HkQBweQIgIFAQa25vdyGzIG90/mgTISAQBvAgABDwBUAFoLB1bGQgGMAL
UWMiIZkgpGRhH9ACICA/HZpmUCOwBRBjax2FHYstRSgiTQeQc2FnIFBk0icFsGlnC4BlKCMdlABE
ZVwnYTA6IJ0mcHIYwAMAA6BGcipQnGU5CzArcSahIFsAwBsDECAQOgqxKuNAbGcBKMAub2JzLnVq
fGYtCcEiUAJgIVADUF3BHYVFbnZveStiKlQKdgnwZBjBaSAyNz8o4CtiJJAG0BjAMLAwMGEU4DE0
OjQOUB2kJ65jAUAqZSaUQyMAbQtgHR2UQwDgKmMA0HBpLY8BADAwGKAdo09iahEwCSpUUmUqkFtB
Q1AeSS7ANxIi0AOgVkFJAE8gR1JYNTE20yjgIZFuJwVAdwWwJtBvA/Ai8CCGHZpJBUAEACDfBGAx
gSB+HZo2wGcLES2w/x2aDIIrMQmABnEA4D4KHaNeTDuQB4AFwA4wLw4gLwcxsythEVAxMzowOb4s
M007oTEDBRAFQDodlPw+IESgRDYeV0SRRDY3oA8Q8DAwO6E381BDRy25OERTUEJgC2AOsHMFQPBT
T05ZSEEgwkJgOYPEUDQwsEdoekJgOHDcMk0+4AeAO2F5RXcc0FJHPuBIREJgLiFgQeskMQdAbCLA
ZilRSQU8pf9F600QERA7EQCAAZBM0AmAkzuhNsBkSCOxOC4RUB8LYEiRMJBIkAUQYnV09mkCIEJg
dSUhDrAkIDmDd0hURDYKsHQQ4AeRJXFrBwSRNZAwsC40LjE48i1VIDAtVRBNz0aBOLD0d24YUGEB
AE/iVNIdYc9UZQNSVFUtgHJnUe9Ikf81ElOmRDY1EzGyDiAx0FxA/VfDLjCQASBVvzegUYADEO9P
4TBQJDFexG0iwFRlOYI+LwhgBUA3Ekl0YMRQTZlVryBMSGRPgXR1H2GTH/Ejoi9wA2BjL1rD+zCQ
GMBjIBBLECPRAjALcX8hsUzQT1ECEF8TNXECMHP3RXc5MguAZzkgNZBgYSMA9wOgN6ALUHVosAuA
YMMi8f83YTugJTAFMASQSXFpNC5w/Wo0YiOwawEvgERFUSEQ4u0owGRCYDegYwORH7FsNudjtUJg
UYEgS2NQJPkooP55ZEU3cx+zRDYgFAqxUaC/TMNPZ0JgZtMiUFqhdixR/wGgLnBCYCJQbDZiP0aA
H5f/I6JqUmTBLmFYwDi2BaAHgPdYhDdzMGBpMDAREGpCH+DfNZAwMG9kRDZYk0sHQCT4uyFgRpZw
C1AIkCQgc3lS/VO5SyClI5MpQEbRIvFENr0pIWhRAmWGU7E5sChkuadPYkywJCBvZmSlc3DQfWUD
KSFkOPYhYHYfIYAg7SHwdUalIrFpAQAgcCWl5UXpVBDwbmsEIAIQBcB/IwB8kHYPRMczX0W6HZR9
AY4gAAAAHgBCEAEAAAA5AAAAPDEwNDA5OTY1MzkuMjIxMS4wLmNhbWVsQGxnZ2UtcGMxNzYub2Jz
LnVqZi1ncmVub2JsZS5mcj4AAAAAAwCSEAEAAAACARQ6AQAAABAAAACswtnLH9CeQbL1ZsFHoN98
AwDeP69vAAADAAlZAQAAAAMAQGUAAAAACwATgAggBgAAAAAAwAAAAAAAAEYAAAAAA4UAAAAAAAAD
ACeACCAGAAAAAADAAAAAAAAARgAAAAABhQAAAAAAAEAAKIAIIAYAAAAAAMAAAAAAAABGAAAAAGCF
AAAApGqd9///HwMAnoAIIAYAAAAAAMAAAAAAAABGAAAAAFKFAADjkAEAHgCfgAggBgAAAAAAwAAA
AAAAAEYAAAAAVIUAAAEAAAAFAAAAMTAuMAAAAAALAKCACCAGAAAAAADAAAAAAAAARgAAAAAGhQAA
AAAAAAsApIAIIAYAAAAAAMAAAAAAAABGAAAAAA6FAAAAAAAAAwClgAggBgAAAAAAwAAAAAAAAEYA
AAAAEIUAAAAAAAADAKmACCAGAAAAAADAAAAAAAAARgAAAAAYhQAAAAAAAAsAwoAIIAYAAAAAAMAA
AAAAAABGAAAAAIKFAAABAAAAAgH4DwEAAAAQAAAAcd82icvKuEqmMX6RtPRnPQIB+g8BAAAAEAAA
AHHfNonLyrhKpjF+kbT0Zz0CAfsPAQAAAJQAAAAAAAAAOKG7EAXlEBqhuwgAKypWwgAAbXNwc3Qu
ZGxsAAAAAABOSVRB+b+4AQCqADfZbgAAAEM6XERvY3VtZW50cyBhbmQgU2V0dGluZ3NcbWVuc3lz
XExvY2FsIFNldHRpbmdzXEFwcGxpY2F0aW9uIERhdGFcTWljcm9zb2Z0XE91dGxvb2tcT3V0bG9v
ay5wc3QAAwD+DwUAAAADAA00/TcCAAIBFDQBAAAAEAAAAE5JVEH5v7gBAKoAN9luAAACAX8AAQAA
ADEAAAAwMDAwMDAwMDcxREYzNjg5Q0JDQUI4NEFBNjMxN0U5MUI0RjQ2NzNEMjQ0NTI1MDAAAAAA
AwAGEA8i1s0DAAcQbwQAAAMAEBAAAAAAAwAREAEAAAAeAAgQAQAAAGUAAABISSxZRVNJVFNFRU1T
VE9CRUFLTEFQVE9QSVNTVUVET0VTQU5ZT05FS05PV1NBTllPVEhFUlRPT0xUSEFUQ09VTERSRVBM
QUNFS0xBUFRPUERBRU1PTj9QQVRSSUNLLS0tLS1NAAAAAIPE

------=_NextPart_000_000E_01C2ADB7.3DB15F10--




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
