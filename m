From: Chris Howells <chris-NvB7AskkBIqIudiWw5vspbVCufUGDwFn@public.gmane.org>
Subject: Re: Latest ACPI + cpufreq on a Dell Inspiron 2650
Date: Mon, 2 Dec 2002 17:56:40 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200212021756.44975.chris@chrishowells.co.uk>
References: <B9ECACBD6885D5119ADC00508B68C1EA0D19B956@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Y75698gLitueUQf"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <B9ECACBD6885D5119ADC00508B68C1EA0D19B956-LkGsggTGxVmSsB6bSF6DdVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Boundary-00=_Y75698gLitueUQf
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: clearsigned data
Content-Disposition: inline

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Robert,

On Monday 02 December 2002 17:14, Moore, Robert wrote:
> Please send us your binary DSDT (cat /proc/acpi/dsdt > dsdt.dat)

That didn't seem to work - it just produced an empty file for some reason... 
However a cp /proc/acpi/dsdt /home/chris/dsdt.dat did. Attached.

I've now enabled verbose acpi debugging in my kernel, and a new dmesg 
reflecting this is attached.

Thanks for the help.

- -- 
Chris Howells -- chris-NvB7AskkBIqIudiWw5vspbVCufUGDwFn@public.gmane.org, pp0u20d9@liv.ac.uk, howells@kde.org
Web: http://chrishowells.co.uk, PGP key: http://chrishowells.co.uk/pgp.txt
KDE: http://www.koffice.org, http://printing.kde.org, http://usability.kde.org

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9657cF8Iu1zN5WiwRAg6XAJ4kvhAohH0aHmiSspzvhELB/DRCagCfeEOz
ErT5c52uElmGCKgNlndlSKA=
=6yFo
-----END PGP SIGNATURE-----

--Boundary-00=_Y75698gLitueUQf
Content-Type: application/octet-stream;
  name="dsdt.dat"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dsdt.dat"

RFNEVJVBAAABhURFTEwgIDg0NU0gICAgAAAEBk1TRlQNAAABW4BQT1JUAQqACgFbgQtQT1JUAVA4
MEgICFdBTEkKAFuATU5WUwAMnP/vBwoQW4EpTU5WUxBPU1lTEENNQVAIQ01CUAhGRENQCExQVFAI
QlRFTghUSFJUCAhfUzBfEggDCgAKAAoACF9TMV8SCAMKAgoCCgAIX1MzXxIIAwoFCgUKAAhfUzRf
EggDCgYKBgoACF9TNV8SCAMKBwoHCgAQTghcX1BSX1uDRQhDUFUwABAQAAAGCF9QQ1QSLAIRFAoR
ggwAAQgAALIAAAAAAAAAeQARFAoRggwAAQgAALMAAAAAAAAAeQAIX1BTUxIsAhIUBgtsBwwgTgAA
C/oAC9wACoMKABIUBguwBAwQJwAAC/oAC9wACoQKARQUX1BQQwCgCFRIUlSkCgGhBKQKABRBCF9Q
VFMBcAoBXC8FX1NCX1BDSTBMUENCRUMwX1ZHQVGgIJKVaAoEcAoAXC8FX1NCX1BDSTBMUENCRUMw
X1BDTVKgGpNoCgNcLwRfU0JfUENJMExQQ0JQSFNTCnmgI5NoCgSgHZRPU1lTCgBcLwRfU0JfUENJ
MExQQ0JQSFNTCg4UN19XQUsBoDCTaAoEhlwuX1NCX1BXUkIKAqAdlE9TWVMKAFwvBF9TQl9QQ0kw
TFBDQlBIU1MKDxBGD19HUEUUGF9MMDMAhlwvA19TQl9QQ0kwVVNCMAoCFBhfTDA0AIZcLwNfU0Jf
UENJMFVTQjEKAhQYX0wwNQCGXC8DX1NCX1BDSTBNT0RNCgIUGF9MMDgAhlwvA19TQl9QQ0kwUENJ
QgoCFBhfTDBCAIZcLwNfU0JfUENJMFBDSUIKAhQYX0wwQwCGXC8DX1NCX1BDSTBVU0IyCgIUSQVf
TDFEAHANPT09PT1HUEVfTDFEPT09PT0AWzGgO5NXQUxJAYBcLwRfU0JfUENJMExQQ0JMUE9MXC8E
X1NCX1BDSTBMUENCTFBPTIZcLl9TQl9MSURfCoAQgukDXF9TQl9bgipMSURfCF9ISUQMQdAMDRQa
X0xJRACkXC8EX1NCX1BDSTBMUENCTFBPTFuCD1BXUkIIX0hJRAxB0AwMW4IPU0xQQghfSElEDEHQ
DA5bgorjA1BDSTAUTARfSU5JAKAPWxJfT1NJYHAKA09TWVOhNHABV0FMSaAQk4dfT1NfChRwCgJP
U1lToRugEJOHX09TXwoncAoBT1NZU6EIcAoAT1NZUwhfSElEDEHQCgMIX0FEUgoACF9CQk4KAFuA
SEJVUwIKQArAW4FHCUhCVVMDAEAQRFJCMAhEUkIxCERSQjIIRFJCMwhEUkI0CERSQjUIRFJCNghE
UkI3CABAFAAEUE0wSAIAAlBNMUwCAAJQTTFIAgACUE0yTAIAAlBNMkgCAAJQTTNMAgACUE0zSAIA
AlBNNEwCAAJQTTRIAgACUE01TAIAAlBNNUgCAAJQTTZMAgACUE02SAIAAkZESEMICEJVRjARRiAL
AQKIDgACDAAAAAAA/wAAAAABAIcYAAEMAwAAAAAAAAAA9wwAAAAAAAD4DAAAAEcB+Az4DAEIhxgA
AQwDAAAAAAANAAD//wAAAAAAAADzAAAAhxgAAAwDAAAAAAAACgD//wsAAAAAAAAAAgAAhxgAAAwD
AAAAAAAADAD/PwwAAAAAAABAAAAAhxgAAAwDAAAAAABADAD/fwwAAAAAAABAAAAAhxgAAAwDAAAA
AACADAD/vwwAAAAAAABAAAAAhxgAAAwDAAAAAADADAD//wwAAAAAAABAAAAAhxgAAAwDAAAAAAAA
DQD/Pw0AAAAAAABAAAAAhxgAAAwDAAAAAABADQD/fw0AAAAAAABAAAAAhxgAAAwDAAAAAACADQD/
vw0AAAAAAABAAAAAhxgAAAwDAAAAAADADQD//w0AAAAAAABAAAAAhxgAAAwDAAAAAAAADgD/Pw4A
AAAAAABAAAAAhxgAAAwDAAAAAABADgD/fw4AAAAAAABAAAAAhxgAAAwDAAAAAACADgD/vw4AAAAA
AABAAAAAhxgAAAwDAAAAAADADgD//w4AAAAAAABAAAAAhxgAAAwDAAAAAAAADwD//w8AAAAAAAAA
AQAAhxgAAAwDAAAAAAAAAAD//7/+AAAAAAAAAAAAhxgAAAwDAAAAAAAAAAAAAAAAAAAAAAAAAAAA
eQAURTlfQ1JTCKAWUE0xTIpCVUYwCoBDMExOcABDMExOoBqTUE0xTAoBjUJVRjALeANDMFJXcABD
MFJXoBZQTTFIikJVRjAKm0M0TE5wAEM0TE6gGpNQTTFICgGNQlVGMAtQBEM0UldwAEM0UlegFlBN
MkyKQlVGMAq2QzhMTnAAQzhMTqAak1BNMkwKAY1CVUYwCygFQzhSV3AAQzhSV6AWUE0ySIpCVUYw
CtFDQ0xOcABDQ0xOoBqTUE0ySAoBjUJVRjALAAZDQ1JXcABDQ1JXoBZQTTNMikJVRjAK7EQwTE5w
AEQwTE6gGpNQTTNMCgGNQlVGMAvYBkQwUldwAEQwUlegF1BNM0iKQlVGMAsHAUQ0TE5wAEQ0TE6g
GpNQTTNICgGNQlVGMAuwB0Q0UldwAEQ0UlegF1BNNEyKQlVGMAsiAUQ4TE5wAEQ4TE6gGpNQTTRM
CgGNQlVGMAuICEQ4UldwAEQ4UlegF1BNNEiKQlVGMAs9AURDTE5wAERDTE6gGpNQTTRICgGNQlVG
MAtgCURDUldwAERDUlegF1BNNUyKQlVGMAtYAUUwTE5wAEUwTE6gGpNQTTVMCgGNQlVGMAs4CkUw
UldwAEUwUlegF1BNNUiKQlVGMAtzAUU0TE5wAEU0TE6gGpNQTTVICgGNQlVGMAsQC0U0UldwAEU0
UlegF1BNNkyKQlVGMAuOAUU4TE5wAEU4TE6gGpNQTTZMCgGNQlVGMAvoC0U4UldwAEU4UlegF1BN
NkiKQlVGMAupAUVDTE5wAEVDTE6gGpNQTTZICgGNQlVGMAvADEVDUldwAEVDUlegF1BNMEiKQlVG
MAvEAUYwTE5wAEYwTE6gGpNQTTBICgGNQlVGMAuYDUYwUldwAEYwUleKQlVGMAvTAU0xTU6KQlVG
MAvXAU0xTViKQlVGMAvfAU0xTE53DAAAAAJEUkI3TTFNTnJ0TTFNWE0xTU4ACgFNMUxOentcLwRf
U0JfUENJMExQQ0JNVFNFDACAAwAACg9goEUJe2AKBACKQlVGMAvuAU0yTU6KQlVGMAvyAU0yTViK
QlVGMAv6AU0yTE5wDAAA0P5NMk1OcAz/A9D+TTJNWHALAARNMkxOoBmTYAoFcAwAEND+TTJNTnAM
/xPQ/k0yTVigGZNgCgZwDAAg0P5NMk1OcAz/I9D+TTJNWKAZk2AKB3AMADDQ/k0yTU5wDP8z0P5N
Mk1YpEJVRjAURQ5fUFJUAKQSTA0HEh4EDP//AQAKAFwvBF9TQl9QQ0kwTFBDQkxOS0EKABIeBAz/
/x0ACgBcLwRfU0JfUENJMExQQ0JMTktBCgASHgQM//8dAAoBXC8EX1NCX1BDSTBMUENCTE5LRAoA
Eh4EDP//HQAKAlwvBF9TQl9QQ0kwTFBDQkxOS0MKABIeBAz//x0ACgNcLwRfU0JfUENJMExQQ0JM
TktICgASHgQM//8fAAoAXC8EX1NCX1BDSTBMUENCTE5LQwoAEh4EDP//HwAKAVwvBF9TQl9QQ0kw
TFBDQkxOS0IKAFuCTTdBR1BCCF9BRFIMAAABABRFBF9QUlQApBI8AhIcBAv//woAXC8EX1NCX1BD
STBMUENCTE5LQQoAEhwEC///CgFcLwRfU0JfUENJMExQQ0JMTktCCgBbgkUyVkdBXwhfQURSCgAI
U1dJVAoBCENSVEEKAQhMQ0RBCgEIVE9HRgoAFAlfU1RBAKQKDwhfUFNDCgAUSAVfUFMwAKBJBFwv
BF9TQl9QQ0kwTFBDQkVDT0twCgBcLwVfU0JfUENJMExQQ0JFQzBfVkdBUXAKAFwvBV9TQl9QQ0kw
TFBDQkVDMF9QQ01ScAoAX1BTQxQNX1BTMQBwCgFfUFNDFEgFX1BTMwCgSQRcLwRfU0JfUENJMExQ
Q0JFQ09LcAoBXC8FX1NCX1BDSTBMUENCRUMwX1ZHQVFwCgFcLwVfU0JfUENJMExQQ0JFQzBfUENN
UnAKA19QU0MUEF9ET1MBcHtoCgMAU1dJVBQaX0RPRABwAVdBTEmkEgwCDAABAQAMEAEBAFuCTglD
UlRfFApfQURSAKQLAAEUQgVfRENTAFwvBF9TQl9QQ0kwTFBDQlBIU1MKDHBcLwRfU0JfUENJMExQ
Q0JJTkZfYKAJYHAKAUNSVEGhCHAKAENSVEGgCENSVEGkCh+hBKQKHRQjX0RHUwBwDUNSVCAtLV9E
R1MAWzGgCENSVEGkCgGhBKQKABQVX0RTUwFwDUNSVCAtLV9EU1MAWzFbgk8GTENEXxQKX0FEUgCk
CxABFCNfRENTAHANTENEIC0tX0RDUwBbMaAITENEQaQKH6EEpAodFCNfREdTAHANTENEIC0tX0RH
UwBbMaAITENEQaQKAaEEpAoAFBVfRFNTAXANTENEIC0tX0RTUwBbMRRNDkRSVUwAXC8EX1NCX1BD
STBMUENCUEhTUwoMcFwvBF9TQl9QQ0kwTFBDQklORl9goE0He2AKIAB7YAoDYaALk2EKA3ABVE9H
RqEJdWFwYVRPR0ZwVE9HRmCgGZNgCgFwDUxDRABbMXAAQ1JUQXABTENEQaAZk2AKAnANQ1JUAFsx
cAFDUlRBcABMQ0RBoCCTYAoDcA1CT1RIAFsxcABUT0dGcAFDUlRBcAFMQ0RBoSdwDUZvcmNlIExD
RCBPbmx5AFsxcAoCVE9HRnAAQ1JUQXABTENEQYZcLwRfU0JfUENJMEFHUEJWR0FfCoBbgkoUUENJ
QghfQURSDAAAHgAIX1BSVBJBBAISHgQM//8EAAoAXC8EX1NCX1BDSTBMUENCTE5LQQoAEh4EDP//
AQAKAFwvBF9TQl9QQ0kwTFBDQkxOS0IKAFuCSgxDQjFfCF9BRFIMAAAEAFuAQ0JSMAIKAAsAAVuB
PENCUjADABBDQTAyEABAHENBM0MgACBDQTQ0IABIJAAHUlNFTAEAQAlQV1MwAgAGUE1FMAEABlBN
UzABFAtfUFNDAKRQV1MwFBFfUFMwAENBSU5wCgBSU0VMFChfUFMzAKAMUE1TMHAKAVBNUzBwCgFQ
TUUwcAoDUFdTMHAKAVJTRUwUHkNBSU4AohBQTVMwcAoBUE1TMFsiCmRwCgBQV1MwFAlfU1RBAKQK
D1uCJUVMQU4IX0FEUgwAAAEAFAlfU1RBAKQKDwhfUFJXEgYCCggKA1uCix8CTFBDQghfQURSDAAA
HwBbgFBNSU8BCwAQCixbgUcFUE1JTxIBAgAAQBQAA1VTMVMBVVMyUwFBOTdTAQACUklTXwEAAlBN
RVMBVVMzUwEAAwADVVMxRQFVUzJFAUE5N0UBAAJSSUVOAQACUE1FRQFVUzNFAVuAR1BJTwELgBEK
O1uBMEdQSU8SAQMAAEgHAARMVjI4AQBLDgAFTFBPTAEAQgUAAVNSU1QBAAYAAkFDUFcBW4BMUENS
AgpkCgFbgQtMUENSAVNJUlEIW4BTTUkwAQwA/gAADAIAAABbgQtTTUkwAFNNSUMIW4BTTUkxAAyd
/u8HDJAAAABbgRZTTUkxAEJDTUQIRElEXyBJTkZPQEBbgRBTTUkxAAEBAAAoSU5GXwhbAVBTTVgA
FCdQSFNTAVsjUFNNWP//cAqAQkNNRHBoRElEX3AAU01JQ1snUFNNWFuATFBDMAIKQArAW4E7TFBD
MAAAQBBQSVJBCFBJUkIIUElSQwhQSVJECAAgUElSRQhQSVJGCFBJUkcIUElSSAgAQDJNVFNFIFuC
RwtMTktBCF9ISUQMQdAMDwhfVUlECgEUEV9ESVMIfVBJUkEKgFBJUkEIX1BSUxEJCgYjuN4YeQAU
RwRfQ1JTCAhSVExBEQkKBiMAABh5AItSVExBCgFJUlEwcABJUlEwoBqSe1BJUkEKgAB7UElSQQoP
YHkKAWBJUlEwpFJUTEEUHF9TUlMJi2gKAUlSUTCCSVJRMGB2YHBgUElSQRQZX1NUQQh7UElSQQqA
YKAFYKQKCaEEpAoLW4JHC0xOS0IIX0hJRAxB0AwPCF9VSUQKAhQRX0RJUwB9UElSQgqAUElSQghf
UFJTEQkKBiO43hh5ABRHBF9DUlMICFJUTEIRCQoGIwAAGHkAi1JUTEIKAUlSUTBwAElSUTCgGpJ7
UElSQgqAAHtQSVJCCg9geQoBYElSUTCkUlRMQhQcX1NSUwmLaAoBSVJRMIJJUlEwYHZgcGBQSVJC
FBlfU1RBCHtQSVJCCoBgoAVgpAoJoQSkCgtbgkcLTE5LQwhfSElEDEHQDA8IX1VJRAoDFBFfRElT
AH1QSVJDCoBQSVJDCF9QUlMRCQoGI7jeGHkAFEcEX0NSUwgIUlRMQxEJCgYjAAAYeQCLUlRMQwoB
SVJRMHAASVJRMKAakntQSVJDCoAAe1BJUkMKD2B5CgFgSVJRMKRSVExDFBxfU1JTCYtoCgFJUlEw
gklSUTBgdmBwYFBJUkMUGV9TVEEIe1BJUkMKgGCgBWCkCgmhBKQKC1uCRwtMTktECF9ISUQMQdAM
DwhfVUlECgQUEV9ESVMAfVBJUkQKgFBJUkQIX1BSUxEJCgYjuN4YeQAURwRfQ1JTCAhSVExEEQkK
BiMAABh5AItSVExECgFJUlEwcABJUlEwoBqSe1BJUkQKgAB7UElSRAoPYHkKAWBJUlEwpFJUTEQU
HF9TUlMJi2gKAUlSUTCCSVJRMGB2YHBgUElSRBQZX1NUQQh7UElSRAqAYKAFYKQKCaEEpAoLW4JH
C0xOS0UIX0hJRAxB0AwPCF9VSUQKBRQRX0RJUwB9UElSRQqAUElSRQhfUFJTEQkKBiO43hh5ABRH
BF9DUlMICFJUTEURCQoGIwAAGHkAi1JUTEUKAUlSUTBwAElSUTCgGpJ7UElSRQqAAHtQSVJFCg9g
eQoBYElSUTCkUlRMRRQcX1NSUwmLaAoBSVJRMIJJUlEwYHZgcGBQSVJFFBlfU1RBCHtQSVJFCoBg
oAVgpAoAoQSkCgtbgkcLTE5LRghfSElEDEHQDA8IX1VJRAoGFBFfRElTAH1QSVJGCoBQSVJGCF9Q
UlMRCQoGI7jeGHkAFEcEX0NSUwgIUlRMRhEJCgYjAAAYeQCLUlRMRgoBSVJRMHAASVJRMKAakntQ
SVJGCoAAe1BJUkYKD2B5CgFgSVJRMKRSVExGFBxfU1JTCYtoCgFJUlEwgklSUTBgdmBwYFBJUkYU
GV9TVEEIe1BJUkYKgGCgBWCkCgChBKQKC1uCRwtMTktHCF9ISUQMQdAMDwhfVUlECgcUEV9ESVMA
fVBJUkcKgFBJUkcIX1BSUxEJCgYjuN4YeQAURwRfQ1JTCAhSVExHEQkKBiMAABh5AItSVExHCgFJ
UlEwcABJUlEwoBqSe1BJUkcKgAB7UElSRwoPYHkKAWBJUlEwpFJUTEcUHF9TUlMJi2gKAUlSUTCC
SVJRMGB2YHBgUElSRhQZX1NUQQh7UElSRwqAYKAFYKQKAKEEpAoLW4JHC0xOS0gIX0hJRAxB0AwP
CF9VSUQKCBQRX0RJUwB9UElSSAqAUElSSAhfUFJTEQkKBiO43hh5ABRHBF9DUlMICFJUTEgRCQoG
IwAAGHkAi1JUTEgKAUlSUTBwAElSUTCgGpJ7UElSSAqAAHtQSVJICg9geQoBYElSUTCkUlRMSBQc
X1NSUwmLaAoBSVJRMIJJUlEwYHZgcGBQSVJIFBlfU1RBCHtQSVJICoBgoAVgpAoAoQSkCgtbgkcG
VElNUghfSElEDEHQAQAIQlVGMBEVChJHAUAAQAABBEcBUABQABAEeQAIQlVGMREYChVHAUAAQAAB
BEcBUABQABAEIgEAeQAUHV9DUlMIoBF7TVRTRQwAAAIAAKRCVUYwpEJVRjFbgkUKSVBJQwhfSElE
C0HQCF9DUlMRQQkKjUcBIAAgAAECRwEkACQAAQJHASgAKAABAkcBLAAsAAECRwEwADAAAQJHATQA
NAABAkcBOAA4AAECRwE8ADwAAQJHAaAAoAABAkcBpACkAAECRwGoAKgAAQJHAawArAABAkcBsACw
AAECRwG0ALQAAQJHAbgAuAABAkcBvAC8AAECRwHQBNAEAQIiBAB5AFuCRwVSVENfCF9ISUQMQdAL
AAhCVUYwEQ0KCkcBcABwAAEIeQAIQlVGMREQCg1HAXAAcAABCCIAAXkAFB1fQ1JTCKARe01UU0UM
AAACAACkQlVGMKRCVUYxW4IlTUFUSAhfSElEDEHQDAQIX0NSUxEQCg1HAfAA8AABASIAIHkAW4JG
BERNQUMIX0hJRAxB0AIACF9DUlMRMAotRwEAAAAAASBHAYEAgQABD0cBkACQAAECRwGTAJMAAQ1H
AcAAwAABICoQAXkAW4JAC01CUkQIX0hJRAxB0AwCCF9DUlMRSgkKlkcBLgAuAAECRwFhAGEAAQFH
AWMAYwABAUcBZQBlAAEBRwFnAGcAAQFHAYAAgAABAUcBkgCSAAEBRwEABgAGARBHAQAHAAcBEEcB
ABAAEAGARwGAEYARAUBHAQASABIBEEcBAP4A/gECRwHw//D/AQ+GCQABAAABAAAAAQCGCQABAPy/
/gAEAACGCQAAAAD4/wAACAB5AFuCLlBTMksIX0hJRAxB0AMDCF9DUlMRGQoWRwFgAGAAAQFHAWQA
ZAABASMCAAF5AFuCHlBTMk0IX0hJRAxB0A8TCF9DUlMRCQoGIwAQAXkAW4JHwlNJT18IX0hJRAxB
0AoFW4BTSUlPAQouCgJbgRBTSUlPAUlORFgIREFUQQhbAU4zOTMAFC1MRFJTA1sjTjM5M///cAoH
SU5EWHBoREFUQXBpSU5EWHBqREFUQVsnTjM5MxQvTERSRwJbI04zOTP//3AKB0lORFhwaERBVEFw
aUlORFhwREFUQWBbJ04zOTOkYBQqUkNGNgFbI04zOTP//3AKJklORFhwREFUQWB7YGhgWydOMzkz
pH9gaABbgkAqRUNQXwhfSElEDEHQBAEIX1VJRAoDFD9fU1RBAHBMRFJHCgEK8GB6YAoFYKAkkFJD
RjYKApGTYAoEk2AKB3lMRFJHCgEKMAoBYXIKDWFhpGGhBKQKABQQX1BTMABMRFJTCgEKMAoBFBBf
UFMzAExEUlMKAQowCgAUSAxfUFJTAKQRTwsKuzBHAXgDeAMICEcBeAd4BwgIIoAAKggAMEcBeAJ4
AggIRwF4BngGCAgiIAAqCAAwRwF4A3gDCAhHAXgHeAcICCIgACoIADBHAXgCeAIICEcBeAZ4BggI
IoAAKggAMEcBeAN4AwgIRwF4B3gHCAgigAAqAgAwRwF4AngCCAhHAXgGeAYICCIgACoCADBHAXgD
eAMICEcBeAd4BwgIIiAAKgIAMEcBeAJ4AggIRwF4BngGCAgigAAqAgA4eQAUEF9ESVMATERSUwoB
CjAKABRADl9DUlMACERDUlMRGwoYRwF4A3gDCAhHAXgHeAcICCKAACoIAHkAcExEUkcKAQpgYXBM
RFJHCgEKYWBwYIhEQ1JTCgIAcGCIRENSUwoKAHBgiERDUlMKBABwYIhEQ1JTCgwAcGGIRENSUwoD
AHBhiERDUlMKBQByYQoEYXBhiERDUlMKCwBwYYhEQ1JTCg0AeQoBTERSRwoBCnBgcGCIRENSUwoR
AHpgCghhcGGIRENSUwoSAHkKAUxEUkcKAQp0YHBgiERDUlMKFAB6YAoIYXBhiERDUlMKFQCkRENS
UxRLBl9TUlMBjGgKAkFEUkyMaAoDQURSTYtoChFJUlFNi2gKFERNQU2CSVJRTWB2YIJETUFNYXZh
TERSUwoBCnBgTERSUwoBCnRhTERSUwoBCmBBRFJNTERSUwoBCmFBRFJMTERSUwoBCjAKAVuCTyFF
UFBfCF9ISUQMQdAEAAhfVUlECgIUP19TVEEAcExEUkcKAQrwYHpgCgVgoCSQUkNGNgoCkZNgCgKT
YAoDeUxEUkcKAQowCgFhcgoNYWGkYaEEpAoAFBBfUFMwAExEUlMKAQowCgEUEF9QUzMATERSUwoB
CjAKABRICF9QUlMApBFPBwp7MEcBeAN4AwgIRwF4B3gHCAgigAAwRwF4AngCCAhHAXgGeAYICCIg
ADBHAXgDeAMICEcBeAd4BwgIIiAAMEcBeAJ4AggIRwF4BngGCAgigAAwRwF4AXgBCAhHAXgFeAUI
CCKAADBHAXgBeAEICEcBeAV4BQgIIiAAOHkAFBBfRElTAExEUlMKAQowCgAUSAtfQ1JTAAhEQ1JT
ERgKFUcBeAN4AwgIRwF4B3gHCAgigAB5AHBMRFJHCgEKYGFwTERSRwoBCmFgcGCIRENSUwoCAHBg
iERDUlMKCgBwYIhEQ1JTCgQAcGCIRENSUwoMAHBhiERDUlMKAwBwYYhEQ1JTCgUAcmEKBGFwYYhE
Q1JTCgsAcGGIRENSUwoNAHkKAUxEUkcKAQpwYHBgiERDUlMKEQB6YAoIYXBhiERDUlMKEgCkRENS
UxRCBV9TUlMBjGgKAkFEUkyMaAoDQURSTYtoChFJUlFNgklSUU1gdmBMRFJTCgEKcGBMRFJTCgEK
YEFEUk1MRFJTCgEKYUFEUkxMRFJTCgEKMAoBW4JDJUxQVEIIX0hJRAxB0AQACF9VSUQKARQ6X1NU
QQBwTERSRwoBCvBgemAKBWCgH5BSQ0Y2CgKTYAoBeUxEUkcKAQowCgFhcgoNYWGkYaEEpAoAFBBf
UFMwAExEUlMKAQowCgEUEF9QUzMATERSUwoBCjAKABRICF9QUlMApBFPBwp7MEcBeAN4AwgIRwF4
B3gHCAgigAAwRwF4AngCCAhHAXgGeAYICCIgADBHAXgDeAMICEcBeAd4BwgIIiAAMEcBeAJ4AggI
RwF4BngGCAgigAAwRwG8A7wDBARHAbwHvAcEBCKAADBHAbwDvAMEBEcBvAe8BwQEIiAAOHkAFBBf
RElTAExEUlMKAQowCgAUQQ9fQ1JTAAhEQ1JTERgKFUcBeAN4AwgIRwF4B3gHCAgigAB5AHBMRFJH
CgEKYGFwTERSRwoBCmFgcGCIRENSUwoCAHBgiERDUlMKCgBwYIhEQ1JTCgQAcGCIRENSUwoMAHBh
iERDUlMKAwBwYYhEQ1JTCgUAcmEKBGFwYYhEQ1JTCgsAcGGIRENSUwoNAKAKe2AKBABwCgRgoQVw
CghgcGCIRENSUwoGAHBgiERDUlMKBwBwYIhEQ1JTCg4AcGCIRENSUwoPAHkKAUxEUkcKAQpwYHBg
iERDUlMKEQB6YAoIYXBhiERDUlMKEgCkRENSUxRCBV9TUlMBjGgKAkFEUkyMaAoDQURSTYtoChFJ
UlFNgklSUU1gdmBMRFJTCgEKcGBMRFJTCgEKYEFEUk1MRFJTCgEKYUFEUkxMRFJTCgEKMAoBW4JD
JUxQVF8IX0hJRAxB0AQACF9VSUQKABQ6X1NUQQBwTERSRwoBCvBgemAKBWCgH5BSQ0Y2CgKTYAoA
eUxEUkcKAQowCgFhcgoNYWGkYaEEpAoAFBBfUFMwAExEUlMKAQowCgEUEF9QUzMATERSUwoBCjAK
ABRICF9QUlMApBFPBwp7MEcBeAN4AwgIRwF4B3gHCAgigAAwRwF4AngCCAhHAXgGeAYICCIgADBH
AXgDeAMICEcBeAd4BwgIIiAAMEcBeAJ4AggIRwF4BngGCAgigAAwRwG8A7wDBARHAbwHvAcEBCKA
ADBHAbwDvAMEBEcBvAe8BwQEIiAAOHkAFBBfRElTAExEUlMKAQowCgAUQQ9fQ1JTAAhEQ1JTERgK
FUcBeAN4AwgIRwF4B3gHCAgigAB5AHBMRFJHCgEKYGFwTERSRwoBCmFgcGCIRENSUwoCAHBgiERD
UlMKCgBwYIhEQ1JTCgQAcGCIRENSUwoMAHBhiERDUlMKAwBwYYhEQ1JTCgUAcmEKBGFwYYhEQ1JT
CgsAcGGIRENSUwoNAKAKe2AKBABwCgRgoQVwCghgcGCIRENSUwoGAHBgiERDUlMKBwBwYIhEQ1JT
Cg4AcGCIRENSUwoPAHkKAUxEUkcKAQpwYHBgiERDUlMKEQB6YAoIYXBhiERDUlMKEgCkRENSUxRC
BV9TUlMBjGgKAkFEUkyMaAoDQURSTYtoChFJUlFNgklSUU1gdmBMRFJTCgEKcGBMRFJTCgEKYEFE
Uk1MRFJTCgEKYUFEUkxMRFJTCgEKMAoBW4JLH0ZEQ18IX0hJRAxB0AcACF9VSUQKABQmX1NUQQCg
GlJDRjYKAXlMRFJHCgAKMAoBYXIKDWFhpGGhBKQKABQQX1BTMABMRFJTCgAKMAoBFBBfUFMzAExE
UlMKAAowCgAUPF9QUlMApBE0CjEwRwHwA/ADCAZHAfcD9wMBASJAACoEADBHAXADcAMIBkcBdwN3
AwEBIkAAKgQAOHkAFBBfRElTAExEUlMKAAowCgAUQA5fQ1JTAAhEQ1JTERsKGEcB8APwAwgGRwH3
A/cDAQEiQAAqBAB5AHBMRFJHCgAKYGFwTERSRwoACmFgcGCIRENSUwoCAHBgiERDUlMKBAByYAoH
YHBgiERDUlMKCgBwYIhEQ1JTCgwAcGGIRENSUwoDAHBhiERDUlMKBQBwYYhEQ1JTCgsAcGGIRENS
UwoNAHkKAUxEUkcKAApwYHBgiERDUlMKEQB6YAoIYXBhiERDUlMKEgB5CgFMRFJHCgAKdGBwYIhE
Q1JTChQAemAKCGFwYYhEQ1JTChUApERDUlMUSwZfU1JTAYxoCgJBRFJMjGgKA0FEUk2LaAoRSVJR
TYtoChRETUFNgklSUU1gdmCCRE1BTWF2YUxEUlMKAApwYExEUlMKAAp0YUxEUlMKAApgQURSTUxE
UlMKAAphQURSTExEUlMKAAowCgFbgjxBQ0FECF9ISUQNQUNQSTAwMDMACF9QQ0wSBwFcX1NCXxQa
X1BTUgCkXC8EX1NCX1BDSTBMUENCQUNQVxQqRUNPSwCgHpNcLwVfU0JfUENJMExQQ0JFQzBfRUNP
SwoBpAoBoQSkCgBbgkZYRUMwXwhfSElEDEHQDAkIX0dQRQocCEVDT0sACF9DUlMRFQoSRwFiAGIA
AQFHAWYAZgABAXkAFBJfUkVHAqALk2gKA3BpRUNPS1uARVJBTQMKAAr/W4E0RVJBTQFTTVBSCFNN
U1QIU01BRAhTTUNNCFNNRDBAEFNNQkMIU01BQQhTTUEwCFNNQTEIW4FMIkVSQU0QAEAUSUNIRwFF
UE9MAUZSU1QBUlNUMAEADAAOQkFUUAFBQ1BSAUNDVVIQQ1ZPTBBDQVJNEEJUQVABQlRCUAEAAkNC
VEEBQ0JUQgEAAlBCWUEBUEJZQgEAAlNNQkEBU01CQgEAAgAYVURFTQFVRFNDAVVEU1MBAAVEUFdS
AVVEUkYBVURSUwFFUUJGAURXRUwBRFBPSwEAAUNLRUoBREtUMAFES1QxAQAFREtDSAFaMDAwAQAH
UzBMRAFTM0xEAVZHQVEBUENNUQFQV0FLAU1XQUsBTFdBSwFBRFBTAVBDTVIBUENNUwEABkZOT1QI
Rk4xVAhGTjJUCEZOM1QIRk40VAhUSE1NAUZOQjABRk5CMQFUSE1TAQAEUFJDVAhMSURTAUxEV0sB
UE1XSwFCTldLAVJJV0sBQlRXSwEAAkJURFQBQlRQVwFCVFJTAUJUU1cBQlRXVQEAA0JBWUUDQkFZ
MQNCQVkyAUlEQ0gBRkFOMAhGQU4xCEZBTjIIRkFOMwhGQU40CAAgQlRZMQhCU1QxCEJSQzEQQlNO
MRBCUFYxEEJGQzEQQkRDMRBCQkMxEAAQQlRZMghCU1QyCEJSQzIQQlNOMhBCUFYyEEJEQzIQADBV
SUQxCFVJRDIIVUlEMwhVSUQ0CFVJRDUIVUlENghVSUQ3CFVJRDgIVUlEOQhVSURBCFVJREIIU05P
MQhTTk8yCFNOTzMIU05PNAhTTk81CFNOTzYIWwFIT1RLABRFBV9RMDUAcA09PT09PVFVRVJZXzA1
PT09PT0AWzGgNlwvBF9TQl9QQ0kwTFBDQkVDT0ugIZNcLwVfU0JfUENJMExQQ0JFQzBfVkdBUQoA
UEhTUwp4FCNfUTA2AHANPT09PT1RVUVSWV8wNj09PT09AFsxUEhTUwp0FCpfUTA3AHANPT09PT1R
VUVSWV8wNz09PT09AFsxhlwuX1NCX0xJRF8KgBQ5X1EwOABwDT09PT09UVVFUllfMDg9PT09PQBb
MVBIU1MKDYZcLwRfU0JfUENJMExQQ0JBQ0FECoAURgZfUTA5AHANPT09PT1RVUVSWV8wOD09PT09
AFsxhlwvBF9TQl9QQ0kwTFBDQkJBVDEKgKAxQlRBUIZcLwRfU0JfUENJMExQQ0JCQVQxCoCGXC8E
X1NCX1BDSTBMUENCQkFUMQqBFEAMX1EwQQBwDT09PT09UVVFUllfMEE9PT09PQBbMaBBClwvBF9T
Ql9QQ0kwTFBDQkVDT0ugSwiTXC8FX1NCX1BDSTBMUENCRUMwX1ZHQVEKAFsjSE9US///oDyTXC8F
X1NCX1BDSTBBR1BCVkdBX1NXSVQKAFsiC/QBXC8FX1NCX1BDSTBBR1BCVkdBX0RSVUxbIgv0AaEj
oCGTXC8FX1NCX1BDSTBBR1BCVkdBX1NXSVQKAVBIU1MKAVsnSE9USxRKBF9RMEIAcA09PT09PVFV
RVJZXzBCPT09PT0AWzGGXC8EX1NCX1BDSTBMUENCQkFUMQqAhlwvBF9TQl9QQ0kwTFBDQkJBVDEK
gRRHBF9RMEMAcA09PT09PVFVRVJZXzBCPT09PT0AWzFcLwVfU0JfUENJMFBDSUJDQjFfQ0FJToZc
LwNfU0JfUENJMFBDSUIKAhQqX1EwRABwDT09PT09UVVFUllfMEI9PT09PQBbMYZcLl9TQl9QV1JC
CoBbgkFaQkFUMQhfVUlECgEIX0hJRAxB0AwKCF9QQ0wSBwFcX1NCXxQzX1NUQQCgJ0VDT0t5XC8F
X1NCX1BDSTBMUENCRUMwX0JUQVAKBGF9YQoPYaRhoQSkCh8URUNfQklGAAhTVEFUEkQEDQoBDP//
//8M/////woBC9A5CgMKAwoDC7gLDTQgAAAAAAAAAAAAAAANMwAAAAAAAA1MSU9OAA1EZWxsICAg
ICAAoE49RUNPSwhVTklEEQ8KDCAgICAgICAgICAgIAhTRU5PEQkKBiAgICAgIHBcLwVfU0JfUENJ
MExQQ0JFQzBfVUlEMYhVTklECgAAcFwvBV9TQl9QQ0kwTFBDQkVDMF9VSUQyiFVOSUQKAQBwXC8F
X1NCX1BDSTBMUENCRUMwX1VJRDOIVU5JRAoCAHBcLwVfU0JfUENJMExQQ0JFQzBfVUlENIhVTklE
CgMAcFwvBV9TQl9QQ0kwTFBDQkVDMF9VSUQ1iFVOSUQKBABwXC8FX1NCX1BDSTBMUENCRUMwX1VJ
RDaIVU5JRAoFAHBcLwVfU0JfUENJMExQQ0JFQzBfVUlEN4hVTklECgYAcFwvBV9TQl9QQ0kwTFBD
QkVDMF9VSUQ4iFVOSUQKBwBwXC8FX1NCX1BDSTBMUENCRUMwX1VJRDmIVU5JRAoIAHBcLwVfU0Jf
UENJMExQQ0JFQzBfVUlEQYhVTklECgkAcFwvBV9TQl9QQ0kwTFBDQkVDMF9VSURCiFVOSUQKCgBw
VU5JRGBwYIhTVEFUCgkAcFwvBV9TQl9QQ0kwTFBDQkVDMF9TTk8xiFNFTk8KAABwXC8FX1NCX1BD
STBMUENCRUMwX1NOTzKIU0VOTwoBAHBcLwVfU0JfUENJMExQQ0JFQzBfU05PM4hTRU5PCgIAcFwv
BV9TQl9QQ0kwTFBDQkVDMF9TTk80iFNFTk8KAwBwXC8FX1NCX1BDSTBMUENCRUMwX1NOTzWIU0VO
TwoEAHBcLwVfU0JfUENJMExQQ0JFQzBfU05PNohTRU5PCgUAcFNFTk9gcGCIU1RBVAoKAHBcLwVf
U0JfUENJMExQQ0JFQzBfQlRZMWB7YAqAYaARYXANTElPTgCIU1RBVAoLAKEQcA1MSU9OAIhTVEFU
CgsAe2AKcGGgGZNhChBwDU1vbGlDZWxsIACIU1RBVAoMAKAZk2EKIHANUGFuYXNvbmljAIhTVEFU
CgwAoBqTYQowcA1Tb255IENvcnAuAIhTVEFUCgwAoBmTYQpAcA1TQU5ZTyAgICAAiFNUQVQKDAB7
XC8FX1NCX1BDSTBMUENCRUMwX0JTVDEKgGCgSwWTYAoBd1wvBV9TQl9QQ0kwTFBDQkVDMF9CREMx
CgphcGGIU1RBVAoBAHdcLwVfU0JfUENJMExQQ0JFQzBfQkZDMQoKYnBiiFNUQVQKAgBwCgCIU1RB
VAoAAKFNBHBcLwVfU0JfUENJMExQQ0JFQzBfQkRDMYhTVEFUCgEAcFwvBV9TQl9QQ0kwTFBDQkVD
MF9CRkMxiFNUQVQKAgBwCgGIU1RBVAoAAKRTVEFUFEIRX0JTVAAIU1RBVBIMBAoBCgALKA8L0Dmg
Qw9FQ09LcFwvBV9TQl9QQ0kwTFBDQkVDMF9CU1QxiFNUQVQKAACgNZVcLwVfU0JfUENJMExQQ0JF
QzBfQkJDMQv/f3BcLwVfU0JfUENJMExQQ0JFQzBfQkJDMWChH3B/XC8FX1NCX1BDSTBMUENCRUMw
X0JCQzEL//8AYHdgCgRhoCSVXC8FX1NCX1BDSTBMUENCRUMwX0JSQzFhcGCIU1RBVAoBAKEMcAoA
iFNUQVQKAQBwXC8FX1NCX1BDSTBMUENCRUMwX0JSQzGIU1RBVAoCAHBcLwVfU0JfUENJMExQQ0JF
QzBfQlBWMYhTVEFUCgMApFNUQVRbgk4EVVNCMAhfQURSDAAAHQBbgFUwQ1MCCsQKBFuBC1UwQ1MD
VTBFTgIIX1BSVxIGAgoDCgEUGV9QU1cBoAlocAoDVTBFTqEIcAoAVTBFTluCTgRVU0IxCF9BRFIM
AQAdAFuAVTFDUwIKxAoEW4ELVTFDUwNVMUVOAghfUFJXEgYCCgQKARQZX1BTVwGgCWhwCgNVMUVO
oQhwCgBVMUVOW4JOBFVTQjIIX0FEUgwCAB0AW4BVMkNTAgrECgRbgQtVMkNTA1UyRU4CCF9QUlcS
BgIKDAoBFBlfUFNXAaAJaHAKA1UyRU6hCHAKAFUyRU5bgknqSURFQwhfQURSDAEAHwBbgElERUMC
CkAKGFuBTwVJREVDA1BSSVQQU0VDVBBQU0lUBFNTSVQEABhTRE1BBAAMU0RUMAIAAlNEVDECAAJT
RFQyAgACU0RUMwIAQgRJQ1IwBElDUjEESUNSMgRJQ1IzBElDUjQESUNSNQRbgk1kUFJJRAhfQURS
CgAUQhVfR1RNAKQRFwoUeAAAAAgAAAB4AAAACAAAAB8AAAAIUEJVRhEXChQAAAAAAAAAAAAAAAAA
AAAAAAAAAIpQQlVGCgBQSU8wilBCVUYKBERNQTCKUEJVRgoIUElPMYpQQlVGCgxETUExilBCVUYK
EEZMQUdwR0VUUFBSSVRQSU8wcEdFVER7U0RNQQoBAHtJQ1IzCgEAe0lDUjAKAQBTRFQwRE1BMKAU
k0RNQTAM/////3BQSU8wRE1BMKAue1BSSVQLAEAAoBSTe1BSSVQKkAAKgHALhANQSU8xoQ5wR0VU
VFBTSVRQSU8xoQtwDP////9QSU8xcEdFVER7U0RNQQoCAHtJQ1IzCgIAe0lDUjAKAgBTRFQxRE1B
MaAUk0RNQTEM/////3BQSU8xRE1BMXBHRVRGe1NETUEKAQB7U0RNQQoCAFBSSVRGTEFHpFBCVUYU
SS1fU1RNA4poCgBQSU8wimgKBERNQTCKaAoIUElPMYpoCgxETUEximgKEEZMQUdwCgRJQ1IyoEMT
k4dpCwACe1BSSVQL8EBQUklUe1NETUEKDlNETUFwCgBTRFQwe0lDUjAKDklDUjB7SUNSMQoOSUNS
MXtJQ1IzCg5JQ1Ize0lDUjUKDklDUjWLaQpiVzQ5MItpCmpXNTMwi2kKflc2MzCLaQqAVzY0MItp
CrBXODgwfVBSSVQLBIBQUklUoB6Qe0ZMQUcKAgB7VzQ5MAsACAB9UFJJVAoCUFJJVH1QUklUU0VU
UFBJTzBXNTMwVzY0MFBSSVSgRAd7RkxBRwoBAH1TRE1BCgFTRE1BcFNFVERETUEwU0RUMKAUe1c4
ODAKIAB9SUNSNQoBSUNSNaAUe1c4ODAKEAB9SUNSMQoBSUNSMaATlURNQTAKHn1JQ1IzCgFJQ1Iz
oBOVRE1BMAo8fUlDUjAKAUlDUjCgThaTh2oLAAJ7UFJJVAsPP1BSSVRwCgBQU0lUe1NETUEKDVNE
TUFwCgBTRFQxe0lDUjAKDUlDUjB7SUNSMQoNSUNSMXtJQ1IzCg1JQ1Ize0lDUjUKDUlDUjWLagpi
VzQ5MYtqCmpXNTMxi2oKflc2MzGLagqAVzY0MYtqCrBXODgxfVBSSVQLQIBQUklUoB6Qe0ZMQUcK
CAB7VzQ5MQsACAB9UFJJVAogUFJJVKBMBHtGTEFHChAAfVBSSVQLAEBQUklUoBOUUElPMQrwfVBS
SVQKgFBSSVShIX1QUklUChBQUklUcFNFVFRQSU8xVzUzMVc2NDFQU0lUoEQHe0ZMQUcKBAB9U0RN
QQoCU0RNQXBTRVRERE1BMVNEVDGgFHtXODgxCiAAfUlDUjUKAklDUjWgFHtXODgxChAAfUlDUjEK
AklDUjGgE5VETUEwCh59SUNSMwoCSUNSM6ATlURNQTAKPH1JQ1IwCgJJQ1IwW4JDEFBfRDAIX0FE
UgoAFEUPX0dURgAIUElCMBERCg4DAAAAAKDvAwAAAACg74xQSUIwCgFQTUQwjFBJQjAKCERNRDCg
QAZ7UFJJVAoCAKATk3tQUklUCgkACghwCghQTUQwoUEEcAoKUE1EMHp7UFJJVAsAAwAKCGB6e1BS
SVQLADAACgxhcmBhYqAMkwoDYnAKC1BNRDCgDJMKBWJwCgxQTUQwoQhwCgFQTUQwoDx7U0RNQQoB
AHB9U0RUMApAAERNRDCgFHtJQ1IwCgEAckRNRDAKAkRNRDCgEHtJQ1IzCgEAcApFRE1EMKEUfXR7
UE1EMAoHAAoCAAogRE1EMKRQSUIwW4JOD1BfRDEIX0FEUgoBFEAPX0dURgAIUElCMRERCg4DAAAA
ALDvAwAAAACw74xQSUIxCgFQTUQxjFBJQjEKCERNRDGgSwV7UFJJVAogAKATk3tQUklUCpAACoBw
CghQTUQxoTxye1BTSVQKAwB6e1BTSVQKDAAKAgBgoAyTCgVgcAoMUE1EMaEXoAyTCgNgcAoLUE1E
MaEIcAoKUE1EMaEIcAoBUE1EMaA8e1NETUEKAgBwfVNEVDEKQABETUQxoBR7SUNSMAoCAHJETUQx
CgJETUQxoBB7SUNSMwoCAHAKRURNRDGhFH10e1BNRDEKBwAKAgAKIERNRDGkUElCMRQGX1BTMAAU
Bl9QUzMAW4JEY1NFQ0QIX0FEUgoBFEkTX0dUTQAIU0JVRhEXChQAAAAAAAAAAAAAAAAAAAAAAAAA
AIpTQlVGCgBQSU8wilNCVUYKBERNQTCKU0JVRgoIUElPMYpTQlVGCgxETUExilNCVUYKEEZMQUdw
R0VUUFNFQ1RQSU8wcEdFVER7U0RNQQoEAHtJQ1IzCgQAe0lDUjAKBABTRFQyRE1BMKAUk0RNQTAM
/////3BQSU8wRE1BMKAue1NFQ1QLAEAAoBSTe1NFQ1QKkAAKgHALhANQSU8xoQ5wR0VUVFNTSVRQ
SU8xoQtwDP////9QSU8xcEdFVER7U0RNQQoIAHtJQ1IzCggAe0lDUjAKCABTRFQzRE1BMaAUk0RN
QTEM/////3BQSU8xRE1BMXBHRVRGe1NETUEKBAB7U0RNQQoIAFNFQ1RGTEFHpFNCVUYUSS1fU1RN
A4poCgBQSU8wimgKBERNQTCKaAoIUElPMYpoCgxETUEximgKEEZMQUdwCgRJQ1IyoEMTk4dpCwAC
e1NFQ1QL8EBTRUNUe1NETUEKC1NETUFwCgBTRFQye0lDUjAKC0lDUjB7SUNSMQoLSUNSMXtJQ1Iz
CgtJQ1Ize0lDUjUKC0lDUjWLaQpiVzQ5MItpCmpXNTMwi2kKflc2MzCLaQqAVzY0MItpCrBXODgw
fVNFQ1QLBIBTRUNUoB6Qe0ZMQUcKAgB7VzQ5MAsACAB9U0VDVAoCU0VDVH1TRUNUU0VUUFBJTzBX
NTMwVzY0MFNFQ1SgRAd7RkxBRwoBAH1TRE1BCgRTRE1BcFNFVERETUEwU0RUMqAUe1c4ODAKIAB9
SUNSNQoESUNSNaAUe1c4ODAKEAB9SUNSMQoESUNSMaATlURNQTAKHn1JQ1IzCgRJQ1IzoBOVRE1B
MAo8fUlDUjAKBElDUjCgThaTh2oLAAJ7U0VDVAsPP1NFQ1RwCgBTU0lUe1NETUEKB1NETUFwCgBT
RFQze0lDUjAKB0lDUjB7SUNSMQoHSUNSMXtJQ1IzCgdJQ1Ize0lDUjUKB0lDUjWLagpiVzQ5MYtq
CmpXNTMxi2oKflc2MzGLagqAVzY0MYtqCrBXODgxfVNFQ1QLQIBTRUNUoB6Qe0ZMQUcKCAB7VzQ5
MQsACAB9U0VDVAogU0VDVKBMBHtGTEFHChAAfVNFQ1QLAEBTRUNUoBOUUElPMQrwfVNFQ1QKgFNF
Q1ShIX1TRUNUChBTRUNUcFNFVFRQSU8xVzUzMVc2NDFTU0lUoEQHe0ZMQUcKBAB9U0RNQQoIU0RN
QXBTRVRERE1BMVNEVDOgFHtXODgxCiAAfUlDUjUKCElDUjWgFHtXODgxChAAfUlDUjEKCElDUjGg
E5VETUEwCh59SUNSMwoISUNSM6ATlURNQTAKPH1JQ1IwCghJQ1IwW4JDEFNfRDAIX0FEUgoAFEUP
X0dURgAIU0lCMBERCg4DAAAAAKDvAwAAAACg74xTSUIwCgFQTUQwjFNJQjAKCERNRDCgQAZ7U0VD
VAoCAKATk3tTRUNUCgkACghwCghQTUQwoUEEcAoKUE1EMHp7U0VDVAsAAwAKCGB6e1NFQ1QLADAA
CgxhcmBhYqAMkwoDYnAKC1BNRDCgDJMKBWJwCgxQTUQwoQhwCgFQTUQwoDx7U0RNQQoEAHB9U0RU
MgpAAERNRDCgFHtJQ1IwCgQAckRNRDAKAkRNRDCgEHtJQ1IzCgQAcApFRE1EMKEUfXR7UE1EMAoH
AAoCAAogRE1EMKRTSUIwW4JOD1NfRDEIX0FEUgoBFEAPX0dURgAIU0lCMRERCg4DAAAAALDvAwAA
AACw74xTSUIxCgFQTUQxjFNJQjEKCERNRDGgSwV7U0VDVAogAKATk3tTRUNUCpAACoBwCghQTUQx
oTxye1NTSVQKAwB6e1NTSVQKDAAKAgBgoAyTCgVgcAoMUE1EMaEXoAyTCgNgcAoLUE1EMaEIcAoK
UE1EMaEIcAoBUE1EMaA8e1NETUEKCABwfVNEVDMKQABETUQxoBR7SUNSMAoIAHJETUQxCgJETUQx
oBB7SUNSMwoIAHAKRURNRDGhFH10e1BNRDEKBwAKAgAKIERNRDGkU0lCMRQGX1BTMAAUBl9QUzMA
FEYER0VUUAGgD5N7aAoJAAoApAz/////oA2Te2gKCQAKCKQLhAN6e2gLAAMACghgentoCwAwAAoM
YaR3Ch50CglyYGEAAAAULEdFVEQEoB9ooAVppAoXoAxqpHd0CgRrAAoPAKR3dAoEawAKHgCkDP//
//8UH0dFVFQBpHcKHnQKCXJ7emgKAgAKAwB7aAoDAAAAABRGBkdFVEYDCFRNUEYKAKANaH1UTVBG
CgFUTVBGoBF7agoCAH1UTVBGCgJUTVBGoA1pfVRNUEYKBFRNUEagEXtqCiAAfVRNUEYKCFRNUEag
EntqCwBAAH1UTVBGChBUTVBGpFRNUEYUP1NFVFADoAmSlWgK8KQKCKEuoCh7aQoCAKAQkJKUaAp4
e2oKAgCkCwEjoBCQkpRoCrR7agoBAKQLASGkCwEQFDtTRVREAaAJkpRoChekCgGgCZKUaAoepAoC
oAmSlGgKLaQKAaAJkpRoCjykCgKgCZKUaApapAoBpAoAFDBTRVRUA6Ame2kKAgCgD5CSlGgKeHtq
CgIApAoLoA+QkpRoCrR7agoBAKQKCaQKBFuCD1NCVVMIX0FEUgwDAB8AW4IPQVVEMAhfQURSDAUA
HwBbghtNT0RNCF9BRFIMBgAfAAhfUFJXEgYCCgUKAw==

--Boundary-00=_Y75698gLitueUQf
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dmesg.txt"

 operation
end_request: I/O error, dev 02:00 (floppy), sector 4
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 6
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 2
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 4
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 6
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 2
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 4
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 6
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 2
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 4
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 6
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 2
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 4
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 6
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 2
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 4
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 6
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 2
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 4
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 6
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 2
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 4
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 6
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 2
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 4
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 6
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 2
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 4
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 6
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 2
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 4
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 6
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 2
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 4
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 6
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 2
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 4
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 6
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 2
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 4
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 6
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 2
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 4
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 6
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 2
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 4
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 6
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 2
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 4
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 6
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 2
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 4
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 6
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 2
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 4
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 6
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 2
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 4
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 6
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 2
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 4
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 6
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 2
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 4
floppy0: disk absent or changed during operation
end_request: I/O error, dev 02:00 (floppy), sector 6
/dev/vmmon: Vmx86_ReleaseVM: unlocked pages: 138224, unlocked dirty pages: 79674
[ACPI Debug] String: =====QUERY_08=====
[ACPI Debug] String: =====QUERY_08=====
[ACPI Debug] String: =====QUERY_08=====
 exstore-0278 [56] Ex_store_object_to_ind: Could not store object to indexed package element
 psparse-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
Method pathname:  \_SB_.PCI0.LPCB.BAT1._BIF (Node c7e91728)
acpi_battery-0134 [45] acpi_battery_get_info : Error evaluating _BIF
 exstore-0278 [45] Ex_store_object_to_ind: Could not store object to indexed package element
 psparse-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
Method pathname:  \_SB_.PCI0.LPCB.BAT1._BIF (Node c7e91728)
acpi_battery-0134 [34] acpi_battery_get_info : Error evaluating _BIF
 exstore-0278 [34] Ex_store_object_to_ind: Could not store object to indexed package element
 psparse-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
Method pathname:  \_SB_.PCI0.LPCB.BAT1._BIF (Node c7e91728)
acpi_battery-0134 [23] acpi_battery_get_info : Error evaluating _BIF
[ACPI Debug] String: =====QUERY_08=====
 exstore-0278 [60] Ex_store_object_to_ind: Could not store object to indexed package element
 psparse-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
Method pathname:  \_SB_.PCI0.LPCB.BAT1._BIF (Node c7e91728)
acpi_battery-0134 [49] acpi_battery_get_info : Error evaluating _BIF
 exstore-0278 [49] Ex_store_object_to_ind: Could not store object to indexed package element
 psparse-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
Method pathname:  \_SB_.PCI0.LPCB.BAT1._BIF (Node c7e91728)
acpi_battery-0134 [38] acpi_battery_get_info : Error evaluating _BIF
 exstore-0278 [38] Ex_store_object_to_ind: Could not store object to indexed package element
 psparse-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
Method pathname:  \_SB_.PCI0.LPCB.BAT1._BIF (Node c7e91728)
acpi_battery-0134 [27] acpi_battery_get_info : Error evaluating _BIF
[ACPI Debug] String: =====QUERY_08=====
 exstore-0278 [63] Ex_store_object_to_ind: Could not store object to indexed package element
 psparse-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
Method pathname:  \_SB_.PCI0.LPCB.BAT1._BIF (Node c7e91728)
acpi_battery-0134 [52] acpi_battery_get_info : Error evaluating _BIF
 exstore-0278 [52] Ex_store_object_to_ind: Could not store object to indexed package element
 psparse-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
Method pathname:  \_SB_.PCI0.LPCB.BAT1._BIF (Node c7e91728)
acpi_battery-0134 [41] acpi_battery_get_info : Error evaluating _BIF
 exstore-0278 [41] Ex_store_object_to_ind: Could not store object to indexed package element
 psparse-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
Method pathname:  \_SB_.PCI0.LPCB.BAT1._BIF (Node c7e91728)
acpi_battery-0134 [30] acpi_battery_get_info : Error evaluating _BIF
[ACPI Debug] String: =====QUERY_08=====
[ACPI Debug] String: =====QUERY_08=====
 exstore-0278 [72] Ex_store_object_to_ind: Could not store object to indexed package element
 psparse-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
Method pathname:  \_SB_.PCI0.LPCB.BAT1._BIF (Node c7e91728)
acpi_battery-0134 [61] acpi_battery_get_info : Error evaluating _BIF
 exstore-0278 [61] Ex_store_object_to_ind: Could not store object to indexed package element
 psparse-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
Method pathname:  \_SB_.PCI0.LPCB.BAT1._BIF (Node c7e91728)
acpi_battery-0134 [50] acpi_battery_get_info : Error evaluating _BIF
 exstore-0278 [50] Ex_store_object_to_ind: Could not store object to indexed package element
 psparse-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
Method pathname:  \_SB_.PCI0.LPCB.BAT1._BIF (Node c7e91728)
acpi_battery-0134 [39] acpi_battery_get_info : Error evaluating _BIF
[ACPI Debug] String: =====QUERY_08=====
 exstore-0278 [76] Ex_store_object_to_ind: Could not store object to indexed package element
 psparse-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
Method pathname:  \_SB_.PCI0.LPCB.BAT1._BIF (Node c7e91728)
acpi_battery-0134 [65] acpi_battery_get_info : Error evaluating _BIF
 exstore-0278 [65] Ex_store_object_to_ind: Could not store object to indexed package element
 psparse-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
Method pathname:  \_SB_.PCI0.LPCB.BAT1._BIF (Node c7e91728)
acpi_battery-0134 [54] acpi_battery_get_info : Error evaluating _BIF
 exstore-0278 [54] Ex_store_object_to_ind: Could not store object to indexed package element
 psparse-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
Method pathname:  \_SB_.PCI0.LPCB.BAT1._BIF (Node c7e91728)
acpi_battery-0134 [43] acpi_battery_get_info : Error evaluating _BIF
[ACPI Debug] String: =====QUERY_08=====
 exstore-0278 [79] Ex_store_object_to_ind: Could not store object to indexed package element
 psparse-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
Method pathname:  \_SB_.PCI0.LPCB.BAT1._BIF (Node c7e91728)
acpi_battery-0134 [68] acpi_battery_get_info : Error evaluating _BIF
 exstore-0278 [68] Ex_store_object_to_ind: Could not store object to indexed package element
 psparse-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
Method pathname:  \_SB_.PCI0.LPCB.BAT1._BIF (Node c7e91728)
acpi_battery-0134 [57] acpi_battery_get_info : Error evaluating _BIF
 exstore-0278 [57] Ex_store_object_to_ind: Could not store object to indexed package element
 psparse-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
Method pathname:  \_SB_.PCI0.LPCB.BAT1._BIF (Node c7e91728)
acpi_battery-0134 [46] acpi_battery_get_info : Error evaluating _BIF

--Boundary-00=_Y75698gLitueUQf--



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
