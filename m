From: <mrfree-97W46K3QqA41GQ1Ptb7lUw@public.gmane.org>
Subject: Problem fixing DSDT (parse error)
Date: Tue, 30 Nov 2004 12:50:57 +0100
Message-ID: <web-25326080@infinito.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi all,
I've already fixed some other dsdt some month ago using 
DSDT-Howto from acpi.sf.net site.
But now I need to fix this parse error:

dsdt.dsl.orig  3081:     If (SS1)
Error    1037 -           ^ parse error

This is the dsdt part (a block code before and one after 
If (SS1) ):
[...]
Scope (\_SB)

     {

         Scope (PCI0)

         {

             Name (CRS, ResourceTemplate ()

             {

                 WordBusNumber (ResourceProducer, 
MinFixed, MaxFixed, PosDecode,

                     0x0000,

                     0x0000,

                     0x00FF,

                     0x0000,

                     0x0100)

                 IO (Decode16, 0x0CF8, 0x0CF8, 0x01, 0x08)

                 WordIO (ResourceProducer, MinFixed, 
MaxFixed, PosDecode, EntireRange,

                     0x0000,

                     0x0000,

                     0x0CF7,

                     0x0000,

                     0x0CF8)

                 WordIO (ResourceProducer, MinFixed, 
MaxFixed, PosDecode, EntireRange,

                     0x0000,

                     0x0D00,

                     0xFFFF,

                     0x0000,

                     0xF300)

                 DWordMemory (ResourceProducer, PosDecode, 
MinFixed, MaxFixed, Cacheable, ReadWrite,

                     0x00000000,

                     0x000A0000,

                     0x000BFFFF,

                     0x00000000,

                     0x00020000)

                 DWordMemory (ResourceProducer, PosDecode, 
MinFixed, MaxFixed, Cacheable, ReadWrite,

                     0x00000000,

                     0x00000000,

                     0x00000000,

                     0x00000000,

                     0x00000000)

                 DWordMemory (ResourceProducer, PosDecode, 
MinFixed, MaxFixed, Cacheable, ReadWrite,

                     0x00000000,

                     0x00000000,

                     0x00000000,

                     0x00000000,

                     0x00000000)

             })

             CreateDWordField (CRS, 0x5C, MIN5)

             CreateDWordField (CRS, 0x60, MAX5)

             CreateDWordField (CRS, 0x68, LEN5)

             CreateDWordField (CRS, 0x76, MIN6)

             CreateDWordField (CRS, 0x7A, MAX6)

             CreateDWordField (CRS, 0x82, LEN6)

             Method (_CRS, 0, NotSerialized)

             {

                 Store (MG1B, MIN5)

                 Store (MG1L, LEN5)

                 Store (MG1L, Local0)

                 If (Local0)

                 {

                     Add (MIN5, Decrement (Local0), MAX5)

                 }



                 Store (MG2B, MIN6)

                 Store (MG2L, LEN6)

                 Store (MG2L, Local0)

                 Add (MIN6, Decrement (Local0), MAX6)

                 Return (CRS)

             }

         }

     }



     If (SS1)

     {

         Name (\_SB.PCI0._S1D, 0x02)

         Name (\_SB.PCI0.P0P2._S1D, 0x02)

         Name (\_SB.PCI0.USB1._S1D, 0x02)

         Name (\_SB.PCI0.USB2._S1D, 0x02)

         Name (\_SB.PCI0.USB3._S1D, 0x02)

     }



     If (SS3)

     {

         Name (\_SB.PCI0._S3D, 0x02)

         Name (\_SB.PCI0.P0P2._S3D, 0x02)

         Name (\_SB.PCI0.USB1._S3D, 0x02)

         Name (\_SB.PCI0.USB2._S3D, 0x02)

         Name (\_SB.PCI0.USB3._S3D, 0x02)

     }
[...]

Any ideas???

PS: If you want I need to post all code
_______________________________________
Connessione ed e-mail gratuita da 10 mb
consultabile tramite web e tramite pop.
www.infinito.it vieni a scoprire tutti 
i nostri servizi!

http://www.infinito.it/xmail



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
