From: Bernd Pfrommer <berndp-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Subject: Re: RE: CALL FOR TESTING
Date: Fri, 20 Sep 2002 15:17:05 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3D8B7431.7040309@optonline.net>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE96@orsmsx119.jf.intel.com>
Reply-To: berndp-p32f3XyCuykqcZcGjlUOXw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="Boundary_(ID_qkrj82bf4BvZUt2pbboHmg)"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Boundary_(ID_qkrj82bf4BvZUt2pbboHmg)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

Thanks for the prompt reply!

Grover, Andrew wrote:

>>From: Bernd Pfrommer [mailto:berndp-p32f3XyCuykqcZcGjlUOXw@public.gmane.org] 
>>kernel: 2.4.20-pre7, with patch acpi20020918, configured with ACPI
>>platform: intel server SRMK2S with AMIBIOS and dual 1GHz PIII/256k 
>>cache, 1GB memory, adaptec 7899 SCSI
>>
>>DOES NOT BOOT
>>
>
>>I have attached the unpatched dsdt. To get rid of acpi error 
>>messages, I 
>>removed offending "Name()" lines. Please let me know if this is the 
>>appropriate fix. As I said, it doesn't boot with the original 
>>dsdt either.
>>
>
>I have an SCB2 system, whose ASL looks pretty similar to yours -- even some
>of the same ASL problems. It boots for me with an SMP but not UP kernel.
>
>Which are you trying?
>
Since the machine has 2 CPUs, the kernel is configured for SMP.

>
>
>If UP, can you please try this ASL change?
>
>Search for this:
>
>    Method(GETI, 1) {
>        If(And(Arg0, 0xf, )) {
>            Return(Zero)
>        }
>        Else {
>            Return(\MLIB.CNV2(And(Arg0, 0xf, )))
>        }
>    }
>
>And swap the contents of the if/else.
>
>The Name() lines emit a warning but are harmless.
>
>If you're having troubles in SMP mode, then I guess that is not shared
>between our two platforms...
>
>Thanks -- Regards -- Andy
>
With regards to Matthew Wilcox's comments: I have tried with 2.4.20-pre7 
without the acpi patch, and the machine boots there, and interrupts are 
assigned correctly (having ACPI config switched on for the kernel). 
However, the ACPI driver load fails as I posted in an earlier message.

Although I'm not running in uniprocessor mode, I still tried your ASL 
fix above, and the IRQ assignment has changed (see below), although the 
system still wouldn't boot (neither does it when I use pci=noacpi).

Does the interrupt assignment look reasonable to you? Do you have any 
more ASL fixes to suggest?

Thanks,
Bernd


//
// ----------------------------- THIS IS THE INTERRUPT DISTRIBUTION WHEN 
BOOTING WITH ACPI=OFF ----------------------
// (system boots successfully)

ACPI: Subsystem revision 20020918
ACPI: Disabled via command line (acpi=off)
PCI: PCI BIOS revision 2.10 entry at 0xfda65, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: ACPI tables contain no PCI IRQ routing entries
PCI: Probing PCI hardware (bus 00)
PCI: Discovered primary peer bus 01 [IRQ]
PCI->APIC IRQ transform: (B0,I4,P0) -> 23
PCI->APIC IRQ transform: (B0,I7,P0) -> 17
PCI->APIC IRQ transform: (B0,I8,P0) -> 16
PCI->APIC IRQ transform: (B0,I15,P0) -> 10
PCI->APIC IRQ transform: (B1,I4,P0) -> 24
PCI->APIC IRQ transform: (B1,I4,P1) -> 25

//
// ---------------------------- THIS IS WITH 2.4.20-pre7 + acpi patch + 
above DSDT fix 
-----------------------------------------------------------------
//(kernel panic)


Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
ACPI: Subsystem revision 20020918
PCI: PCI BIOS revision 2.10 entry at 0xfda65, last bus=1
PCI: Using configuration type 1
    ACPI-0273: *** Info: Table [DSDT] replaced by host OS
    ACPI-0217: *** Warning: Invalid type (Integer) for target of Scope 
operator
[DEB_], changing type to ANY
..
.. (LOTS OF THESE WARNINGS....)
..  
[BIOS], changing type to ANY
    ACPI-0490: *** Warning: Invalid type (Integer) for target of Scope 
operator
[CMOS], changing type to ANY
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Root Bridge [NRTH] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Root Bridge [PCI1] (00:00)
ACPI: PCI Interrupt Link [LN00] (IRQs 3 4 *5 7 9 11 12 14 15)
ACPI: PCI Interrupt Link [LN01] (IRQs 3 4 5 7 9 11 12 14 15, enabled at 
IRQ 10)
ACPI: PCI Interrupt Link [LN02] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN03] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN04] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN05] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN06] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN07] (IRQs 3 4 5 7 9 *11 12 14 15)
ACPI: PCI Interrupt Link [LN08] (IRQs *3 4 5 7 9 11 12 14 15)
ACPI: PCI Interrupt Link [LN09] (IRQs 3 4 5 7 *9 11 12 14 15)
ACPI: PCI Interrupt Link [LN10] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN11] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN12] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN13] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN14] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN15] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNUS] (IRQs *10)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LN02] enabled at IRQ 11
ACPI: PCI Interrupt Link [LN03] enabled at IRQ 9
ACPI: PCI Interrupt Link [LN04] enabled at IRQ 5
ACPI: PCI Interrupt Link [LN05] enabled at IRQ 11
ACPI: PCI Interrupt Link [LN06] enabled at IRQ 9
ACPI: PCI Interrupt Link [LN10] enabled at IRQ 5
ACPI: PCI Interrupt Link [LN11] enabled at IRQ 11
ACPI: PCI Interrupt Link [LN12] enabled at IRQ 9
ACPI: PCI Interrupt Link [LN13] enabled at IRQ 5
ACPI: PCI Interrupt Link [LN14] enabled at IRQ 11
ACPI: PCI Interrupt Link [LN15] enabled at IRQ 9
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off


Eventually kernel panic because SCSI disk driver load fails due to irq 
mismatch



--Boundary_(ID_qkrj82bf4BvZUt2pbboHmg)
Content-type: text/html; charset=us-ascii
Content-transfer-encoding: 7BIT

<html>
<head>
</head>
<body>
Thanks for the prompt reply!<br>
<br>
Grover, Andrew wrote:<br>
<blockquote type="cite" cite="mid:EDC461A30AC4D511ADE10002A5072CAD0236DE96-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org">
  <blockquote type="cite">
    <pre wrap="">From: Bernd Pfrommer [<a class="moz-txt-link-freetext" href="mailto:berndp-p32f3XyCuykqcZcGjlUOXw@public.gmane.org">mailto:berndp@optonline.net</a>] <br>kernel: 2.4.20-pre7, with patch acpi20020918, configured with ACPI<br>platform: intel server SRMK2S with AMIBIOS and dual 1GHz PIII/256k <br>cache, 1GB memory, adaptec 7899 SCSI<br><br>DOES NOT BOOT<br></pre>
    </blockquote>
    <pre wrap=""><!----><br></pre>
    <blockquote type="cite">
      <pre wrap="">I have attached the unpatched dsdt. To get rid of acpi error <br>messages, I <br>removed offending "Name()" lines. Please let me know if this is the <br>appropriate fix. As I said, it doesn't boot with the original <br>dsdt either.<br></pre>
      </blockquote>
      <pre wrap=""><!----><br>I have an SCB2 system, whose ASL looks pretty similar to yours -- even some<br>of the same ASL problems. It boots for me with an SMP but not UP kernel.<br><br>Which are you trying?</pre>
      </blockquote>
Since the machine has 2 CPUs, the kernel is configured for SMP.<br>
      <blockquote type="cite" cite="mid:EDC461A30AC4D511ADE10002A5072CAD0236DE96-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org">
        <pre wrap=""><br><br>If UP, can you please try this ASL change?<br><br>Search for this:<br><br>    Method(GETI, 1) {<br>        If(And(Arg0, 0xf, )) {<br>            Return(Zero)<br>        }<br>        Else {<br>            Return(\MLIB.CNV2(And(Arg0, 0xf, )))<br>        }<br>    }<br><br>And swap the contents of the if/else.<br><br>The Name() lines emit a warning but are harmless.<br><br>If you're having troubles in SMP mode, then I guess that is not shared<br>between our two platforms...<br><br>Thanks -- Regards -- Andy<br><br></pre>
        </blockquote>
With regards to Matthew Wilcox's comments: I have tried with 2.4.20-pre7
without the acpi patch, and the machine boots there, and interrupts are assigned
correctly (having ACPI config switched on for the kernel). However, the ACPI
driver load fails as I posted in an earlier message.<br>
        <br>
Although I'm not running in uniprocessor mode, I still tried your ASL fix
above, and the IRQ assignment has changed (see below), although the system
still wouldn't boot (neither does it when I use pci=noacpi).<br>
        <br>
Does the interrupt assignment look reasonable to you? Do you have any more
ASL fixes to suggest?<br>
        <br>
Thanks,<br>
Bernd<br>
        <br>
        <br>
//<br>
// ----------------------------- THIS IS THE INTERRUPT DISTRIBUTION WHEN
BOOTING WITH ACPI=OFF ----------------------<br>
// (system boots successfully)<br>
        <br>
ACPI: Subsystem revision 20020918<br>
ACPI: Disabled via command line (acpi=off)<br>
PCI: PCI BIOS revision 2.10 entry at 0xfda65, last bus=1<br>
PCI: Using configuration type 1<br>
PCI: Probing PCI hardware<br>
PCI: ACPI tables contain no PCI IRQ routing entries<br>
PCI: Probing PCI hardware (bus 00)<br>
PCI: Discovered primary peer bus 01 [IRQ]<br>
PCI-&gt;APIC IRQ transform: (B0,I4,P0) -&gt; 23<br>
PCI-&gt;APIC IRQ transform: (B0,I7,P0) -&gt; 17<br>
PCI-&gt;APIC IRQ transform: (B0,I8,P0) -&gt; 16<br>
PCI-&gt;APIC IRQ transform: (B0,I15,P0) -&gt; 10<br>
PCI-&gt;APIC IRQ transform: (B1,I4,P0) -&gt; 24<br>
PCI-&gt;APIC IRQ transform: (B1,I4,P1) -&gt; 25<br>
        <br>
//<br>
// ---------------------------- THIS IS WITH 2.4.20-pre7 + acpi patch + above
DSDT fix -----------------------------------------------------------------<br>
//(kernel panic)<br>
        <br>
        <br>
Waiting on wait_init_idle (map = 0x2)<br>
All processors have done init_idle<br>
ACPI: Subsystem revision 20020918<br>
PCI: PCI BIOS revision 2.10 entry at 0xfda65, last bus=1<br>
PCI: Using configuration type 1<br>
&nbsp;&nbsp;&nbsp; ACPI-0273: *** Info: Table [DSDT] replaced by host OS<br>
&nbsp;&nbsp;&nbsp; ACPI-0217: *** Warning: Invalid type (Integer) for target of Scope operator
        <br>
[DEB_], changing type to ANY<br>
..<br>
.. (LOTS OF THESE WARNINGS....)<br>
.. &nbsp; <br>
[BIOS], changing type to ANY<br>
&nbsp;&nbsp;&nbsp; ACPI-0490: *** Warning: Invalid type (Integer) for target of Scope operator
        <br>
[CMOS], changing type to ANY<br>
ACPI: Interpreter enabled<br>
ACPI: Using IOAPIC for interrupt routing<br>
ACPI: System [ACPI] (supports S0 S1 S4 S5)<br>
ACPI: PCI Root Bridge [NRTH] (00:00)<br>
PCI: Probing PCI hardware (bus 00)<br>
ACPI: PCI Root Bridge [PCI1] (00:00)<br>
ACPI: PCI Interrupt Link [LN00] (IRQs 3 4 *5 7 9 11 12 14 15)<br>
ACPI: PCI Interrupt Link [LN01] (IRQs 3 4 5 7 9 11 12 14 15, enabled at IRQ
10)<br>
ACPI: PCI Interrupt Link [LN02] (IRQs 3 4 5 7 9 11 12 14 15, disabled)<br>
ACPI: PCI Interrupt Link [LN03] (IRQs 3 4 5 7 9 11 12 14 15, disabled)<br>
ACPI: PCI Interrupt Link [LN04] (IRQs 3 4 5 7 9 11 12 14 15, disabled)<br>
ACPI: PCI Interrupt Link [LN05] (IRQs 3 4 5 7 9 11 12 14 15, disabled)<br>
ACPI: PCI Interrupt Link [LN06] (IRQs 3 4 5 7 9 11 12 14 15, disabled)<br>
ACPI: PCI Interrupt Link [LN07] (IRQs 3 4 5 7 9 *11 12 14 15)<br>
ACPI: PCI Interrupt Link [LN08] (IRQs *3 4 5 7 9 11 12 14 15)<br>
ACPI: PCI Interrupt Link [LN09] (IRQs 3 4 5 7 *9 11 12 14 15)<br>
ACPI: PCI Interrupt Link [LN10] (IRQs 3 4 5 7 9 11 12 14 15, disabled)<br>
ACPI: PCI Interrupt Link [LN11] (IRQs 3 4 5 7 9 11 12 14 15, disabled)<br>
ACPI: PCI Interrupt Link [LN12] (IRQs 3 4 5 7 9 11 12 14 15, disabled)<br>
ACPI: PCI Interrupt Link [LN13] (IRQs 3 4 5 7 9 11 12 14 15, disabled)<br>
ACPI: PCI Interrupt Link [LN14] (IRQs 3 4 5 7 9 11 12 14 15, disabled)<br>
ACPI: PCI Interrupt Link [LN15] (IRQs 3 4 5 7 9 11 12 14 15, disabled)<br>
ACPI: PCI Interrupt Link [LNUS] (IRQs *10)<br>
PCI: Probing PCI hardware<br>
ACPI: PCI Interrupt Link [LN02] enabled at IRQ 11<br>
ACPI: PCI Interrupt Link [LN03] enabled at IRQ 9<br>
ACPI: PCI Interrupt Link [LN04] enabled at IRQ 5<br>
ACPI: PCI Interrupt Link [LN05] enabled at IRQ 11<br>
ACPI: PCI Interrupt Link [LN06] enabled at IRQ 9<br>
ACPI: PCI Interrupt Link [LN10] enabled at IRQ 5<br>
ACPI: PCI Interrupt Link [LN11] enabled at IRQ 11<br>
ACPI: PCI Interrupt Link [LN12] enabled at IRQ 9<br>
ACPI: PCI Interrupt Link [LN13] enabled at IRQ 5<br>
ACPI: PCI Interrupt Link [LN14] enabled at IRQ 11<br>
ACPI: PCI Interrupt Link [LN15] enabled at IRQ 9<br>
PCI: Using ACPI for IRQ routing<br>
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off<br>
        <br>
        <br>
Eventually kernel panic because SCSI disk driver load fails due to irq mismatch<br>
        <br>
        <br>
        </body>
        </html>

--Boundary_(ID_qkrj82bf4BvZUt2pbboHmg)--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
