From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: 2 bugs in ACPI
Date: Fri, 21 Feb 2003 14:06:19 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19BB05@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "'cijoml-VIXq6x/3rUk@public.gmane.org'" <cijoml-VIXq6x/3rUk@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Try these changes to your DSDT:


    Method (SX43, 2, NotSerialized)
    {
        If (LLess (Arg1, SizeOf (Arg0)))
        {
            CreateByteField (DeRefOf (Arg0), Arg1, SX20)
            Store (SX40 (), SX20)
        }
    }

    Method (SX45, 0, NotSerialized)
    {
        Store (SX40 (), Local0)
        Name (SX23, Buffer (Local0) {})
        SX44 (RefOf (SX23), Local0)
        Return (SX23)
    }

The changes are the addition of "RefOf" and "DeRefOf" operators.  Arguments
are passed by value unless these operators are explicitly used.

Bob
-----Original Message-----
From: Michal Semler [mailto:cijoml-VIXq6x/3rUk@public.gmane.org] 
Sent: Thursday, February 20, 2003 8:13 AM
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [ACPI] 2 bugs in ACPI

Hello, 

I use ACPI on my notebook Dell Latitude CPxJ 650 GT for a very long time.

All the time things goes well - thanks you people, but from November 2002 
there are two bugs:

1) Now ACPI can't read battery information from my batteries: those are SONY
2) Now kernel can't read info about thermal zone - kernel tells me -296 C -
I 
thought, that apsoluttly zero is -273 :)) You guys are really good :)

Both thinks worked in ACPI 18112002 or 22112002 now I don't know




-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
