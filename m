From: Jan Slezak <jan.slezak-aRb0bU7PRFPrBKCeMvbIDA@public.gmane.org>
Subject: Re: ACPI DSDT language
Date: Thu, 30 Jan 2003 10:49:20 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E38F520.89609A15@centrum.cz>
References: <B9ECACBD6885D5119ADC00508B68C1EA0D19BA5F@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

That is what I want to know! I suppose such operator exists but I didn't
find it in my DSDT and as I wrote earlier I didn't want to read spec. I
tried DerefOf(), but ... you know... :). So I modified my DSDT in a
different way. But anyway thanks for information.

For me the result is ... my original DSDT is buggy. Am I right?



And what about the case when the buffer is created in the root, for
instance:

     Name (PGET, Buffer (8) {})

     Method (SX33, 2, NotSerialized)
     {
         If (LLess (Arg1, SizeOf (Arg0)))
         {
             CreateByteField (Arg0, Arg1, SX20)
             Store (Something, SX20)
         }
     }
 =

     Method (PNPG, 1, NotSerialized)
     {
         .
         .
         SX33 (PGET, 2)
         Return (PGET)
     }

Is it the same situation?



Jan


"Moore, Robert" p=ED=B9e:
> =

> This is the purpose of the "RefOf()" operator in ASL.
> =

> >From the ACPI spec:
> =

> "The primary purpose of RefOf() is to allow an object to be passed to a=

> method as an argument without the object being evaluated at the time th=
e
> method was loaded."
> =

> Bob
> =

> -----Original Message-----
> From: Jan Slezak [mailto:jan.slezak-aRb0bU7PRFPrBKCeMvbIDA@public.gmane.org]
> Sent: Tuesday, January 28, 2003 2:47 AM
> To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
> Subject: [ACPI] ACPI DSDT language
> =

> Hi,
> =

> I would like to know what way should be buffers handled when are passed=
 as
> arguments to
> ACPI methods. I don't have a time to read the ACPI specs so I hope some=
one
> knows.
> =

> I find out by tracing my /_TZ/TMP method that they are passed by value =
so
> following
> construction (part of my original DSDT slightly modified) doesn't work =
(PNPG
> called)
> because PGET is not modified:
> =

>     Method (SX33, 2, NotSerialized)
>     {
>         If (LLess (Arg1, SizeOf (Arg0)))
>         {
>             CreateByteField (Arg0, Arg1, SX20)
>             Store (Something, SX20)
>         }
>     }
> =

>     Method (PNPG, 1, NotSerialized)
>     {
>         .
>         .
>         Name (PGET, Buffer (8) {})
>         SX33 (PGET, 2)
>         Return (PGET)
>     }
> =

> I need to know it to decide wheter it is my BIOS or the linux ACPI
> implementation what is
> buggy and to decide whether to send my DSDT patch to my notebook
> manufacturer (DELL).
> =

> Thanks,
>   Jan
> =

> P.S.: If it is right behaviour and the BIOS is buggy I don't understand=
 why
> the ACPI
> (actually ACPI battery info) is working under WinXP, where there is no =
DSDT
> override and
> no buggy feature workaround in the biosinfo.inf for my DELL.
> =

> -------------------------------------------------------
> This SF.NET email is sponsored by:
> SourceForge Enterprise Edition + IBM + LinuxWorld =3D Something 2 See!
> http://www.vasoftware.com
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> =

> -------------------------------------------------------
> This SF.NET email is sponsored by:
> SourceForge Enterprise Edition + IBM + LinuxWorld =3D Something 2 See!
> http://www.vasoftware.com
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
