From: liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Subject: Re: 2.6 won't poweroff
Date: Tue, 25 May 2004 11:17:57 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.60.0405251112580.1337@frog.athome>
References: <20040525044514.GC2217@smeagol>
Reply-To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040525044514.GC2217-Kz9ENIl45+A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Emma Jane Hogbin <emmajane-MHIYrZpDPrNWk0Htik3J/w@public.gmane.org>
Cc: acpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut Emma,
I also use a TM634. You probably have compiled your kernel with APIC 
support
  CONFIG_X86_UP_APIC
As the TM63x does not have an APIC, it is best, to make a kernel without 
that. Then it will power-off. I use a stock 2.6.6-kernel (as the 
ACPI-patches go into mainline so quickly...)

Your syntax error seams to be something, you normally do not see, but this 
sounds like a bash-thing to me...

As I do not use gaim and xmms, I do not encounter freezes...

On Tue, 25 May 2004, Emma Jane Hogbin wrote:
> I have two big irritants for the 2.6.5/2.6.6 (patched for ACPI) kernels
> with ACPI.
>
> 	1. My computer no longer powers off. acpi_power_off is called, but the
> 	computer doesn't actually turn itself off. In fact when I use
> 	"poweroff" directly I get a message flashing across my screen saying:
> 		syntax error on 658 of stdin
>
> 	2. Random freezes. It's not just the touch pad or the keyboard, but
> 	rather the entire monitor seems to freeze from time to time and for no
> 	apparent reason. Gaim and xmms are usually (always?) open when it
> 	happens, but I can't believe that either of them would cause my system
> 	to freeze.
>
> I have an AcerTM 634 that did not have either of these two problems with
> 2.4.22. As requested on acpi.sf.net I have also made available:

cheers
   hartwig felger

Hartwig Felger informatics

- -- 
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFAsw9K9bBoTzOf1pMRAgYWAJ45mmieDXlUviVMC7PPnMdKWYPB8wCgiYhQ
G6RXHgeFCf5bvX0a0V/wbjs=
=T1e0
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
