From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI EC error
Date: Fri, 6 Dec 2002 13:09:48 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021206120948.GB15153@poup.poupinou.org>
References: <200212030928.gB39ST314290@methusalix.tls-tautenburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200212030928.gB39ST314290-V+qXmaGEZO+gRAseIu28DQq3RYOAlhC/epZhswDD4dQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bringfried Stecklum <stecklum-1rBFpveLbu3Y+tFAy8B5R7NAH6kLmebB@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, stecklum-V+qXmaGEZO+gRAseIu28DQq3RYOAlhC/epZhswDD4dQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Dec 03, 2002 at 10:28:29AM +0100, Bringfried Stecklum wrote:
> I've got ACPI Subsystem revision 20020918 partly working with the 2.4.19 kernel.
> Since several debug messages occured during boot time, I tried Subsystem revision
> 20021122 together with 2.4.20. However, the result is the same as you cna see below

[...]

> <4>Completing Region/Field/Buffer/Package initialization:..................................................
> <4>Initialized 10/14 Regions 0/0 Fields 18/18 Buffers 22/22 Packages (519 nodes)
> <6>ACPI: Interpreter enabled
> <6>ACPI: Using PIC for interrupt routing
> <6>ACPI: System [ACPI] (supports S0 S3 S4 S5)
> <6>ACPI: PCI Root Bridge [PCI0] (00:00)
> <4>PCI: Probing PCI hardware (bus 00)
> <4>Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
> <7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> <7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
> <7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
> <4>pci_bind-0194 [05] acpi_pci_bind         : Device 00:02:09.00 not present in PCI namespace
> <4>ACPI: PCI Interrupt Link [LNKA] (IRQs *11)
> <4>ACPI: PCI Interrupt Link [LNKB] (IRQs *11)
> <4>ACPI: PCI Interrupt Link [LNKC] (IRQs *5)
> <4>ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
> <6>ACPI: Embedded Controller [EC] (gpe 28)
> <4>[ACPI Debug] String: _____________
> <4>[ACPI Debug] String: |           |
> <4>[ACPI Debug] String: |  EC._REG  |
> <4>[ACPI Debug] String: |  Arg0=    
> <4>[ACPI Debug] Integer: 0000000000000003
> <4>[ACPI Debug] String: |  Arg1=    
> <4>[ACPI Debug] Integer: 0000000000000001
> <4>[ACPI Debug] String: |___________|

If you disassemble your dsdt with (f.e.) 'iasl -d', you will see

                Device (EC)
                {
                    Name (_HID, EisaId ("PNP0C09"))
                    Name (_GPE, 0x1C)
                    Name (ECOK, 0x00)
                    Method (_REG, 2, NotSerialized)
                    {
                        Store ("_____________", Debug)
                        Store ("|           |", Debug)
                        Store ("|  EC._REG  |", Debug)
                        Store ("|  Arg0=    ", Debug)
                        Store (Arg0, Debug)
                        Store ("|  Arg1=    ", Debug)
                        Store (Arg1, Debug)
                        Store ("|___________|", Debug)
                        If (LEqual (Arg0, 0x03))
                        {
                            Store (Arg1, ECOK)
                        }
                    }

ACPI EC driver will call the _REG method in order to allow
the Operational Region to be accessed by the whole system (some
EC need to be 'initialized' by this method).  Those debug statements
then go in your log.  This is harmless.

The OR in question are the following lines:

                    OperationRegion (RAM, EmbeddedControl, 0x00, 0xFF)
                    Field (RAM, AnyAcc, Lock, Preserve)
                    {
                        NMSG,   8, 
                        SLED,   5, 
                        Offset (0x02), 
                        MODE,   1, 
                        FAN0,   1, 
...

BTW, the 'Field (RAM, AnyAcc, Lock, Preserve)' should be
		Field (RAM, ByteAcc, Lock, Preserve)
                            ^^^^^^^

but it should be OK however since Feb 2002.


[...]
> <4>acpi_thermal-0313 [13] acpi_thermal_get_trip_: Invalid passive threshold

I don't see any error in your DSDT here.  I have to invastigate a bit
more why you have such statement.  I will send you privately some tools
for such debuging.

BTW, there is no support for fan controls in your DSDT, but it look like
that actually you can do have some controls via the EC.  I can help you in
that area if you wish.

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
