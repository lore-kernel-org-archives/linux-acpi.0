From: Thomas Renninger <mail-smMupaH/RwJM7kwft8N7nw@public.gmane.org>
Subject: Re: Problem fixing DSDT (parse error)
Date: Tue, 30 Nov 2004 17:12:08 +0100
Message-ID: <41AC9BD8.9050604@renninger.de>
References: <web-25326080@infinito.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <web-25326080-97W46K3QqA41GQ1Ptb7lUw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: mrfree-97W46K3QqA41GQ1Ptb7lUw@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

mrfree-97W46K3QqA41GQ1Ptb7lUw@public.gmane.org wrote:
> Hi all,
> I've already fixed some other dsdt some month ago using DSDT-Howto from 
> acpi.sf.net site.
> But now I need to fix this parse error:

As far as I know this is how it should look like, putting the IF 
statements into an _INI method (please correct me if I am wrong):


Scope (\_SB)

{
     Method (_INI, 0, NotSerialized)
     {		
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
     }	

     Scope (PCI0)
	
         {

             Name (CRS, ResourceTemplate ()

             {

                 WordBusNumber (ResourceProducer, MinFixed, MaxFixed, 
PosDecode,

                     0x0000,

                     0x0000,

                     0x00FF,

                     0x0000,

                     0x0100)

                 IO (Decode16, 0x0CF8, 0x0CF8, 0x01, 0x08)

                 WordIO (ResourceProducer, MinFixed, MaxFixed, 
PosDecode, EntireRange,

                     0x0000,

                     0x0000,

                     0x0CF7,

                     0x0000,

                     0x0CF8)

                 WordIO (ResourceProducer, MinFixed, MaxFixed, 
PosDecode, EntireRange,

                     0x0000,

                     0x0D00,

                     0xFFFF,

                     0x0000,

                     0xF300)

                 DWordMemory (ResourceProducer, PosDecode, MinFixed, 
MaxFixed, Cacheable, ReadWrite,

                     0x00000000,

                     0x000A0000,

                     0x000BFFFF,

                     0x00000000,

                     0x00020000)

                 DWordMemory (ResourceProducer, PosDecode, MinFixed, 
MaxFixed, Cacheable, ReadWrite,

                     0x00000000,

                     0x00000000,

                     0x00000000,

                     0x00000000,

                     0x00000000)

                 DWordMemory (ResourceProducer, PosDecode, MinFixed, 
MaxFixed, Cacheable, ReadWrite,

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


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
