From: Norbert Preining <preining-DX+603jRYB8@public.gmane.org>
Subject: Re: Re: Re: various problems with Acer TM654, suspend, ACAD, radeon
Date: Wed, 25 Aug 2004 15:59:00 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040825135900.GF6119@gamma.logic.tuwien.ac.at>
References: <20040820161911.GA24510@gamma.logic.tuwien.ac.at> <20040823070534.GD24853@message-id.gmane0305.slipkontur.de> <20040823103515.GH8635@gamma.logic.tuwien.ac.at> <20040824233153.GA15474@message-id.gmane0305.slipkontur.de> <20040825131109.GD6119@gamma.logic.tuwien.ac.at> <20040825135213.GA27584@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040825135213.GA27584-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mit, 25 Aug 2004, Karol Kozimor wrote:
> > AND: If you are in kicking the engenieers: Could you please ask them WHY
> > ON EARTH did they set the latency limit of the C2 state to 101, effectively
> > disabling the usage of C2?
> 
> Well, you've just answered yourself :)
> Seriously though, they might have overreacted / misread the erratum. ICH3-M
> does not like to enter C2/C3 when in IO-APIC mode, that's for sure.

??? Sorry for my complete lack of understanding: What does this mean? Do
you say that my laptop shouldn't run at all or have problems?

My /proc/acpi/processor/CPU0/power says:
active state:            C2
default state:           C1
bus master activity:     00000000
states:
    C1:                  promotion[C2] demotion[--] latency[000] usage[00352530]
   *C2:                  promotion[--] demotion[C1] latency[101] usage[10009625]
    C3:                  <not supported>

So it is working.

AND: I had suspend2disk run with the pmdisk code (before it was
merged/ripped out) without any problems, even with the b44 driver
loaded.

AND: Problems only arise with suspend2disk, not in normal operation.

So should I undo the C2 fix? Do you say that this is dangerous for the
laptop?

> Karol 'sziwan' Kozimor
> himself running on forced C3

;-)


Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
BURTON COGGLES
A bunch of keys found in a drawer whose purpose has long been
forgotten, and which can therefore now be used only for dropping down
people's backs as a cure for nose-bleeds.
			--- Douglas Adams, The Meaning of Liff


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
