From: FrAnKenstEin <fake-3RXyrymLNR0b1SvskN2V4Q@public.gmane.org>
Subject: Re: ACPI patches updated (20021111)
Date: Wed, 13 Nov 2002 21:52:08 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021113205208.GA30683@apollo.bingo-ev.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

i accidentaly only mailed the following mail to Andrew Grover, who will now
get it twice. sorry ;-)

On Tue, Nov 12, 2002 at 12:48:45PM -0800, Grover, Andrew wrote:
... 
> If you've been having problems with reading battery or other information
> being very slow, please try this release and report if problems persist.

they do. i wrote a mail regarding my compaq armada 110's battery state 2 
days ago, and gathered further information since then.

wether i override my dsdt with a fixed one does no longer seem to have an 
influence on this (which i found out after compiling 2.5.47 vanilla and 
seeing BAT1 without changes) problem. I fixed the things mentioned on the 
cpqlinux-page... maybe there's more wrong code in there.

i freshly boot my machine, log in and fire a :
cat /proc/acpi/battery/BAT1/state 
---------------- snip, snap ----------------------
	present:                 yes
	capacity state:          ok
	charging state:          discharging
	present rate:            unknown
	remaining capacity:      4864 mWh
	present voltage:         12548 mV
---------------- snip, snap ----------------------

fine! these values are correct! except the charging state - which should be
'unknown', as i am fully charged at my ac/adaptor.

let's do that again:
---------------- snip, snap ----------------------
	present:                 yes
	capacity state:          ok
	charging state:          unknown
	present rate:            unknown
	remaining capacity:      0 mWh
	present voltage:         11000 mV
---------------- snip, snap ----------------------
and this is what it remains like, everytime i try to access it.
notice that the charging state is now correct...
now... i unplug my ac/adaptor:
---------------- snip, snap ----------------------
	present:                 yes
	capacity state:          ok
	charging state:          unknown
	present rate:            unknown
	remaining capacity:      4864 mWh
	present voltage:         12540 mV

---------------- snip, snap ----------------------
note that the extra newline is there intentionally - it really is
on my console. sometimes theres even an extra mV on that line, preceeded by
only a space. the values are correct again (just the 'state' is wrong, 
should be 'discharging') but i care specifically about the remaning 
capacity. again, if i try again:
---------------- snip, snap ----------------------
	present:                 yes
	capacity state:          ok
	charging state:          discharging
	present rate:            unknown
	remaining capacity:      56797 mWh
	present voltage:         11000 mV
---------------- snip, snap ----------------------
the extra newline is gone, and the remaining capacity value starts counting
down from 65535 (too fast to represent relative capacity) to 0. chargestate
is correct.
plug in the ac cord again:
---------------- snip, snap ----------------------
	present:                 yes
	capacity state:          ok
	charging state:          discharging
	present rate:            unknown
	remaining capacity:      4785 mWh
	present voltage:         12140 mV
---------------- snip, snap ----------------------
again, the capacity value is correct, but the state is wrong (should be
'charging'). on the next one, this value is correct, but capacity is wrong:
---------------- snip, snap ----------------------
	present:                 yes
	capacity state:          ok
	charging state:          charging
	present rate:            unknown
	remaining capacity:      47031 mWh
	present voltage:         11000 mV
---------------- snip, snap ----------------------
i think you got the idea.

now, my question is: has somebdy encountered something like this before?
if yes, has it been fixed and how? (if no, why not? ;)
if no, where will i have to look? i already digged deeper into my dsdt,
but it _seems_ to be ok...

ah, yeas, the thermal zone is always 50C. but i don't care about that for
now, i just want to know how much time/mWh i have left when i am 'in the
field' ;)

thanks in advance for your time!
Thomas Jakobi

p.s.: the dsdt is on http://fake.bchat.net/laptop/dsdt-fixed
      and http://fake.bchat.net/laptop/dsdt-original

p.p.s.: to be complete, here the acpi-part of my dmesg:

---------------- snip, snap ----------------------
ACPI: Subsystem revision 20021111
   tbget-0274: *** Info: Table [DSDT] replaced by host OS
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully acquired
Parsing Methods:..........................................................................................................................
Table [DSDT] - 406 Objects with 39 Devices 122 Methods 13 Regions
ACPI Namespace successfully loaded at root c042e47c
evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode successful
 evevent-0508: *** Info: GPE Block0 defined as GPE0 to GPE15
Executing all Device _STA and_INI methods:.........[ACPI Debug] String: --------- VIA SOFTWARE SMI PMIO 2Fh ------------
[ACPI Debug] String: --------- VIA SOFTWARE SMI PMIO 2Fh ------------
..............................
39 Devices found containing: 39 _STA, 3 _INI methods
Completing Region/Field/Buffer/Package initialization:.................................................
Initialized 7/13 Regions 1/1 Fields 22/22 Buffers 19/19 Packages (406 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: (supports S0 S1 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Address space collision on region 9 of device VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] [8080:808f]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *9 11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 9 *11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs *9 11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 9 *11 12)
ACPI: Embedded Controller [EC0] (gpe 1)
ACPI: Power Resource [PLPC] (on)
pci_bind-0191 [05] acpi_pci_bind         : Device 00:00:07.06 not present in PCI namespace
---------------- snip, snap ----------------------
[...]
---------------- snip, snap ----------------------
[ACPI Debug] String: --------- VIA SOFTWARE SMI PMIO 2Fh ------------
[ACPI Debug] String: INIT BATO in acad.psr
[ACPI Debug] String: INIT BATO in acad.psr
ACPI: AC Adapter [ACAD] (on-line)
[ACPI Debug] String: --------- VIA SOFTWARE SMI PMIO 2Fh ------------
[ACPI Debug] String: INIT BATO at BAT1._STA
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1 C2)
[ACPI Debug] String: ========= BAT1 UPBI =========
[ACPI Debug] String: ---NO ACEV check charging/discharge
[ACPI Debug] String: ---NO ACEV Set Power State as discharging
ACPI: Thermal Zone [THRM] (50 C)
---------------- snip, snap ----------------------





-------------------------------------------------------
This sf.net email is sponsored by: Are you worried about 
your web server security? Click here for a FREE Thawte 
Apache SSL Guide and answer your Apache SSL security 
needs: http://www.gothawte.com/rd523.html
