From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: RE: problem dumping/fixing dsdt
Date: Thu, 26 Sep 2002 09:44:48 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19B7C2@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "'joerg.beyer=htSm2yLGOjU@public.gmane.org'" <joerg.beyer-htSm2yLGOjU@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, =?iso-8859-1?Q?S=E9rgioMonteiroBasto?= <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Yes.


-----Original Message-----
From: joerg.beyer-htSm2yLGOjU@public.gmane.org [mailto:joerg.beyer@email.de]=20
Sent: Thursday, September 26, 2002 12:35 AM
To: 'joerg.beyer-htSm2yLGOjU@public.gmane.org'; Moore, Robert; S=E9rgioMonteiroBasto
Cc: acpi-devel
Subject: Re: RE: [ACPI] problem dumping/fixing dsdt

"Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> schrieb am 25.09.02 23:19:34:
> You need to add a return statement (with a value) at the end of the
method.
> Bob
>=20
...
>     25              Method (_PSS, 0, NotSerialized)
>     26              {
>     27                  Store (MFID, Local0)
>     28                  Store (MVID, Local1)
>     29                  If (LEqual (Local0, 0x0A))
>     30                  {
>     31                      If (LEqual (Local1, 0x0C))
>     32                      {
>     33                          Return (Z000)
>     34                      }
>     35                  }
>     36

...

>    117                  If (LEqual (Local0, 0x02))
>    118                  {
>    119                      If (LEqual (Local1, 0x09))
>    120                      {
>    121                          Return (Z00B)
>    122                      }
>    123                  }
                             Return(0)

will this be correct?

>    124              }
>    125


    TIA
    Joerg


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
