From: "vincent.legarrec" <vincent.legarrec-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>
Subject: RE: Impossible to compile iasl
Date: Sat, 27 Nov 2004 08:57:34 +0100
Message-ID: <20041127075656.BF4B118000A1@mwinf0507.wanadoo.fr>
References: <41A789D9.4000804@student.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41A789D9.4000804-oe7qfRrRQfeEZXFvZSAUrfP6llvjuJOh@public.gmane.org>
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

This message is principally for the archive because it's a summary that I
did.

Now I have the charge of my battery. 

Before re-build the kernel I had coping dsdt.hex to drivers/acpi/

The message which said ACPI: acpi_ec_space_handler: bit_width should be 8
was totally exact because I needed to replace the line 
Field (ECR, DWordAcc, Lock, Preserve)
By 
Field (ECR, ByteAcc, Lock, Preserve)
I've enough one warning but the problem have been solved so I ignore it.
And I have follow the instruction from
http://www.linux-on-laptops.com/hosted/LinuxOnSamsungX10plus which say :

You must have ACPI enabled (regardless of that it will not work yet) to
access the broken vendor table 

     > cat /proc/acpi/dsdt > dsdt.dat
  
disassemble the table 

     > iasl -d dsdt.dat
  
now reassemble the table which also performs a check and shows warnings and
errors 

     > iasl -tc dsdt.dsl
   
fix the code (I included the file dsdt.dsl-fixed which works for me) 

Finally you have to modify the file drivers/acpi/osl.c in the kernel sources
(see below) to use your new corrected table 

#include "dsdt.hex"  // include your fixed table

// search for function acpi_os_table_override() in osl.c and modify
// the assignment of new_table

        if (strncmp(existing_table->signature, DSDT_SIG,4)) {
          *new_table = NULL;
        } else {
          *new_table = (struct acpi_table_header *) AmlCode;
          printk(KERN_INFO PREFIX "use fixed DSDT\n");
        }



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
