From: Emilio =?iso-8859-1?q?Mej=EDa=20Fern=E1ndez=20de=20Velasco?= <emejia-EkmVulN54Sk@public.gmane.org>
Subject: Re: Acpi-devel digest, Vol 1 #1755 - 3 msgs
Date: Wed, 21 Apr 2004 02:14:21 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200404210214.22007.emejia@ieee.org>
References: <20040420235602.2A6361D1CEC@sc8-sf-uberspam1.sourceforge.net>
Reply-To: emejia-EkmVulN54Sk@public.gmane.org
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dzbhA87koBUm9WR"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040420235602.2A6361D1CEC-OzNnu8isf6tmn0lPF+B0o2Y9YhHS9GKTCHO06yS12DY@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Boundary-00=_dzbhA87koBUm9WR
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


>

> From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
> To: 'acpi-devel' <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> Subject: Re: RV: [ACPI] differences between acpidump and disassembling

> if there's no patch available for the latest 2.6.5 it doesn't mean that the
> patch for 2.6.4 doesn't work on 2.6.5. In fact this isn't correct: the
> contrary is true, I successfully patched a vanilla 2.6.5 with the ACPI DSDT
> in initrd patch for 2.6.4 (Jose Bernardo Silva one from
> http://gaugusch.at/kernel.shtml).
>
> > Anyway, the only solution is to give up and wait until some kernel comes
> > and works with my laptop -and acpi-.
>
> Doesn't Sergio Monteiro Basto advise you that you don't need any custom
> DSDT? You should be able to use any vanilla kernel + ACPI patches with the
> original DSDT.

yes, sure, but I was explaining why I was using 2.6.4 instead of 2.6.5. This 
was before Sergio's advice.
Right now I'm compiling again 2.6.5 even though I'm pretty sure that I'll have 
the same blockings.

I have tried to apply last acpi patch, but I get this kind of messages:

Hunk #1 FAILED at 2440.
1 out of 1 hunk FAILED -- saving rejects to file 
arch/i386/kernel/io_apic.c.rej
patching file arch/x86_64/kernel/io_apic.c
Reversed (or previously applied) patch detected!  Assume -R? [n]
Apply anyway? [n] y
Hunk #1 FAILED at 1891.
1 out of 1 hunk FAILED -- saving rejects to file 
arch/x86_64/kernel/io_apic.c.rej
Hunk #1 FAILED at 2440.
1 out of 1 hunk FAILED -- saving rejects to file 
arch/i386/kernel/io_apic.c.rej
patching file arch/x86_64/kernel/io_apic.c
Reversed (or previously applied) patch detected!  Assume -R? [n]
Apply anyway? [n] y
Hunk #1 FAILED at 1891.
1 out of 1 hunk FAILED -- saving rejects to file 
arch/x86_64/kernel/io_apic.c.rej
...

So I'll just use the raw version as downloaded from kernel.org, unless you 
give me any hint about these.

I also send you the .config file, so if you find something that I shouldn't 
include, please let me know

Thank you so much


Emilio


--Boundary-00=_dzbhA87koBUm9WR
Content-Type: application/x-bzip2;
  name=".config.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename=".config.bz2"

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
tuRQE/+LuSKcKEgO4gUBgA==

--Boundary-00=_dzbhA87koBUm9WR--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
