From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: Located the problem with the VIA KT400 board
Date: Mon, 14 Jul 2003 02:08:07 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307140208.07975.adq_dvb@lidskialf.net>
References: <200307122352.45704.adq_dvb@lidskialf.net> <20030713053913.GB1284@middle.of.nowhere> <200307140051.29231.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200307140051.29231.adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: thunder7-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi, I think I've just spotted the problem, and unfortunately, I think it is an 
AML problem.

When your board boots, several devices are configured without IRQs set (i.e. 
the IRQ returned by _CRS is 0) (I think this is called "boot disabled 
devices"). They have a list of possible IRQs (all of them > 15) in _PRS.

The linux code for setting an IRQ is in 
drivers/acpi/pci_link.c/acpi_pci_link_set().
Theres a wee fix to make in here for my patch for the polarity etc, but your 
problem is when it creates the resource entry to send to the _SRS method.

It does something like:
if (irq <= 15) {
  ... create an IRQ resource
} else {
  ... create an extended IRQ resource
}

However, the _SRS code in your BIOS has the following for the relevant 
devices:

            Method(_SRS, 1) {
                CreateByteField(Arg0, 0x1, IRD1)
                CreateByteField(Arg0, 0x2, IRD2)
                ShiftLeft(IRD2, 0x8, Local0)
                Or(Local0, IRD1, Local0)
                Store(0x0, Local1)
                ShiftRight(Local0, 0x1, Local0)
                While(LGreater(Local0, 0x0)) {
                    Increment(Local1)
                    ShiftRight(Local0, 0x1, Local0)
                }
                And(PIRD, 0xf, PIRD)
                ShiftLeft(Local1, 0x4, Local1)
                Or(PIRD, Local1, PIRD)
            }

This assumes the resource passed to it is a normal IRQ resource, and cannot 
cope with extended ones. It only checks bytes 1&2 of the argument. For an 
extended argument, it would have to check bytes 5,6,7,8.

In linux, the call to acpi_pci_link_set() from acpi_pci_link_check() does not 
check the return status of the call. Otherwise this error would be detected.



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
