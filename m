From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: _PRT question
Date: Mon, 14 Jul 2003 15:00:29 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307141500.29354.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi, I've found something I do not understand about the _PRT method. In my 
BIOS, I have the following:

Scope(\) {
    Name(PICF, 0x0)
    Method(_PIC, 1) {
        Store(Arg0, PICF)
    }
}
....
Device(PCI0) {
    ....
    Name(PICM, Package(0x14) {
        Package(0x4) {
            0x0001ffff,
            0x0,
            LSMB,
            0x0,
        },
        ....
    }

    Name(APIC, Package(0xc) {
        Package(0x4) {
            0x0001ffff,
            0x0,
            \_SB_.PCI0.APCS,
            0x0,
        },
        ....
    }

    Method(_PRT) {
        If(LNot(PICF)) {
            Return(PICM)
        }
        Else {
            Return(APIC)
        }
   }
}

To my understanding, _PRT switches on the PICF flag. If it is 0 (PIC mode), 
the PICM package is returned. If it is 1 (APIC mode), the APIC package is 
returned.

Why is it then I see the following in my dmesg:
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
...
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 10 11 12 14 15, disabled)
...
ACPI: PCI Interrupt Link [APCS] (IRQs 23, disabled)


In fact, I see all the link devices from both the PICM and the APIC packages. 
How is this possible? _PIC is only called once from 
bus.c/apic_bus_init_irq(). 

As far as I can see, the only way you could get the behaviour I see would be 
to call _PIC(0), then _PRT, then _PIC(1), then _PRT. But this doesn't seem to 
occur.

There are no other references to the LSMB link device in my BIOS.

Can someone tell me what is happening here?



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
