From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: problem dumping/fixing dsdt
Date: Wed, 25 Sep 2002 14:11:30 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19B7B9@orsmsx107.jf.intel.com>
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
To: "'joerg.beyer=htSm2yLGOjU@public.gmane.org'" <joerg.beyer-htSm2yLGOjU@public.gmane.org>, =?iso-8859-1?Q?S=E9rgioMonteiroBasto?= <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


You need to add a return statement (with a value) at the end of the =
method.
Bob


-----Original Message-----
From: joerg.beyer-htSm2yLGOjU@public.gmane.org [mailto:joerg.beyer@email.de]=20
Sent: Wednesday, September 25, 2002 12:48 PM
To: S=E9rgioMonteiroBasto
Cc: acpi-devel
Subject: Re: [ACPI] problem dumping/fixing dsdt

On Tue, Sep 24, 2002 at 03:32:02AM -0400, S=E9rgio Monteiro Basto =
wrote:

First of all: Thanks a lot!

I did as you suggested and it works great - with a single exception.
Thinks work, that never did before:
- I could adjust the brightness of the display
- I now have events when the power cord is plugged in/out

What I miss (and what worked before) is the state of the battery (yes, =
it
is compiled in the kernel). The whole /proc/acpi/battery directory
is missing. I asume that this is connected to the two warnings I go
while I compiled the dsdt.dsl, is this right?

> I had the same problem with acpidump
> you can use pmtools from intel acpi site
>
>
http://developer.intel.com/technology/iapc/acpi/downloads/pmtools-200107=
30.t
ar.gz
> and get last (binary) iasl from same location .
>
> tar xzvf pmtools-20010730.tar.gz
> cd pmtools-20010730
> make
> cd acpidmp
> ./acpidmp DSDT > dsdt           (as root!)
> ./iasl  -d dsdt
> correct dsdt.dsl
> ./iasl -tc -i dsdt.dsl
Here I got 2 warnings:

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20020829 [Aug 29 =
2002]
Copyright (C) 2000 - 2002 Intel Corporation
Supports ACPI Specification Revision 2.0a

dsdt.dsl    25:             Method (_PSS, 0, NotSerialized)
Warning  2019 -                        ^ Mixed return types in method =
(_PSS)

dsdt.dsl    25:             Method (_PSS, 0, NotSerialized)
Warning  2026 -                        ^ Reserved method must return a =
value
(_PSS)

ASL Input:  dsdt.dsl - 3171 lines, 105560 bytes, 1489 keywords
AML Output: DSDT.aml - 14049 bytes 420 named objects 1069 executable =
opcodes

Compilation complete. 0 Errors, 2 Warnings, 0 Remarks, 335 =
Optimizations

My dsdt.dsl is 3170 lines long, here is, what seems to be the relevant =
part
(dsdt.dsl    25:... means: file "dsdt.dsl", line 25, right?)
I added line numbers for reference

     1  /*
     2   * Intel ACPI Component Architecture
     3   * AML Disassembler version 20020829
     4   *
     5   * Disassembly of dsdt, Wed Sep 25 20:33:14 2002
     6   */
     7  DefinitionBlock ("DSDT.aml", "DSDT", 1, "VIA  ", "PTL_ACPI",
100925440)
     8  {
     9      Scope (\_PR)
    10      {
    11          Processor (CPU0, 0x01, 0x00008010, 0x06)
    12          {
    13              Name (_PCT, Package (0x02)
    14              {
    15                  ResourceTemplate ()
    16                  {
    17                      Register (FFixedHW, 0x00, 0x00,
0x0000000000000000)
    18                  },
    19
    20                  ResourceTemplate ()
    21                  {
    22                      Register (FFixedHW, 0x00, 0x00,
0x0000000000000000)
    23                  }
    24              })
    25              Method (_PSS, 0, NotSerialized)
    26              {
    27                  Store (MFID, Local0)
    28                  Store (MVID, Local1)
    29                  If (LEqual (Local0, 0x0A))
    30                  {
    31                      If (LEqual (Local1, 0x0C))
    32                      {
    33                          Return (Z000)
    34                      }
    35                  }
    36
    37                  If (LEqual (Local0, 0x0B))
    38                  {
    39                      If (LEqual (Local1, 0x0C))
    40                      {
    41                          Return (Z001)
    42                      }
    43                  }
    44
    45                  If (LEqual (Local0, 0x0C))
    46                  {
    47                      If (LEqual (Local1, 0x0C))
    48                      {
    49                          Return (Z002)
    50                      }
    51                  }
    52
    53                  If (LEqual (Local0, 0x0D))
    54                  {
    55                      If (LEqual (Local1, 0x0C))
    56                      {
    57                          Return (Z003)
    58                      }
    59                  }
    60
    61                  If (LEqual (Local0, 0x0E))
    62                  {
    63                      If (LEqual (Local1, 0x0C))
    64                      {
    65                          Return (Z004)
    66                      }
    67                  }
    68
    69                  If (LEqual (Local0, 0x00))
    70                  {
    71                      If (LEqual (Local1, 0x0C))
    72                      {
    73                          Return (Z005)
    74                      }
    75                  }
    76
    77                  If (LEqual (Local0, 0x02))
    78                  {
    79                      If (LEqual (Local1, 0x0D))
    80                      {
    81                          Return (Z006)
    82                      }
    83                  }
    84
    85                  If (LEqual (Local0, 0x0A))
    86                  {
    87                      If (LEqual (Local1, 0x0A))
    88                      {
    89                          Return (Z007)
    90                      }
    91                  }
    92
    93                  If (LEqual (Local0, 0x0B))
    94                  {
    95                      If (LEqual (Local1, 0x0A))
    96                      {
    97                          Return (Z008)
    98                      }
    99                  }
   100
   101                  If (LEqual (Local0, 0x0C))
   102                  {
   103                      If (LEqual (Local1, 0x0B))
   104                      {
   105                          Return (Z009)
   106                      }
   107                  }
   108
   109                  If (LEqual (Local0, 0x0D))
   110                  {
   111                      If (LEqual (Local1, 0x0B))
   112                      {
   113                          Return (Z00A)
   114                      }
   115                  }
   116
   117                  If (LEqual (Local0, 0x02))
   118                  {
   119                      If (LEqual (Local1, 0x09))
   120                      {
   121                          Return (Z00B)
   122                      }
   123                  }
   124              }
   125
   126              Name (Z000, Package (0x02)
   127              {
   128                  Package (0x06)
   129                  {
   130                      0x0320,
   131                      0x5DC0,
   132                      0x7D,
   133                      0x7D,
   134                      0x009C418A,
   135                      0x018A
   136                  },
   137
   138                  Package (0x06)
   139                  {
   140                      0x01F4,
   141                      0x3896,
   142                      0x7D,
   143                      0x7D,
   144                      0x009C41C4,
   145                      0x01C4
   146                  }
   147              })
   148              Name (Z001, Package (0x02)
   149              {
   150                  Package (0x06)


could you suggest any fix?

    TIA
    Joerg




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
