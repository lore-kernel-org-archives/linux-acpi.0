From: "Darren Benham" <dbenham-FG1iuTdj8bisTnJN9+BGXg@public.gmane.org>
Subject: Re: Thermal module errors
Date: Fri, 7 Feb 2003 13:36:17 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <64546.64.164.111.5.1044653777.squirrel@benham.net>
References: <32774.192.168.10.204.1044602945.squirrel@benham.net>                                                        
        <3E4398A4.6040907@alvie.com>
        <64330.64.164.111.5.1044640843.squirrel@benham.net>
        <3E440425.1080006@alvie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3E440425.1080006-JkNoWtNHh5AAvxtiuMwx3w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: alvieboy-JkNoWtNHh5AAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Ok, I played with it and I'm down to 4 errors and 2 warnings when compiling.

The warnings:  two _OFF routines have "not all control paths return a
value" but since they're warnings, I'm ignoring them.
The errors:

There is one reference to \C001 the string "C001" occurs only on this line
and it's referenced like (I think) a value store: If (LEqual (\C001,
0x00))
The are 3 references to \_PR.C000.  These three lines are the only places
_PR is referenced at all.  Not even a scope statement for _PR. Of the
three references, two are notify statments:  Notify (\_PR.C000, 0x80) and
one is a Package statement nested inside of a Name statement.
 Name (_PSL, Package (0x01)
            {
                \_PR.C000
            })


Mean anything?

Alvaro Lopes said:
> Darren Benham wrote:
>
>>I had a feeling it was going to come to that.  I had already
>>disassembled the DSDT but it doesn't mean anything to me.
>>
> Well, to me it means just a little bit more :)
>
> Lets see, here's the cause of one of the errors:
>
> dsdt-darren.dsl  5892:                 Store (C11A (0x1F, 0x00, 0x00,
> 0x00), Local0)
> Error    1029 -   Called method returns no value ^
>
> OK, let's look at method C11A (in namespace _TZ_):
>
>        Method (C11A, 4, Serialized)
>        {
>            \_SB.C03E.C053.C0D1.C11A (Arg0, Arg1, Arg2, Arg3)
>        }
>
> And \_SB.C03E.C053.C0D1.C11A looks like it does return a value:
>
>                    Method (C11A, 4, NotSerialized)
>                    {
>                        Acquire (C10B, 0xFFFF)
>                        Acquire (\_GL, 0xFFFF)
>                        [snip]
>                        Release (\_GL)
>                        Release (C10B)
>                        Return (Local7)
>                    }
>
> Ok, here's the bug. This method calls another and discards its value.
> So, it should be like this:
>
>        Method (C11A, 4, Serialized)
>        {
>           Return (  \_SB.C03E.C053.C0D1.C11A (Arg0, Arg1, Arg2, Arg3) )
>        }
>
> I am not able to compile your DSDT. Can you please try to compile it
> yourself ?
>
> ASL Input:  dsdt-darren.dsl - 6545 lines, 222603 bytes, 3917 keywords
> Compilation complete. 39 Errors, 2 Warnings, 0 Remarks, 1109
> Optimizations
>
> Álvaro
>
>>Alvaro Lopes said:
>>
>>
>>>There's a problem with your DSDT. Can you sent it to this list ? I
>>>believe there's already a DSTD patch for your compaq or a similar one.
>>>
>>>Install the Intel iasl package (you can find it at
>>>http://www.intel.com/technology/iapc/acpi/downloads.htm )  and do a
>>>'iasl -d /proc/acpi/dsdt'. Send here the results, please.
>>>
>>>Álvaro
>>>
>>>--
>>>
>>>Álvaro Lopes
>>>---------------------
>>>A .sig is just a .sig
>>>
>>>
>>
>>
>>
>>
>
> --
>
> Álvaro Lopes
> ---------------------
> A .sig is just a .sig


-- 
Darren




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
