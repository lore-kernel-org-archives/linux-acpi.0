From: Joshua Wise <joshua-NtISFavHD68j5TC/SZClsA@public.gmane.org>
Subject: Re: ACPI on hp tc1100
Date: Sun, 26 Dec 2004 15:24:16 -0500
Message-ID: <41CF1DF0.60504@joshuawise.com>
References: <41B2912D.8020105@joshuawise.com> <Pine.LNX.4.60.0412051210070.990@frog.athome> <41B377AE.7080108@joshuawise.com> <41CE656C.1050500@joshuawise.com> <20041226073113.GA919@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041226073113.GA919-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> What does lspci say about the host/pci bridge ?

I'm not quite sure what you were asking for.

I first did an lspci -t, knowing that my video card was 01:00.0, and 
found the following line (coming off bus 00):
       +-01.0-[01]----00.0

So it looks like 00:01.0 is the AGP bridge. I looked in there with lspci 
-v -v -s:
joshua@shebang:~$ sudo lspci -v -v -s 00:01.0
0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller 
(rev 03) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 96
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
         Memory behind bridge: d8000000-dfffffff
         Prefetchable memory behind bridge: e8000000-f7ffffff
         BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

So there's my AGP bridge: part of the 82855PM.

For good measure, I'll also give you the lspci details about the 
graphics card:
joshua@shebang:~$ sudo lspci -v -v -s 01:00.0
0000:01:00.0 VGA compatible controller: nVidia Corporation NV17 
[GeForce4 420 Go 32M] (rev a3) (prog-if 00 [VGA])
         Subsystem: Hewlett-Packard Company: Unknown device 08b0
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 248 (1250ns min, 250ns max)
         Interrupt: pin A routed to IRQ 10
         Region 0: Memory at d8000000 (32-bit, non-prefetchable) [size=16M]
         Region 1: Memory at f0000000 (32-bit, prefetchable) [size=64M]
         Region 2: Memory at e8000000 (32-bit, prefetchable) [size=512K]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [44] AGP version 2.0
                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                 Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- 
FW- Rate=x4

Let me know if you have further questions.

> 		Dave
joshua



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
