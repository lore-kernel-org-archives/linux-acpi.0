From: trooper ryan <trooper_ryan-QPf0Bz723pkjHdulDSg1yw@public.gmane.org>
Subject: Re: PCI: Cannot allocate resource region 0 of device 0000:00:0d.0
Date: Sat, 24 Apr 2004 23:26:20 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <408AF79C.1050804@dmtsystems.net>
References: <408A85DE.8090700@dmtsystems.net> <20040424125753.GJ22558@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040424125753.GJ22558-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Matthew,

Thanks for taking the time to look at the problem.  I wasn't trying to 
be threatening, just conveying my level of frustration :)

Anyhow, the info you requested:
# setpci -s 00:0d.0 BASE_ADDRESS_0=ffffffff
setpci -s 00:0d.0 BASE_ADDRESS_0 returns 00d7f008 sometimes and ffffffff 
others.

# lspci -s 00:0d.0 -vvvxx
0000:00:0d.0 Multimedia video controller: Brooktree Corporation: Unknown 
device 

0346 (rev 11)
         Subsystem: LeadTek Research Inc.: Unknown device 6606
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Step 

ping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort 

- <MAbort- >SERR- <PERR+
         Latency: 32 (4000ns min, 10000ns max)
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at <ignored> (32-bit, prefetchable)
         Capabilities: [44] <chain broken>
00: 9e 10 46 03 06 00 90 82 11 00 00 04 00 20 80 00
10: 08 f0 d7 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 7d 10 06 66
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 01 10 28

-Trooper

Matthew Wilcox wrote:
> On Sat, Apr 24, 2004 at 03:21:02PM +0000, trooper ryan wrote:
> 
>>I'm really struggling to get a Brooktree video-capture card functional 
>>under 2.6.5.  I think i've isolated the problem as dmesg reports:
>>PCI: Cannot allocate resource region 0 of device 0000:00:0d.0
> 
> 
> Yeah, it looks like device 0000:00:0d.0 is completely messed up.
> 
> 
>>That device corresponds to the card as shown by lspci -vvv (see below).
> 
> 
> Can you send lspci -s 00:0d.0 -vvvxx too?
> 
> 
>>I'd really appreciate any suggestions as i've been trying to get this 
>>card functional for about two weeks.  Im so frustrated Im almost 
>>considering putting it in an XP box!
> 
> 
> Don't be stupid.  People think that threats like these make people take
> them more seriously.  It actually has the opposite effect.
> 
> 
>>0000:00:0d.0 Multimedia video controller: Brooktree Corporation: Unknown 
>>device 034e (rev 11)
>>        Subsystem: LeadTek Research Inc.: Unknown device 6606
>>        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>>ParErr- Stepping- SERR- FastB2B-
>>        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
>>
>>>TAbort- <TAbort- <MAbort- >SERR- <PERR+
>>
>>        Latency: 32 (4000ns min, 10000ns max)
>>        Interrupt: pin A routed to IRQ 11
>>        Region 0: Memory at <ignored> (32-bit, prefetchable) [disabled]
>>        Capabilities: [44] <chain broken>
> 
> 
> This "chain broken" concerns me a little.  If they aren't even able to
> get something as simple as PCI capabilities right, what else may they have broken?
> 
> You can use setpci to figure out how much space this device is requesting.
> 
> setpci -s 00:0d.0 BASE_ADDRESS_0=ffffffff
> setpci -s 00:0d.0 BASE_ADDRESS_0
> 
> will give you back something like ffff0004 (which would correspond to
> a 64k region).  Let us know what that returns.
> 
> 
>>0000:00:0d.1 Multimedia controller: Brooktree Corporation: Unknown 
>>device 0858 (rev 11)
>>        Subsystem: LeadTek Research Inc.: Unknown device 6606
>>        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>>ParErr- Stepping- SERR- FastB2B-
>>        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
>>
>>>TAbort- <TAbort- <MAbort- >SERR- <PERR+
>>
>>        Latency: 32 (1000ns min, 63750ns max)
>>        Interrupt: pin A routed to IRQ 11
>>        Region 0: Memory at <ignored> (32-bit, prefetchable) [disabled]
>>        Capabilities: [44] <chain broken>
>>
>>0000:01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 
>>630/730 PCI/AGP VGA Display Adapter (rev 21) (prog-if 00 [VGA])
>>        Subsystem: Asustek Computer, Inc.: Unknown device 80e1
>>        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
>>ParErr- Stepping- SERR- FastB2B-
>>        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
>>
>>>TAbort- <TAbort- <MAbort- >SERR- <PERR-
>>
>>        Interrupt: pin A routed to IRQ 11
>>        BIST result: 00
>>        Region 0: Memory at f0000000 (32-bit, prefetchable)
>>        Region 1: Memory at e9800000 (32-bit, non-prefetchable) [size=128K]
>>        Region 2: I/O ports at a800 [size=128]
>>        Capabilities: [40] Power Management version 1
>>                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
>>PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>>        Capabilities: [50] AGP version 2.0
>>                Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
>>HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
>>                Command: RQ=16 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- 
>>FW- Rate=x4
>>
>>
>>-------------------------------------------------------
>>This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
>>For a limited time only, get FREE Ground shipping on all orders of $35
>>or more. Hurry up and shop folks, this offer expires April 30th!
>>http://www.thinkgeek.com/freeshipping/?cpg=12297
>>_______________________________________________
>>Acpi-devel mailing list
>>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 
> 


-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
