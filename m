From: Andrew Barr <barr.156-ZbGKxL/pcrQ@public.gmane.org>
Subject: i855-based ThinkPad STR: Graphics device stays in D3 after resume
Date: Tue, 12 Apr 2005 20:32:35 -0400
Message-ID: <200504122032.36053.barr.156@osu.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I have been trying to get my ThinkPad R51 to resume from S3 for some weeks 
now:

http://thread.gmane.org/gmane.linux.acpi.devel/12971
http://thread.gmane.org/gmane.linux.hardware.thinkpad/17253

http://bugme.osdl.org/show_bug.cgi?id=4455

There's been some discussion on the linux-thinkpad mailinglist that seems to 
be the same problem I have:

http://thread.gmane.org/gmane.linux.hardware.thinkpad/17623
http://thread.gmane.org/gmane.linux.hardware.thinkpad/17489

Basically, these people did a BIOS upgrade that seems to have borked 
suspend-to-RAM on their ThinkPads. My ThinkPad is very new, so it shipped 
with a BIOS with this problem. I am going to try downgrading to BIOS and 
Embedded Controller versions mentioned in the above-referenced threads, but I 
did discover something interesting. The graphics device stays in D3 after 
resuming from S3 (I can ssh into my laptop). Here is the output of 'lspci 
-vvvxxx -s 00:02.0' before S3:

0000:00:02.0 VGA compatible controller: Intel Corporation 82852/855GM 
Integrated Graphics Device (rev 02) (prog-if 00 [VGA])
        Subsystem: IBM: Unknown device 0557
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e0000000 (32-bit, prefetchable)
        Region 1: Memory at d0000000 (32-bit, non-prefetchable) [size=512K]
        Region 2: I/O ports at 1800 [size=8]
        Capabilities: [d0] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 82 35 03 00 90 00 02 00 00 03 00 00 80 00
10: 08 00 00 e0 00 00 00 d0 01 18 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 57 05
30: 00 00 00 00 d0 00 00 00 00 00 00 00 0b 01 00 00
40: 09 00 05 81 00 40 00 00 00 00 00 00 00 00 00 00
50: 00 01 34 00 10 00 00 00 00 00 02 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: ff a2 5a 35 00 00 03 12 92 24 00 00 00 00 00 00
b0: 00 00 00 00 34 a0 36 00 1c 23 00 00 82 e6 48 07
c0: 07 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 01 00 21 02 00 00 00 00 08 c3 00 ff 25 00 00 00
e0: 2a 00 22 00 98 00 a2 00 00 00 00 00 00 04 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

and after:

0000:00:02.0 VGA compatible controller: Intel Corporation 82852/855GM 
Integrated Graphics Device (rev 02) (prog-if 00 [VGA])
        Subsystem: IBM: Unknown device 0557
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e0000000 (32-bit, prefetchable)
        Region 1: Memory at d0000000 (32-bit, non-prefetchable) [size=512K]
        Region 2: I/O ports at 1800 [size=8]
        Capabilities: [d0] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D3 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 82 35 03 00 90 00 02 00 00 03 00 00 80 00
10: 08 00 00 e0 00 00 00 d0 01 18 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 57 05
30: 00 00 00 00 d0 00 00 00 00 00 00 00 0b 01 00 00
40: 09 00 05 81 00 40 00 00 00 00 00 00 00 00 00 00
50: 00 01 34 00 10 00 00 00 00 00 02 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: ff a2 5a 35 00 00 00 00 cc 17 00 00 00 00 00 00
b0: 00 00 00 00 36 0f 11 00 e4 16 00 00 f2 89 3d 02
c0: 07 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 01 00 21 02 03 00 00 00 08 c2 00 ff 25 00 00 00
e0: 2a 00 22 00 98 00 22 00 00 00 00 00 00 04 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

I'm afraid I don't know enough about PCI or ACPI to know if this means 
anything. It is the only device in D3 after S3, though. All the others are 
resumed, they are in D0. I have no acpi_sleep parameter on my kernel 
commandline--s3_mode elicits similar behavior from the machine although I've 
not compared the PCI config space before and after suspend-to-RAM with that 
on the command line.

--
Andrew Barr
Student, Ohio State University

[firstname][lastname] at columbus rr com | [lastname].156 at osu edu
http://home.columbus.rr.com/andrewbarr

"Everyone is entitled to their own opinions, but not their own facts."
	- Daniel Patrick Moynihan


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
