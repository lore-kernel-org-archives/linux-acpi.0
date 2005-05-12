From: =?iso-8859-1?q?Ois=EDn_Mac_Fheara=ED?= <destynova-iUB+o6dfpG8i1yMB4YHZDQ@public.gmane.org>
Subject: Re: ACPI-0352 error
Date: Thu, 12 May 2005 14:41:54 +0100
Message-ID: <200505121441.55017.destynova@esatclear.ie>
References: <1115886948.4283156406f39@www.turls.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1115886948.4283156406f39-eOK/eZD5cvCSaWcfd5glvw@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, ian-bpYUrRpEkwj10XsdtD+oqA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thursday 12 May 2005 09:35, ian-bpYUrRpEkwj10XsdtD+oqA@public.gmane.org wrote:
> ACPI-0352: *** Error: Looking up [Z00D] in namespace, AE_NOT_FOUND
> search_node f7f1ec80 start_node f7f1ec80 return_node 00000000
>     ACPI-1133: *** Error: [NULL NAME], AE_NOT_FOUND
>     ACPI-1133: *** Error: Method execution failed [\_SB_.BAT1._BST] (No=
de
> f7f1ebc0), AE_NOT_FOUND

I was getting similar problems on my Acer 1705SMi laptop, so I applied th=
ese=20
fixes to my DSDT, which seemed to resolve them.

Maybe our DSDTs are similar enough so that you can apply the same fixes.

Ois=EDn

___
fix.diff
1,2c1
< /*
<  * Intel ACPI Component Architecture
---
> /* Intel ACPI Component Architecture
5c4
<  * Disassembly of dsdt.dat, Sat Jun  5 11:35:25 2004
---
>  * Disassembly of dsdt, Wed Nov 26 06:30:23 2003
842a842
>                         Return (0x00)
3430,3431c3430,3431
<                 Z00D,
<                 Z00D,
---
>                 Z00C,
>                 Z00C,
3721,3723c3721,3723
<                 }
<
<                 Decrement (Local1)
---
>                     Decrement (Local1)
>               }
>               Return (0x00)
3833a3834
>     Return(Package(0x02){0x00, 0x00})
3875d3875
<


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=3D7393&alloc_id=3D16281&op=3Dclick
