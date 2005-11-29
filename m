From: marcus hall <marcus-sbVGQhmTrokdnm+yROfE0A@public.gmane.org>
Subject: Problem with address space handler
Date: Tue, 29 Nov 2005 09:04:40 -0700
Message-ID: <20051129160440.GA27678@bastille.tuells.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Hello..

I am attempting to run a driver that listens to hardware buttons via the
ACPI system.  This driver works in the 2.4.20 kernel, but I am attempting
to get it to run on 2.4.28.  There were a lot of ACPI changes between these
two kernels, and I'm aparently missing something..

First off, I have aparently successfully created my struct acpi_driver
structure, as the .add method from that structure is invoked after I
call acpi_bus_register_driver().  From the add method I call
acpi_install_address_space_handler(), passing it the handle field from
the device pointer passed in, 0x81 for the address (see the DSDT excerpt
below), my handler and setup functions, and the device pointer.  The return
value from acpi_bus_register_driver() is zero (AE_OK).

The problem is that I never see my handler function called, and the only
time I see the setup function called is when I remove the driver and
call acpi_remove_address_space_handler(), when my setup function is
called with function==ACPI_REGION_DEACTIVATE.

I suspect that I have to do something to activate some part of ACPI to
call me back, either to enable the button interrupt or something, but I
don't know enough about ACPI's internals to figure that out yet.   I would
appreciate any pointers to places to look..

I believe that the following dsdt extract is the significant part (I can
supply whatever I may have missed if it would help).  As I "understand"
it, the code creates a region with id "ASIM0000" (my .id in struct
acpi_driver) with various bytes specified (one for each button, and then
some).  The BNSV method is called on GPE _L15 interrupt and checks each
bit from a hardware register and writes either 0 or 1 into the region
depending on whether the button is pressed or released.  My driver attempts
to handle this address space and react to writes to process button state
info.

Thanks for any help or suggestions!

Marcus Hall

---  DSDT excerpt  ---

    Scope (_SB)
    {
        Device (ASIM)
        {
            Name (_HID, "ASIM0000")
            Name (_GPE, Zero)
            Name (_UID, Zero)
            OperationRegion (ASI2, 0x81, Zero, 0x00010000)
            Field (ASI2, AnyAcc, Lock, Preserve)
            {
                BNE1,   8, 
                BNE2,   8, 
                BNE3,   8, 
                BNE4,   8, 
                BNEU,   8, 
                BNED,   8, 
                BNEL,   8, 
                BNER,   8, 
                BNEE,   8, 
                BNES,   8, 
                BNEC,   8, 
    ....
	        HDID,   8
            }

            Method (_STA, 0, NotSerialized)
            {
                Return (0x0F)
            }
        }
    }

    Method (BNSV, 2, Serialized)
    {
        BTNQ ()
        If (LNot (LEqual (Arg0, INP0)))
        {
            XOr (Arg0, INP0, Local1)
            Store (Arg0, INP0)
            If (And (Local1, One))
            {
                And (INP0, One, Local0)
                If (LEqual (Local0, One))
                {
                    Store (Zero, \_SB.ASIM.BNSS)
                }
                Else
                {
                    Store (One, \_SB.ASIM.BNES)
                    Store (One, \_SB.ASIM.BNSS)
                }
            }

	....
            If (And (Local1, 0x10))
            {
                And (INP0, 0x10, Local0)
                If (LEqual (Local0, 0x10))
                {
                    Store (Zero, \_SB.ASIM.BNSD)
                }
                Else
                {
                    And (Arg1, 0x10, Local2)
                    If (LEqual (Local2, 0x10))
                    {
                        Store (One, \_SB.ASIM.BNED)
                        Store (One, \_SB.ASIM.BNSD)
                    }
                    Else
                    {
                        If (LGreater (BRSV, Zero))
                        {
                            SBRL (Zero, One)
                            Decrement (BRSV)
                            Store (0x02, \_SB.ASIM.HDID)
                            Store (RBRL (), \_SB.ASIM.BRMX)
                            Store (BRSV, \_SB.ASIM.BRLV)
                        }
                        Else
                        {
                            Store (VSA8 (0x16, 0x34), Local0)
                            If (LEqual (Local0, One))
                            {
                                VSAA (0x16, 0x34, Zero)
                                VSAA (0x16, 0x35, Zero)
                            }
                        }
                    }
                }
            }

            If (And (Local1, 0x20))
            {
                And (INP0, 0x20, Local0)
                If (LEqual (Local0, 0x20))
                {
                    Store (Zero, \_SB.ASIM.BNSR)
                }
                Else
                {
                    And (Arg1, 0x10, Local2)
                    If (LEqual (Local2, 0x10))
                    {
                        Store (One, \_SB.ASIM.BNER)
                        Store (One, \_SB.ASIM.BNSR)
                    }
                    Else
                    {
                        Store (VSA8 (0x16, 0x34), Local0)
                        If (LEqual (Local0, Zero))
                        {
                            VSAA (0x16, 0x34, One)
                            VSAA (0x16, 0x35, One)
                        }

                        While (LLess (BRSV, 0x20))
                        {
                            SBRL (One, One)
                            Increment (BRSV)
                            Store (0x02, \_SB.ASIM.HDID)
                            Store (RBRL (), \_SB.ASIM.BRMX)
                            Store (BRSV, \_SB.ASIM.BRLV)
                        }
                    }
                }
            }

....
        BTNL ()
    }

....

    Scope (_GPE)
    {
        Method (_L05, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB0, 0x02)
        }

        Method (_L06, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB1, 0x02)
        }

        Method (_L14, 0, NotSerialized)
        {
            Notify (\_SB.AC, 0x80)
        }

        Method (_L15, 0, NotSerialized)
        {
            Store (VSA8 (0x16, 0x02), Local0)
            VSAA (0x16, 0x02, Local0)
            Store (VSA8 (0x16, 0x04), Local0)
            ShiftRight (Local0, 0x08, Local1)
            And (Local0, 0xFF, Local0)
            BNSV (Local0, Local1)
        }
    }


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
