From: Bernd Pfrommer <berndp-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Subject: Re: RE: CALL FOR TESTING
Date: Fri, 20 Sep 2002 09:55:07 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3D8B28BB.2010101@optonline.net>
References: <3D8B1470.5020507@optonline.net>
 <20020920135101.K10583@parcelfarce.linux.theplanet.co.uk>
Reply-To: berndp-p32f3XyCuykqcZcGjlUOXw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="Boundary_(ID_yzNTvIxVKNLgwYAYeQ3HMQ)"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Boundary_(ID_yzNTvIxVKNLgwYAYeQ3HMQ)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

With the bare 2.4.20-pre7 kernel, the interrupt assignment appears to 
work, and the machine boots up without passing acpi=off. However, the 
acpi driver doesn't load (and it didn't load in 2.4.18, 2.4.19 either)

Sep 20 05:23:58 option kernel: PCI: PCI BIOS revision 2.10 entry at 
0xfda65, last bus=1
Sep 20 05:23:58 option kernel: PCI: Using configuration type 1
Sep 20 05:23:58 option kernel: PCI: Probing PCI hardware
Sep 20 05:23:58 option kernel: PCI: Discovered primary peer bus 01 [IRQ]
Sep 20 05:23:58 option kernel: PCI->APIC IRQ transform: (B0,I4,P0) -> 23
Sep 20 05:23:58 option kernel: PCI->APIC IRQ transform: (B0,I7,P0) -> 17
Sep 20 05:23:58 option kernel: PCI->APIC IRQ transform: (B0,I8,P0) -> 16
Sep 20 05:23:58 option kernel: PCI->APIC IRQ transform: (B0,I15,P0) -> 10
Sep 20 05:23:58 option kernel: PCI->APIC IRQ transform: (B1,I4,P0) -> 24
Sep 20 05:23:58 option kernel: PCI->APIC IRQ transform: (B1,I4,P1) -> 25
Sep 20 05:23:58 option kernel: Linux NET4.0 for Linux 2.4
Sep 20 05:23:58 option kernel: Based upon Swansea University Computer 
Society NET3.039
Sep 20 05:23:58 option kernel: Initializing RT netlink socket
Sep 20 05:23:58 option kernel: Starting kswapd
Sep 20 05:23:58 option kernel: allocated 32 pages and 32 bhs reserved 
for the highmem bounces
Sep 20 05:23:58 option kernel: Journalled Block Device driver loaded
Sep 20 05:23:58 option kernel: Installing knfsd (copyright (C) 1996 
okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
Sep 20 05:23:58 option netfs: Mounting other filesystems:  succeeded
Sep 20 05:23:58 option kernel:  tbxface-0099 [01] Acpi_load_tables      
: ACPI Tables successfully loaded
Sep 20 05:23:58 option kernel:  tbxface-0106: *** Error: 
Acpi_load_tables: Could not load namespace: AE_NOT_FOUND
Sep 20 05:23:58 option kernel:  tbxface-0115: *** Error: 
Acpi_load_tables: Could not load tables: AE_NOT_FOUND
Sep 20 05:23:58 option kernel: ACPI: System description table load failed
Sep 20 05:23:58 option kernel:  utalloc-0504 [03] Ut_dump_allocations   
: Outstanding allocations:
Sep 20 05:23:58 option kernel: f7e77d08 Len 0038   utalloc-150 Parse_obj 
Opcode 0010
Sep 20 05:23:58 option kernel: f7e77d88 Len 0038   utalloc-150 Parse_obj 
Opcode 5B82
Sep 20 05:23:58 option kernel: f7eaf288 Len 0038   utalloc-150 Parse_obj 
Opcode 5B82
Sep 20 05:23:58 option kernel: f7eb01e8 Len 0038   utalloc-150 Parse_obj 
Opcode 5B82
Sep 20 05:23:58 option kernel: c1c1ce48 Len 0009  tbconvrt-520
Sep 20 05:23:58 option kernel:  utalloc-0598 [03] Ut_dump_allocations   
: Total number of unfreed allocations = 5(5)

And for reference, here again the messages with 2.4.20-pre7, with the 
acpi patch:

Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 997.4513 MHz.
..... host bus clock speed is 132.9934 MHz.
cpu: 0, clocks: 1329934, slice: 443311
CPU0<T0:1329920,T1:886608,D:1,S:443311,C:1329934>
cpu: 1, clocks: 1329934, slice: 443311
CPU1<T0:1329920,T1:443296,D:2,S:443311,C:1329934>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
ACPI: Subsystem revision 20020918
PCI: PCI BIOS revision 2.10 entry at 0xfda65, last bus=1
PCI: Using configuration type 1
    ACPI-0273: *** Info: Table [DSDT] replaced by host OS
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Root Bridge [NRTH] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Root Bridge [PCI1] (00:00)
ACPI: PCI Interrupt Link [LN00] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN01] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN02] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN03] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN04] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN05] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN06] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN07] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN08] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN09] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN10] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN11] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN12] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN13] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN14] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN15] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNUS] (IRQs 10, disabled)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LN00] enabled at IRQ 0
ACPI: PCI Interrupt Link [LN01] enabled at IRQ 0
ACPI: PCI Interrupt Link [LN02] enabled at IRQ 0
ACPI: PCI Interrupt Link [LN03] enabled at IRQ 0
ACPI: PCI Interrupt Link [LN04] enabled at IRQ 0
ACPI: PCI Interrupt Link [LN05] enabled at IRQ 0
ACPI: PCI Interrupt Link [LN06] enabled at IRQ 0
ACPI: PCI Interrupt Link [LN07] enabled at IRQ 0
ACPI: PCI Interrupt Link [LN08] enabled at IRQ 0
ACPI: PCI Interrupt Link [LN09] enabled at IRQ 0
ACPI: PCI Interrupt Link [LN10] enabled at IRQ 0
ACPI: PCI Interrupt Link [LN11] enabled at IRQ 0
ACPI: PCI Interrupt Link [LN12] enabled at IRQ 0
ACPI: PCI Interrupt Link [LN13] enabled at IRQ 0
ACPI: PCI Interrupt Link [LN14] enabled at IRQ 0
ACPI: PCI Interrupt Link [LN15] enabled at IRQ 0
ACPI: PCI Interrupt Link [LNUS] enabled at IRQ 0
PCI: No IRQ known for interrupt pin A of device 00:0f.2 - using IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'

With the acpi patch it is really hard to figure out what's breaking the 
boot, because once there is a kernel panic, it is impossible to scroll 
back to the messages that indicate an ACPI problem. I had to configure 
the serial port, buy a null modem cable etc just to get to the messages 
printed here. A lot of users may not know about this trick, or may not 
want to go through the trouble of configuring serial console access.

Please let me know if I can be of any help.

Thanks,

Bernd


Matthew Wilcox wrote:

>On Fri, Sep 20, 2002 at 08:28:32AM -0400, Bernd Pfrommer wrote:
>
>>kernel: 2.4.20-pre7, with patch acpi20020918, configured with ACPI
>>platform: intel server SRMK2S with AMIBIOS and dual 1GHz PIII/256k 
>>cache, 1GB memory, adaptec 7899 SCSI
>>
>>DOES NOT BOOT
>>
>
>The question Andy forgot to ask is:
>
>Does it work with ACPI enabled in the stock 2.4.20-pre7 kernel?
>	[ If NO, there is no problem with including today's code.
>	  Didn't work before, still doesn't work => not a regression. ]
>
>I agree your machine should be fixed, but the real purpose of this test
>is to determine whether there are any impediments to including this code
>in 2.4.20.
>


--Boundary_(ID_yzNTvIxVKNLgwYAYeQ3HMQ)
Content-type: text/html; charset=us-ascii
Content-transfer-encoding: 7BIT

<html>
<head>
</head>
<body>
With the bare 2.4.20-pre7 kernel, the interrupt assignment appears to work,
and the machine boots up without passing acpi=off. However, the acpi driver
doesn't load (and it didn't load in 2.4.18, 2.4.19 either)<br>
<br>
Sep 20 05:23:58 option kernel: PCI: PCI BIOS revision 2.10 entry at 0xfda65,
last bus=1<br>
Sep 20 05:23:58 option kernel: PCI: Using configuration type 1<br>
Sep 20 05:23:58 option kernel: PCI: Probing PCI hardware<br>
Sep 20 05:23:58 option kernel: PCI: Discovered primary peer bus 01 [IRQ]<br>
Sep 20 05:23:58 option kernel: PCI-&gt;APIC IRQ transform: (B0,I4,P0) -&gt;
23<br>
Sep 20 05:23:58 option kernel: PCI-&gt;APIC IRQ transform: (B0,I7,P0) -&gt;
17<br>
Sep 20 05:23:58 option kernel: PCI-&gt;APIC IRQ transform: (B0,I8,P0) -&gt;
16<br>
Sep 20 05:23:58 option kernel: PCI-&gt;APIC IRQ transform: (B0,I15,P0) -&gt;
10<br>
Sep 20 05:23:58 option kernel: PCI-&gt;APIC IRQ transform: (B1,I4,P0) -&gt;
24<br>
Sep 20 05:23:58 option kernel: PCI-&gt;APIC IRQ transform: (B1,I4,P1) -&gt;
25<br>
Sep 20 05:23:58 option kernel: Linux NET4.0 for Linux 2.4<br>
Sep 20 05:23:58 option kernel: Based upon Swansea University Computer Society
NET3.039<br>
Sep 20 05:23:58 option kernel: Initializing RT netlink socket<br>
Sep 20 05:23:58 option kernel: Starting kswapd<br>
Sep 20 05:23:58 option kernel: allocated 32 pages and 32 bhs reserved for
the highmem bounces<br>
Sep 20 05:23:58 option kernel: Journalled Block Device driver loaded<br>
Sep 20 05:23:58 option kernel: Installing knfsd (copyright (C) 1996 <a class="moz-txt-link-abbreviated" href="mailto:okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org">okir@monad.swb.de</a>).<br>
Sep 20 05:23:58 option netfs: Mounting other filesystems:&nbsp; succeeded<br>
Sep 20 05:23:58 option kernel:&nbsp; tbxface-0099 [01] Acpi_load_tables&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :
ACPI Tables successfully loaded<br>
Sep 20 05:23:58 option kernel:&nbsp; tbxface-0106: *** Error: Acpi_load_tables:
Could not load namespace: AE_NOT_FOUND<br>
Sep 20 05:23:58 option kernel:&nbsp; tbxface-0115: *** Error: Acpi_load_tables:
Could not load tables: AE_NOT_FOUND<br>
Sep 20 05:23:58 option kernel: ACPI: System description table load failed<br>
Sep 20 05:23:58 option kernel:&nbsp; utalloc-0504 [03] Ut_dump_allocations&nbsp;&nbsp; :
Outstanding allocations:<br>
Sep 20 05:23:58 option kernel: f7e77d08 Len 0038&nbsp;&nbsp; utalloc-150 Parse_obj
Opcode 0010<br>
Sep 20 05:23:58 option kernel: f7e77d88 Len 0038&nbsp;&nbsp; utalloc-150 Parse_obj
Opcode 5B82<br>
Sep 20 05:23:58 option kernel: f7eaf288 Len 0038&nbsp;&nbsp; utalloc-150 Parse_obj
Opcode 5B82<br>
Sep 20 05:23:58 option kernel: f7eb01e8 Len 0038&nbsp;&nbsp; utalloc-150 Parse_obj
Opcode 5B82<br>
Sep 20 05:23:58 option kernel: c1c1ce48 Len 0009&nbsp; tbconvrt-520<br>
Sep 20 05:23:58 option kernel:&nbsp; utalloc-0598 [03] Ut_dump_allocations&nbsp;&nbsp; :
Total number of unfreed allocations = 5(5)<br>
<br>
And for reference, here again the messages with 2.4.20-pre7, with the acpi
patch:<br>
<br>
Using local APIC timer interrupts.<br>
calibrating APIC timer ...<br>
..... CPU clock speed is 997.4513 MHz.<br>
..... host bus clock speed is 132.9934 MHz.<br>
cpu: 0, clocks: 1329934, slice: 443311<br>
CPU0&lt;T0:1329920,T1:886608,D:1,S:443311,<a class="moz-txt-link-freetext" href="C:1329934">C:1329934</a>&gt;<br>
cpu: 1, clocks: 1329934, slice: 443311<br>
CPU1&lt;T0:1329920,T1:443296,D:2,S:443311,<a class="moz-txt-link-freetext" href="C:1329934">C:1329934</a>&gt;<br>
checking TSC synchronization across CPUs: passed.<br>
Waiting on wait_init_idle (map = 0x2)<br>
All processors have done init_idle<br>
ACPI: Subsystem revision 20020918<br>
PCI: PCI BIOS revision 2.10 entry at 0xfda65, last bus=1<br>
PCI: Using configuration type 1<br>
&nbsp;&nbsp;&nbsp; ACPI-0273: *** Info: Table [DSDT] replaced by host OS<br>
ACPI: Interpreter enabled<br>
ACPI: Using IOAPIC for interrupt routing<br>
ACPI: System [ACPI] (supports S0 S1 S4 S5)<br>
ACPI: PCI Root Bridge [NRTH] (00:00)<br>
PCI: Probing PCI hardware (bus 00)<br>
ACPI: PCI Root Bridge [PCI1] (00:00)<br>
ACPI: PCI Interrupt Link [LN00] (IRQs 3 4 5 7 9 11 12 14 15, disabled)<br>
ACPI: PCI Interrupt Link [LN01] (IRQs 3 4 5 7 9 11 12 14 15, disabled)<br>
ACPI: PCI Interrupt Link [LN02] (IRQs 3 4 5 7 9 11 12 14 15, disabled)<br>
ACPI: PCI Interrupt Link [LN03] (IRQs 3 4 5 7 9 11 12 14 15, disabled)<br>
ACPI: PCI Interrupt Link [LN04] (IRQs 3 4 5 7 9 11 12 14 15, disabled)<br>
ACPI: PCI Interrupt Link [LN05] (IRQs 3 4 5 7 9 11 12 14 15, disabled)<br>
ACPI: PCI Interrupt Link [LN06] (IRQs 3 4 5 7 9 11 12 14 15, disabled)<br>
ACPI: PCI Interrupt Link [LN07] (IRQs 3 4 5 7 9 11 12 14 15, disabled)<br>
ACPI: PCI Interrupt Link [LN08] (IRQs 3 4 5 7 9 11 12 14 15, disabled)<br>
ACPI: PCI Interrupt Link [LN09] (IRQs 3 4 5 7 9 11 12 14 15, disabled)<br>
ACPI: PCI Interrupt Link [LN10] (IRQs 3 4 5 7 9 11 12 14 15, disabled)<br>
ACPI: PCI Interrupt Link [LN11] (IRQs 3 4 5 7 9 11 12 14 15, disabled)<br>
ACPI: PCI Interrupt Link [LN12] (IRQs 3 4 5 7 9 11 12 14 15, disabled)<br>
ACPI: PCI Interrupt Link [LN13] (IRQs 3 4 5 7 9 11 12 14 15, disabled)<br>
ACPI: PCI Interrupt Link [LN14] (IRQs 3 4 5 7 9 11 12 14 15, disabled)<br>
ACPI: PCI Interrupt Link [LN15] (IRQs 3 4 5 7 9 11 12 14 15, disabled)<br>
ACPI: PCI Interrupt Link [LNUS] (IRQs 10, disabled)<br>
PCI: Probing PCI hardware<br>
ACPI: PCI Interrupt Link [LN00] enabled at IRQ 0<br>
ACPI: PCI Interrupt Link [LN01] enabled at IRQ 0<br>
ACPI: PCI Interrupt Link [LN02] enabled at IRQ 0<br>
ACPI: PCI Interrupt Link [LN03] enabled at IRQ 0<br>
ACPI: PCI Interrupt Link [LN04] enabled at IRQ 0<br>
ACPI: PCI Interrupt Link [LN05] enabled at IRQ 0<br>
ACPI: PCI Interrupt Link [LN06] enabled at IRQ 0<br>
ACPI: PCI Interrupt Link [LN07] enabled at IRQ 0<br>
ACPI: PCI Interrupt Link [LN08] enabled at IRQ 0<br>
ACPI: PCI Interrupt Link [LN09] enabled at IRQ 0<br>
ACPI: PCI Interrupt Link [LN10] enabled at IRQ 0<br>
ACPI: PCI Interrupt Link [LN11] enabled at IRQ 0<br>
ACPI: PCI Interrupt Link [LN12] enabled at IRQ 0<br>
ACPI: PCI Interrupt Link [LN13] enabled at IRQ 0<br>
ACPI: PCI Interrupt Link [LN14] enabled at IRQ 0<br>
ACPI: PCI Interrupt Link [LN15] enabled at IRQ 0<br>
ACPI: PCI Interrupt Link [LNUS] enabled at IRQ 0<br>
PCI: No IRQ known for interrupt pin A of device 00:0f.2 - using IRQ 10<br>
PCI: Using ACPI for IRQ routing<br>
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'<br>
<br>
With the acpi patch it is really hard to figure out what's breaking the boot,
because once there is a kernel panic, it is impossible to scroll back to
the messages that indicate an ACPI problem. I had to configure the serial
port, buy a null modem cable etc just to get to the messages printed here.
A lot of users may not know about this trick, or may not want to go through
the trouble of configuring serial console access.<br>
<br>
Please let me know if I can be of any help.<br>
<br>
Thanks,<br>
<br>
Bernd<br>
<br>
<br>
Matthew Wilcox wrote:<br>
<blockquote type="cite" cite="mid:20020920135101.K10583-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org">
  <pre wrap="">On Fri, Sep 20, 2002 at 08:28:32AM -0400, Bernd Pfrommer wrote:<br></pre>
  <blockquote type="cite">
    <pre wrap="">kernel: 2.4.20-pre7, with patch acpi20020918, configured with ACPI<br>platform: intel server SRMK2S with AMIBIOS and dual 1GHz PIII/256k <br>cache, 1GB memory, adaptec 7899 SCSI<br><br>DOES NOT BOOT<br></pre>
    </blockquote>
    <pre wrap=""><!----><br>The question Andy forgot to ask is:<br><br>Does it work with ACPI enabled in the stock 2.4.20-pre7 kernel?<br>	[ If NO, there is no problem with including today's code.<br>	  Didn't work before, still doesn't work =&gt; not a regression. ]<br><br>I agree your machine should be fixed, but the real purpose of this test<br>is to determine whether there are any impediments to including this code<br>in 2.4.20.<br><br></pre>
    </blockquote>
    <br>
    </body>
    </html>

--Boundary_(ID_yzNTvIxVKNLgwYAYeQ3HMQ)--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
