From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: cardbus bridge suspend/resume (Re: PCI not restored
	correctly after suspend to ram)
Date: 20 Mar 2004 00:52:32 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1079761951.7277.735.camel@dhcppc4>
References: <200403180935.09436.stefan.doesinger@gym-leoben.asn-graz.ac.at>
	 <1079761564.7274.730.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1079761564.7274.730.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: stefan.doesinger-dYJrdcitkgg0+Ua9VpOLR6Q1ief8SNuKXqFh9Ls21Oc@public.gmane.org
Cc: "linux-pci-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org" <linux-pci-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, 2004-03-20 at 00:46, Len Brown wrote:

> Is there any software in Linux responsible for preserving
> and restoring the PCI config space for PCI/PCI bridges
> across a suspend/resume?

Same question for the cardbus bridge, where
after resume the state is completely different.

thanks,
-Len
---------

lspci_before_suspend

02:06.0 CardBus bridge: O2 Micro, Inc.: Unknown device 7114 (rev 20)
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at d0207000 (32-bit, non-prefetchable)
[size=4K]
        Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
        Memory window 0: d0400000-d04ff000 (prefetchable)
        Memory window 1: d0300000-d03ff000 (prefetchable)
        I/O window 0: 00004400-000044ff
        I/O window 1: 00004000-000040ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+
PostWrite-
        16-bit legacy interface ports at 0001
00: 17 12 14 71 87 01 10 04 20 00 07 06 00 40 82 00
10: 00 70 20 d0 a0 00 00 02 02 03 06 b0 00 00 40 d0
20: 00 f0 4f d0 00 00 30 d0 00 f0 3f d0 01 44 00 00
30: fd 44 00 00 01 40 00 00 fd 40 00 00 ff 01 c0 03
40: 25 10 1f 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

lspci_after_suspend:

02:06.0 CardBus bridge: O2 Micro, Inc.: Unknown device 7114 (rev 20)
        Subsystem: Unknown device 0001:0000
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: [virtual] Memory at d0207000 (32-bit,
non-prefetchable) [disabled] [size=4K]
        Bus: primary=00, secondary=00, subordinate=00, sec-latency=0
        I/O window 0: 00000000-00000003 [disabled]
        I/O window 1: 00000000-00000003 [disabled]
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt-
PostWrite-
        16-bit legacy interface ports at 0001
00: 17 12 14 71 80 00 10 04 20 00 07 06 00 00 82 00
10: 00 00 00 00 a0 00 00 02 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00
30: 01 00 00 00 01 00 00 00 01 00 00 00 00 01 00 00
40: 01 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
