From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: Can't poweroff anymore.
Date: Sat, 06 Mar 2004 15:59:57 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4049E76D.4030000@pca.it>
References: <20040304180301.GA1754@conectiva.com.br> <Pine.LNX.4.58.0403050113230.3779@frog.athome> <Pine.LNX.4.58.0403061054120.1146@frog.athome>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030408090201020004020805"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0403061054120.1146-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------030408090201020004020805
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

I've the same problem on my ASUS M6800N (as reported in the thread called 'ASUS
M6800N: shutdown doesn't power off the machine' and dated 20040217 at 14:37).

on 03/06/04 10:58, liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
> Salut List,
> I have good feedback from Flavio, that my patch works for him too.
> As I do not understand what my patch does, may someone with more knowledge
> comment on it.
>
> Thanks hartwig
>
> On Fri, 5 Mar 2004 hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
>
>>>Salut Flavio,
>>>ok. we are changed to
>>>http://bugme.osdl.org/show_bug.cgi?id=2109 by Len.
>>>
>>>I tested the patch with 2.4.25 and 2.4.26-pre1. I just had a quick look at
>>>2.6.3. There the patch applys cleanly, but I did not check, if it
>>>compiles, and fix the regression for 2.6.
? are you sure it applys cleanly on 2.6.3? This isn't the case for me:

=====
- - (2.6.3 + ACPI 20040220 + ACPI DSDT in initrd + Bruno's _CST)
gismo:/usr/src/linux-2.6.3-acpi.initrd-processor.cst-hwsleepc2# patch -p1 <
../kernel/v2.6/hwsleep.c2-patch
patching file drivers/acpi/hardware/hwsleep.c
Hunk #1 FAILED at 249.
1 out of 1 hunk FAILED -- saving rejects to file drivers/acpi/hardware/hwsleep.c.rej
gismo:/usr/src/linux-2.6.3-acpi.initrd-processor.cst-hwsleepc2#

- - (2.6.3 w/o any patches)
gismo:/usr/src/linux-2.6.3# patch -p1 < ../kernel/v2.6/hwsleep.c2-patch
patching file drivers/acpi/hardware/hwsleep.c
Hunk #1 FAILED at 249.
1 out of 1 hunk FAILED -- saving rejects to file drivers/acpi/hardware/hwsleep.c.rej
gismo:/usr/src/linux-2.6.3#

- - (2.6.2 w/o any patches)
gismo:/usr/src/linux-2.6.2# patch -p1 < ../kernel/v2.6/hwsleep.c2-patch
patching file drivers/acpi/hardware/hwsleep.c
Hunk #1 FAILED at 249.
1 out of 1 hunk FAILED -- saving rejects to file drivers/acpi/hardware/hwsleep.c.rej
gismo:/usr/src/linux-2.6.2#

- - (2.6.1 w/o any patches)
gismo:/usr/src/linux-2.6.1# patch -p1 < ../kernel/v2.6/hwsleep.c2-patch
patching file drivers/acpi/hardware/hwsleep.c
Hunk #1 FAILED at 249.
1 out of 1 hunk FAILED -- saving rejects to file drivers/acpi/hardware/hwsleep.c.rej
gismo:/usr/src/linux-2.6.1#
=====

BTW, shutdown doesn't work on 2.6.1 (w/o any patches), not on 2.6.2 (w/o any
patches) and 2.6.3 or 2.6.4. I attached my .config in order to know if I should
enable/disable something other.

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFASedrVAp7Xm10JmkRAihcAKCGRtGdSVkgMQ54rgSR14VRfKwvhgCfe93j
H15gfAcD10UXuhqbvf2vM/4=
=KOmI
-----END PGP SIGNATURE-----

--------------030408090201020004020805
Content-Type: application/x-gzip;
 name="config-2.6.3.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config-2.6.3.gz"

H4sICDvRSEAAA2NvbmZpZy0yLjYuMwCMXElz4ziyvvevYEwfXlVEVdtaLMsTUQcIBCW0SAIm
SC19Yagslq1XsujR0l3+95MAF3EB6DnUwswPeyI3APr9t98tdDmnr5vz7mmz379bz8khOW7O
ydZ63fxMrKf08GP3/G9rmx7+72wl2935t99/w8x36DRejUff3osPz4uuHxG1exXelPgkoDim
AsW2h4ABlfxu4XSbQCvny3F3frf2yd/J3krfzrv0cLo2QlYcynrED5ELBaFURscuQX6Mmcep
S6zdyTqkZ+uUnK8IESLfRi7za+ycOQnYnPjXLmbfMfNj4fGig1M1F3tZ7vJ27ZJYIn4tKdZi
QTmu9m0i7JgHDBMhYoRxqGkfSuHQvdbiMigWObGYUSf81hsWdDrP/nNFFhTVQrVV4k2IbRNb
09ocua5Ye+JaixOFZHX9JJy5ld5QJvCM2LHPGG9TkWjTbIJsl/qktkQ4ZjykHv2LxA4LYgH/
qXZOzbGbbrab73sQhHR7gX9Ol7e39FiRMo/ZkUsqTWaEOPJdhuxqezkDmsIFWzMXbCKYS0Ii
4RwFXq3iBQkEZX6ltTlQC3ngx/QpOZ3So3V+f0uszWFr/Uik/Can2q6I6+IgKQu2RlMSaAVV
8v3IQ49Grog8j4ZG9oROQWqN7AUVS2Hk5psTBXhmxBBxf3t7q2V7g/FIzxiaGHcdjFBgI8/z
Vpr19EZKDV2RHHQFjTxK9RWV7G7+UM+dG7o+vzfQx3o6cZGv5+AgEkyv0bwl9fEMlI2hEzm7
38kd2IZ21wFdGWdlQREexPqaK1KkWR/JxR5f4VlFiUniCtl2neL2YoxAneRa8K7gBUtBvFjW
AEVi5E5ZQMOZVy/MQR/GDvExqdOXPF6yYC5iNq8zqL9weaNPk7puV/UyjuxW4Slj0BNOcZ0c
CZJ1BEaB57Btr+wZJ2EM2pAEDRrxIheBPgrCmtZo7OhS6RPi8bDRKtd1hYNybpNdhpGrgVOm
IcJurBM8TJqaDUhgJ3wHgYE2iocE8WE4I4FnQIUMFn2CtDw6nuulkmKwgczW7xbVrjCrXMzB
TdFywYxqpt5nMzqdecSrzkBOGk61FeXckYHtoXCWLz8YHZ1uC4OgZuIdqkHN0IKAAcZybeel
rUr/SY7gXR02z8lrcjgXnpX1CWFOv1iIe5+vRotXBFUwJ1yiAHZhJEAZVvYo92KbinmLEIMd
Dakcw7d/3WyTv29etpvRv7J+yNagze3fm8MTOJVY+ZMX8DChM8qCZh2lh3Ny/LF5Sj5boukB
yCqubcqveMJY2CBRPyQBbI+wusEUR7iEcB1NuVCxIxo8hL+91ltDIdS6blKjMIQR14kOalJy
R5AFDXq+GRpUBJMOpHLFM2h7b1TZNplE0+YERc1REdwgcLZsTRXHzZkGRzUkXmuuaRiUbhGI
UmWFs/X0SsH7bE3ASays6nVsUK7pDsKmtJxj8p9Lcnh6t04Qk+wOz1dRAHbsBOSx5mbmtGw1
QQwczUSVIJs4KHJDUOCLGCILcBY95Ne1mhYLmj0QHGFdMFEWaFeqRciJF7BpDfyyKW2n+kOp
qLt6EaKJS8ogi0dyPq230nfdHnd/J8dTdSWkOlQLK9FQhVFnqq77bBkb/KA6Ru8T1TF6/0iZ
2JXSQOB/G7wK0E7EBunkMQafLaA+a9qmK4J2eLdXlPD07o/q8hBiTlCwjf7UMBBsToNI79gV
/BmIVEvsJ5fTVUHDJvxicexhir5YBILmL5aH4S/4X1Vlq61aVg+fIDxqq+laz9g2DYg2HM3Y
yF9XdDuQZHV1SlZDs2Hp9iyAzgJD3S6ZIrwuQtYKw0deNbaDIdbsHXwbvFU9XeBf/XqgUthI
FnJXacnMOqrZvcGb41ZOfSvozPjXfq1l/qGyXVFgZxq24qP0bx/0/jGwBqM7vdeDtT5z1ryc
rgm5dplas/T8tr88t01kPrymUFTIYJnmej+pCpL5FEMcWoXRiWeeY4VQNvvV0IgcSnMHkF/J
0+WsMgE/dvKv9Pi6OVfi6gn1HQ+8ZdepZG0yGmJR2CJ6VDmvqnI7+Xv3lFh2qfmu6Z3dU062
WDP15CxjmUMg0nKrAl7ymh7frTB5ejmk+/T5Pa8Y9qwX2p+rGhW+W0Pkm+Nmv0/2llw7jcyh
gLOgMpCckGUTWjQIqtxebSPmLLAe1OBkV0o71GEfYUQkc28fwjJp7UQx6e10Inr98bA9Y1LY
lZO437xrZszntQnweeYLtes5puf0Kd1XFhc0S1b8WjjXdtX6JKnwEttKe58+/bS2mQhUBNWd
QzcWsVNLThXUld56wDRQQxwjS2IO3oh+igs2pkJ0YWTjNsIPI30ep4BEEK/o8qU5280ygq1i
OFjzkEluR2F/UgkmCmKAPC1RpQu/DW8fRk1m6X2WvXAn7d0G8egN/OH0xnO8m8B12/IDM95u
OiPm4pdsTglUCaojfbpIb1bFLTe7bfLH+ddZKinrJdm/3ewOP1ILAhq5hsq/qrlXRdUzO24s
crvteoCVE2KIEUMqE5Q1n7DgilBmrzuXFaBYdLeMtfIKDJjEDyt3XMb5ursBgQVtdB98Veg/
ZTjUK6wC4lCXxHVNpCZYTufTy+4NCMXy3ny/PP/Y/aruSFlLnqDSyq5nj4bduwJqAG3QPbxa
7JR9x2ImA2kaPOraZY4zYeBJdLasSay1K+IhHfV7nZjgr96t1jOqyp6Hmh5Eg6ty6zp//Fo6
RlHImlIKLOa7aymtHV1A2eFQq3FE8Ki/WnWOD7m0d7cadGM8+374QT1KGLohEGo4LvmgmvW4
j0cP3f3B4u6u3y14EjLohsx4OPigxxIy0kdsBUTgnt5zLgCc0pVucXwxvh/29O5tWdbG/VtY
wZi53dJeAn2y7O7uYjnXRzolglIPTbsVl6Awvb3uRRIufrglH8xeGHj9h+5lWlAEIrEyiJ9U
UTI7L0j4gZpu7JF8d9HFxLwrmztS0nzmN9xwjblq6VupwnOPp21Oc/1e+aok2K7F83LZGdqn
7e7084t13rwlXyxsfw1YNS1ZrkHNNOFZkFH1J2IFmwmhC3XLOoO27RcBhLG+zSqssrEydhTp
a1KdCPD+kz+e/4DeW/9/+Zl8T399Lsf4etmfd28QzriRX3MJ1OxkVt2NdKlfBQiI8o0BUXNM
FQ/+L0+4Q/0uUBCXTafUb7vDqvP79J+v2Zm7JiFUTMhgGYPErsAfM6TKVTvycNBBwrAeCoKw
ydBl7Bnq3fX1W+MKGOrj6wyAcHcnEcX3pt1XBRh1VAl66KrF5mFM+/qYKavBXiBfrDuWjfp9
02lrJjZkirrHKsDxNXMnkQDJMPgUmWzxRwd3SZbtrQa9h15HF+wQD/rjjlGQzj5KLpicjnl0
ojAC38pmHqL6jJuCTe1Qn/nLuPnNFB8Hd4Ou3jaAsed19Q30eNfyyqOSTj7qda0/5x0TRz3P
zFS9x8PbUUcFYu0BZgwboWO3cSR6eouYsTHtFmEJ6Pdv9fYnQwjaH3YBHpUMx6B3PsRQob8c
UaunYzvkkF5DnusQBG7LqqWlJb3XpS8kwOTbloBB11wqQL9jsQAwGvQ+AnTVIAiaotBwzeoq
NMMumbDx4OHuVzf/tsOChDD9Zm7UG8aDodMBcMMAiUaGurE7BB/0TQtcHLJV0seZHd1sN2/n
5FhxhyqpcZXG7TJuOcTpUGM5xKf+n0j1pQv12NLsqkNsv829q8LaW58kQFb3RUHBVawlMLG8
/VVE7a36POnXfK07gtYnZZRkus5dePVsaNuTdC4neQLs8bDtT5blnEg0DsazqJ8QYvUGD0Pr
k7M7Jkv4c3W5PlVvDFZ8SVlIlimSueLy/fR+OievlcTv1avOweAOBhMmSCut2EayCIRk0upr
K/XcLgnK0F37urtN18pnmFY7XyQ0K/W2eg5rx/IyTZ6Y8H41O19jxHy2FjJG6B4vCWdqCTp6
bS8M7QdoSZm2A7h+6yVbbnCnzDLScLYy8dw87Q7n9PRSlNvWM/9+cv4nPf7cHZ7bUYxPwmKb
V2Cte6kc4TmpH4QpCngGSG9toGKX+sqv1kxa5NfDa0DHc6LLqNGsh8UXz8IIDMqtFhfyzNPE
xI4DFoWG9DvAGomtWg8op13MaaC3CbJTqlEtFwVc7zjKkcUEG7y5tbzuy+aU6A2+Koz0vl5W
scELoNlY5NGXYTALvVmzoatEb7EmAbUNuQco4lC3sR55WBbyxgUZozKDPsUSH8eNRVeVaGc9
1DuGCxf58fi233vUyJrr1jKm8Gk44uQ69SWvhM1riQeZhOPcJZKhrWjV12eSXMQnRkG0Kahp
/UIQ+NewRksYd8fOkBWDcxma5VgiZsvYcdkSKABsn+s/pkIaxJv0aP3Y7I7Wfy7JJclutNSq
UZeoW6Vz/WOdk9NZU4jPQwhLNPMOTJhpikmZeEEBPiTnyllVZTMahdiOPG+tF2/m243EwnXG
HyPk0r+I7ipAGPlVra9GPmnmpbPj4PNLcpRd/tS7tWD2AOR9350/N+eAyIPFxgBaFUD9rcII
E98QAttuXy+cpNnVa1fEeDA2pHJnyEN4pvfa1sQF6XEMnl8w7o0e9MqQip4h3yjmD2PXUGFI
p8wf6CVGPoFANmjBQmbqM6iZQrqa6vekY9v64c4o5wb31aXa666cVwUGPjNrJw2pvh5AtNVr
hYnAjlTu90mSpMRhuK5T5ZkWxDx14kTIGWr2yXBdWzTGpOZOOqv75HSy5AVw8MEPX182r8fN
dpd+rvkg4CPZlBVrwb6f0n1yTq7FnzbH7enq9L4dk6+gxP/o9WpLBOrLYMBRYLqBvkQL4+30
PMr4HyAwBIkyjz/rbeWy3yx9e5OuVm1kmnAqQGvcPoxv1Ptd3pa6kRluY3WIBvosjLyYaXAy
wIiStpZvtc2fXp92G3W96Pvl1N2FGJtubGVT7Q7ubnuGLbukAXGJKNV8mP5MDlYgZ1Gj6sMO
Q6fXhEHzqs5VsGaIa1yY5eZg7YqrvLXGl6gdx+Vh9CE3c6ZzBWXrigtZzfkZ4LuxXkdeAff6
xxxF7O0t/uyNO8NzbrSRhbR7+IP9IDz80MOGG2I5ZkUD3DekDotcwkpn7NDr5pxcjlYg9YhO
0MAGKX3Sjq2ONrI+7Q4/jptjsv2suSMR2KiIOhX4TXOXRuqSSpgnDXL1E1SmV4v2oM4sIaPv
TyvYUgWypyEuuGSxK6qvNBRXumpxEDSotawNzUf5ValMfWQoaNDmVDoOZiKWmFaYnx6ea6/X
yrTLRzVmd7Y0VarCyXG32cvXl5ranc6aIzFRc6BTHULe/wqqS7KkvnTqJFnvOWRX0I18EG+5
0NgIAJ/QyFu4ooNJW63mt68uyTlNzy86eZ+09wgVtg/QPOlTWwPgyBcFbcUeglp/e0kP77rr
63zWeFqaC9nb5WxUZdTnUZleiE7JcS/TZTWNWUXGHotk8mlREesaPeYCRSsjV+CAED9efevd
9ofdmPW3+9G4DvmTrWXT1Y2r6KHQpzAyLlloC5GF7mJeNlv0hukkeIo8df6pS8myCIS1AFQO
neV9xcZnTMe3w36TCH/nRa8yrBg4HPfxfc/gXCsIR8F8Yjj7ygCYctE3jLaVEazN05ys1aWg
ygvUnALOx3xSOwgvOSLyTR0qMavwQ4hPlqH2HVJFZKrPZdVrN9Gvv8GVxI4rqBkAKmSGiD0D
yDT2RJ+wyNvFvd4t177wLaVXhBRXLtMVlJiqa0xXC9VgSNVZHVOT3R/orXiJW6IApECvzkqQ
vJzimpyGEqXegbBAH2fVURPk6qf8CgshaDekO0pQuKS27X6Esid6p6sEyL2J2QejC6NgwqYB
cgyXYko1FJlyc5lCYhGeZXrMLLy0+pYxo3Es+Dxo66pI/dPavvhlc9w8ybOe1p3fRUUHLUJ1
N4O5lb0yW7Zp2SaRF3GyXyqoX2mVYWYUNizM1TFnMtds3EN4De6obYhhbDqlhBseUEimPvch
eOeuXiH1As91DUfbCiE8+VBQD6CGgy0ZnRvD/YKpfSvrxzPbxdXlDUAImGc4RuQEHGyXGo5i
9WTT7XhYUdcOFi0RKvy5pu7PZWHcv7ttCYgkVqSnZmpKtuEQvAJRDzE1lrQC8YM4ggUS34b6
KsgqJL6tS1Smh68SARQ1Pv0Dh7wqzIL2LpDE9haRhyIP45iHa6EjQoHID7/178or4jxQz0Br
OWte1GtIGDWcmUqyDOx8a6gebPyapxkJZZC0VTxSfNuPm/enM1+Ae7TmhMI3hGl+U/XmYfX5
6WWbPlsyo9AIq0M8s5nh+fEyDqBGprej/iJAuqv+jXfodmhI1QeDh5E+sJYpfooNzQrmr3n7
RNnJrgCeXxLrxz59e3tXdwLr8U3taLg5q0Xb01p2Dj5l6KEHgkdFW2BP7yTlPNOIgavUn5Hr
L6hteCQj2YIaEk6Sp36/wMheUF2MZwe1d+rwGYe2wc5KJthrw4mv5AaNyxdVFhgaVkvrS6o3
NVfWGGs1FfSkMbEtZW/Sdl4z4XgVVbSEluUpkSFD70/VDzZkv8/Q3qt9rAnl+rVtAp8xnoER
J22tL8uj/XN63J1fXk+1KtSvWUxo2KxKkjl2tFXNQAn8szkmVv3pYqM87d0N9GdpJd9wXV7x
Pfv+Tn/smbPHvZ7+xYHkE5fMTXdtMr5e50oehGvmiunYEJkppuG1qOT5ync3nF4Cn8+oC0Fb
Q+XXIdlTtY/4sUunsw4UpSu9ElHcgAm0MN1bl4iMra8he/4Kpl4fL6ji8sr7g1kwgD8yPDjI
2Q8jg7cO7AU4gMQzBDUKYNCBOY8bUvKKzZjN2KB7S4jkcEqPJ/DVd2+mvSEIuAOGNJZiCfkS
pXdreFFTYtTRZSeEEB6YzGAOceTRb3dnpu5dbyy6q6HhWP/avgC43r1+0SsAg2NcAsZ6fVEB
fNSE6cwyB4AEjMamy6k5Zjke3I9NN4+vGPd+fKd9SiElQKWFG47olV777YwKfEbLX4ZT999e
k+1uo4kF5cWrOEuCKfBit01Sy0mPlrs7XH4V6duMjLLrgzVDl9UwCcdD/YpkfO7pzWBeevmI
keHGhwLgj/jcsFUztkDorj/UJwHCyCdBPLgd6A1IXkEoTyS6hvAXCwyaJOcHg1HPcOhedvK+
N9DrygzhrfSqMl9Erj8Xy7gzsqKRF7OAGvIcNdiUeNTXh7j5hK/G45Zyy050dEKiznNiDN6X
3tZk/ABmGRv89wpAbxczBPorJIZfz8gAMLKQdLWRAWLTWWIG8tCKts6oWhgiL+R0IITTGzmG
X/HIEBAeBghG1AUJIsNblpy/5rP/NnYsu43jsPt+RTG3PSxm+kjHPczBz8SNX2PZSdtL4E2D
TLCduEhSYPv3Q0pxbElk2kMLRCQlS6Qsii/nDM8VxlOeVKVuSlBuos16c4ALstr73q5tnpeN
DO7pSgkMWRzM7HjS8a55/bVZEjUrIs1oGXkLPy5hIuRTArRIaaYj4aMXlmwAPyDEqajoBQLg
bOwyceAIDAV1WzluV1Ab9eIiQDFhbhIAAo2ehaUuCAqtqCClvLSYqT4mvD8FehKl9lvNnaNx
OIhbPXIx6wrKgbjLIICyME9dLncH4NNHZnsA7Jq7/yFfpHJFKzwArrA6QcayvEhpzQA7jsuq
dm3Xmt9uMaTl4nmzf8XiDuqGb0s1SBNl/EoDlzLrdBsHI9dsc1JUuinwKYrgdLKAqvyJNVCU
Z6Qage0L539n0LtqkYVv5RSTdt0eC+ge4zmHmzvJx7Y7XrRv2+eBxQzdXJ0acaqwJbUIhXrh
7pa/NofVEouQanflzLbS5a+r7ZFMWE5Q5VErMNbUIqyFZzNGOUn6H7qvPd3sl6uXl2a7auGS
ih1YTn1FM4v9MNKyG7Hdc7NgHnOpW5LyMXPT2F/AoQoaH/nIk3Z/QDk77NqXF5Aty+OG/YQT
4PvED4YGDGzPj+0E6xFc92Sn8Y6OPf+l2e85j7xbcyecnHZSh1WeVxMMR2Ox0pgJr5MD+JRN
DyGdbfT3sBEzYuA6ac7+2GyXU6Gx3MqNXFqRGuJFZRhyZsEhXiyCK+bw0YYt/I/7mhQO9LX6
EE8EQfmNVmdNtBF9yxmi3ddpISa57UOScvn2u9n2FQ/7IkKTOPhbl05o0fkFDV0MQW++ioNF
RBW9OxKo+IF++Di48FrAPCWRMLLK+YulDLI2bymEccFphAieu+ekYOpVZ2RJVo5LuWQ0xHgw
vMKnice/mzUTGienFPjOGamTxUbPzWpSwH8yWwoHJ2+M+hvN9RCR6x5elMx9TRILjzYiyDAg
Lz1HO80z6HtO6xTyXTgbMbY+yZEzlCK8IYMX1V6Z3TrfzDfP/O7u1iEMn7g0XTy8TLlrbYH1
3Yp/lKk7D8+cJ2WVOJcjnv3wR0Xe4WOpcDJ6D9VCfL+yw9uR7OgLhAMKCJkMQrWGptu1Fyrt
lGUeAe6dt7Sqf4Re0do6Qqt4TLs01FkWlmLuMunyclHjfHRmSyXhOK9wP/MHYpnMuIgF2YPP
D56EPKwKBc3LcfO8Xh2ocC8kG7vBmBCCCAvWqbgy7csF1dVCV22OTYsHt6qoAHWAX2v1aI8N
isDoSQKKXMQPcOjTXOqwROjXZVxR2WT3w5pc8MOsJgvUqSdDL4fDl2EMYhkJoyzaCX7Pgx54
EBpIHgxgN2CeSrrhQ/ysc6aEABY8sYbRYDeDqiQqMfZrMAskJy1GxiK/u739pjHmPk9iPf3v
CdDIAesgGgwW5OJr5FZf4TJFDgYwbaBUAIXWMjNRsspaGtnEK28SXM4tQS72q7fnVhZgtB7M
qpUsG6a6ERVUjUh/WtWSSke90WhIGjQWlTmRU6O9Z3pzY1owAjWpYbsm3nnoojDcLZ3IuWnP
Nv1Nqy9QL3YBL9tuxAnkxOKeF/L9eDzIpjoC/G4qvcXxzC6cFDzsZ/Zww0PxUygcrLbI/hqm
uMlXqDBlLrMFG1pmtLFBgmhbL4JU5Vr98tWDA2OQ4MwowaLyqXgjrA4cDN/d6A0c7gVRZ6X+
aRDVshgLim0i9bSthL+zRHRlqW1AGaagof74stm3jjO6++dy9KUfyo8ZzmR+wTHNzzGynsu3
rTBP5ukp50WeZHnR7A4bmd1avb/qavCpjvwpd5lYFvVG7EvOd8nazQHUn4uk2a7fmvXKrpEL
KzR4Zw7WUVuvARy/LIDvhsXN9XdNPIaw79e0301H0n1vFIojI79ocmdE628GEn0tNZA+8bQO
UyLUQKJvBAbSZx78ltlpOhKzs3WkzywBU8rNQKJNARrSHePf0pGYO4XR0yfW6Y7xtukPzuQ6
IRIoKCjmC9okrXVzefWZxwYsMjNtMNalKdQdgJ9wh8FLRYfx8VR5eegweBZ2GPyO6TB4vpyW
4ePJXFKlNDSEkbmW0zx2FkxSXweumV7rKnJ+9N+1Ao1Gr4bRv5PLPMJ8Wzt5Y4rpwS8Xv5rl
f0Z2unKYTzEzm76YKARRxBkemuprHCSiNNnDLUeeNsRUsKp+FGcBfi5nodr6l7z8AkwBJ4U4
lfQVq6X63FxrF32hbkkKvnt/PbRr5XmjKFX1Y4su2fy7a3bvF7v27bDZDmME/NK/vuote09J
7MGBqhKO37VWKw1ZffArx9Ne/wqK1Cz+AAZW0SPRbwAA
--------------030408090201020004020805--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
