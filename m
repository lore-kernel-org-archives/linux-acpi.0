From: Alvaro Lopes <alvieboy-JkNoWtNHh5AAvxtiuMwx3w@public.gmane.org>
Subject: Re: Thermal module errors
Date: Fri, 07 Feb 2003 19:08:21 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E440425.1080006@alvie.com>
References: <32774.192.168.10.204.1044602945.squirrel@benham.net>        <3E4398A4.6040907@alvie.com> <64330.64.164.111.5.1044640843.squirrel@benham.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <64330.64.164.111.5.1044640843.squirrel-FG1iuTdj8bisTnJN9+BGXg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Darren Benham <dbenham-FG1iuTdj8bisTnJN9+BGXg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Darren Benham wrote:

>I had a feeling it was going to come to that.  I had already disassemble=
d
>the DSDT but it doesn't mean anything to me.
>
Well, to me it means just a little bit more :)

Lets see, here's the cause of one of the errors:

dsdt-darren.dsl  5892:                 Store (C11A (0x1F, 0x00, 0x00,=20
0x00), Local0)
Error    1029 -   Called method returns no value ^

OK, let's look at method C11A (in namespace _TZ_):

        Method (C11A, 4, Serialized)
        {
            \_SB.C03E.C053.C0D1.C11A (Arg0, Arg1, Arg2, Arg3)
        }

And \_SB.C03E.C053.C0D1.C11A looks like it does return a value:

                    Method (C11A, 4, NotSerialized)
                    {
                        Acquire (C10B, 0xFFFF)
                        Acquire (\_GL, 0xFFFF)
                        [snip]
                        Release (\_GL)
                        Release (C10B)
                        Return (Local7)
                    }

Ok, here's the bug. This method calls another and discards its value.=20
So, it should be like this:

        Method (C11A, 4, Serialized)
        {
           Return (  \_SB.C03E.C053.C0D1.C11A (Arg0, Arg1, Arg2, Arg3) )
        }

I am not able to compile your DSDT. Can you please try to compile it=20
yourself ?

ASL Input:  dsdt-darren.dsl - 6545 lines, 222603 bytes, 3917 keywords
Compilation complete. 39 Errors, 2 Warnings, 0 Remarks, 1109 Optimization=
s

=C1lvaro

>Alvaro Lopes said:
> =20
>
>>There's a problem with your DSDT. Can you sent it to this list ? I
>>believe there's already a DSTD patch for your compaq or a similar one.
>>
>>Install the Intel iasl package (you can find it at
>>http://www.intel.com/technology/iapc/acpi/downloads.htm )  and do a
>>'iasl -d /proc/acpi/dsdt'. Send here the results, please.
>>
>>=C1lvaro
>>
>>--
>>
>>=C1lvaro Lopes
>>---------------------
>>A .sig is just a .sig
>>   =20
>>
>
>
> =20
>

--=20

=C1lvaro Lopes=20
---------------------
A .sig is just a .sig




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
