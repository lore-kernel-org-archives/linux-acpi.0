From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: Re: ACPI ignoring IRQ flags in PRT
Date: Sun, 13 Jul 2003 17:45:41 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307131745.42153.adq_dvb@lidskialf.net>
References: <200307131452.39000.adq_dvb@lidskialf.net> <20030713142321.GC20424@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030713142321.GC20424-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sunday 13 July 2003 15:23, Matthew Wilcox wrote:
> On Sun, Jul 13, 2003 at 02:52:38PM +0100, Andrew de Quincey wrote:
> > Hi, from my understanding of the ACPI spec, each IRQ as specified in the
> > _PRT has additional flags associated with it (e.g. specifying the
> > polarity, level etc) that should be used for this IRQ.
> >
> > The Linux ACPI code seems to be ignoring these, and hardcodes them to the
> > values that cause problems for me. Is there a reason, or has that code
> > just not been written yet?
>
> you can't mean the _PRT.  the _PRT describes PCI interrupts, and those
> have their polarity and trigger specified by the PCI spec.  i suspect you
> mean someting else, but i'm not sure what.  can't be the SCI interrupt
> since that's defined to be level, low, sharable.
>
> some of the ia64 acpi code pays attention to polarity and edge vs level.
> now that we know this is an issue on x86, maybe some more people will be
> interested in thinking about how to fix this properly.  here's what we
> currently have on ia64:
>
> int acpi_register_irq (u32 gsi, u32 polarity, u32 trigger);

On my system, each _PRT entry points to a NamePath giving the "name of the 
device that allocates the interrupt to which the above pin is connected". It, 
in turn points to an IRQ resource descriptor. Byte 3 of IRQ resource 
descriptors contain flags giving sharability, the polarity, mode 
(level/edge). So it is theoretically feasible to specify them.

My USB devices are definitely PCI devices. They work fine when they're 
allocated to ISA IRQs (i.e. active high). When they're allocated to "PCI" 
(i.e. >15) IRQs by linux they do not work, yet the _PRT tables in ACPI 
specify IRQs 20,21, and 22. When I hardcode all the "PCI" IRQs to be active 
high, they start working again. 

It all works fine in Windows, and my USB devices are allocated IRQs 20,21,22.

The _PRT entry for one of my USB devices is:

            Package(0x4) {
                0x0002ffff,
                0x0,
                \_SB_.PCI0.APCF,
                0x0,
            },

The corresponding device is:

        Device(APCF) {
            Name(_HID, 0x0f0cd041)
            Name(_UID, 0x10)
            Method(_STA) {
                If(INTG) {
                    Return(0xb)
                }
                Else {
                    Return(0x9)
                }
            }
            Method(_PRS) {
                Return(BUFF)
            }
            Method(_DIS) {
                Store(0x0, INTG)
            }
            Method(_CRS) {
                Return(CRSA(INTG))
            }
            Method(_SRS, 1) {
                Store(SRSA(Arg0), INTG)
            }
        }

And the actual raw descriptor data is:

Name(BUFF, Buffer(0x13) {0x89, 0xe, 0x0, 0x9, 0x3, 0x14, 0x0, 0x0, 0x0, 0x15, 
0x0, 0x0, 0x0, 0x16, 0x0, 0x0, 0x0, 0x79, 0x0 })

Byte 3 here (00001001) specifies the flags:
bit[0]==1 -- The device consumes the resource
bit[1]==0 -- Level triggered
bit[2]==0 -- Active High
bit[3]==1 -- Sharable
bit[4-7] -- reserved (set to 0)

The IRQs specified are 20,21,22.

So, the code in io_apic.c is assuming that all IRQs > 15 are PCI-compatable. 
For me, at least, they are not, *EVEN THOUGH they're in the _PRT*. The ACPI 
tables are describing them as I have experimentally found them to be.



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
