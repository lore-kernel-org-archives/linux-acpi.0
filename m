From: liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Subject: Re: 2.6 won't poweroff
Date: Thu, 27 May 2004 17:22:22 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.60.0405271714330.4143@frog.athome>
References: <20040525044514.GC2217@smeagol>  <Pine.LNX.4.60.0405251112580.1337@frog.athome>
 <1085638695.17686.64.camel@dhcppc4>
Reply-To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1085638695.17686.64.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Emma Jane Hogbin <emmajane-MHIYrZpDPrNWk0Htik3J/w@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut Len & Emma,
On Thu, 27 May 2004, Len Brown wrote:
> On Tue, 2004-05-25 at 05:17, liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
>>
...
>> As the TM63x does not have an APIC, it is best, to make a kernel without
>> that. Then it will power-off. I use a stock 2.6.6-kernel (as the
>> ACPI-patches go into mainline so quickly...)
>
> I think every processor since Pentium 1 has a Local APIC built in --
> at least all the processors from Intel.
Ok, I was not precise about that. You are right, that I wanted to say, 
that the TM63x does not have an IOAPIC...
Anyway, I know, what the IOAPIC is good for, but what do I need an LAPIC 
in an single CPU-system? May somebody elaborate on that?

My problem with Emma is, that I have the same TM634 and no problem with 
vanilla 2.6.6 kernel to power-off. There was something around 2.6.4 IIRC, 
but it was worked-around by not compiling in APIC-support. But I do not 
know, if this issue still persists.

Emma, does your TM634 has the latest BIOS from Acer, i.e. R01-C0O?

Cheers
   hartwig felger

Hartwig Felger informatics

- -- 
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFAtgey9bBoTzOf1pMRAj9yAJ9bizWujezfU12AliUfOUD6tJtrQACfcQcC
+Do5XPclH346voZ5zdBedK8=
=yWKz
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
