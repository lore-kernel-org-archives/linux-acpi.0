From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: 2.6 won't poweroff
Date: 27 May 2004 02:18:15 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1085638695.17686.64.camel@dhcppc4>
References: <20040525044514.GC2217@smeagol>
	 <Pine.LNX.4.60.0405251112580.1337@frog.athome>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.60.0405251112580.1337-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Cc: Emma Jane Hogbin <emmajane-MHIYrZpDPrNWk0Htik3J/w@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2004-05-25 at 05:17, liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Salut Emma,
> I also use a TM634. You probably have compiled your kernel with APIC 
> support
>   CONFIG_X86_UP_APIC
> As the TM63x does not have an APIC, it is best, to make a kernel without 
> that. Then it will power-off. I use a stock 2.6.6-kernel (as the 
> ACPI-patches go into mainline so quickly...)

I think every processor since Pentium 1 has a Local APIC built in --
at least all the processors from Intel.

If you build in support for it, you can disable it with "nolapic".

Note that LAPIC is required to support IOAPIC -- which is a motherboard
device in the chipset.  This on can be disabled with "noapic".

-Len




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
