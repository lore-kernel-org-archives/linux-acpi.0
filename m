From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Plea for help
Date: Fri, 2 Jan 2004 15:34:25 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720C71@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ian Pilcher <i.pilcher-Wuw85uim5zDR7s880joybQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>>Yu, Luming wrote:
>> I'm not sure, but the most possibility is at
acpi_ev_create_gpe_block.
>> Normally, the next expected message  would be like:
>>=20
>> evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode
>> successful
>> evgpeblk-0747 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs
at
>> 0000009
>>=20
>> I did find the desultory words showing that in ACPI-DEBUG dmesg.  Is
it
>> possible to dig into ?
>
>The attached file is what appears on the local console (modulo possible
>typos).  You can see that these messages do appear, mixed in with the
>panic information.

Since I cannot reporduce it on my side. Would you please dig into=20
function acpi_ev_create_gpe_block.


>> BTW, I want to know whether that panic could be found in UP kernel.
>
>The panic does not occur with a uniprocessor kernel, nor does it happen
>when I boot with 'maxcpus=3D1'.

Hmm, It sounds like SMP relative issue.

>And just for grins and giggles, I tried booting with 'idle=3Dpoll'.  =
Sure
>enough, no panic.

I'm confused!=20

>Happy New Year!

Happy New Year!

--Luming


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
