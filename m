From: William Morgan <wmorgan-acpi-devel-xW3KcqxHEMnk1uMJSBkQmQ@public.gmane.org>
Subject: Re: Re: acpi on new gateway laptops
Date: Thu, 20 Nov 2003 16:42:29 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031120214228.GD21802@masanjin.net>
References: <20031112232315.GD430@masanjin.net> <20031112233328.GE430@masanjin.net> <20031113001013.GE32464@poupinou.org> <20031113170333.GA2336@masanjin.net> <20031118151139.GA32464@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031118151139.GA32464-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
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

Excerpts (reformatted) from Ducrot Bruno's mail of 18 Nov 2003 (EST):
> Well, I forgot that ECDT support is somewhat still buggy.  Here is anyway
> a patch, but for 2.4.23-rc1.

Ducrot,

Thanks for the patch. I will try it presently.

In the mean time I've hacked up an ECDT and tried inserting it at boot time
by saying, in drivers/acpi/osl.c:

        *new_table = NULL;
        if (strncmp(existing_table->signature,"ECDT",4) != 0) {
                printk(KERN_INFO PREFIX "overriding ECDT definition\n");
                *new_table = (struct acpi_table_header *)ecdt_table;
        }

However, at boot time, I get the following in dmesg:

ACPI: overriding ECDT definition
   tbget-0292: *** Info: Table [ECDT] replaced by host OS
  tbrsdt-0227: *** Error: Invalid signature where RSDP indicates RSDT/XSDT should be located
RSDT/XSDT signature at 1F6E7D39 (1f6e7d39) is invalid

So obviously I'm doing something wrong.

The ECDT looks like this:

/*
 * ECDT table for Gateway laptops circa 2003
 * 
 * header:
 *   signature "ECDT"
 *   length: 86
 *   revision: 0x1
 *   checksum: 0x74
 *   oem_id: "mkecdt"
 *   oem_table_id: "ecdt0001"
 *   oem_revision: 0x1
 *   asl_compiler_id: "none"
 *   asl_compiler_revision: 0
 * ec_control:
 *   address_space_id: 0x1
 *   address_space_bit_width: 0x8
 *   register_bit_offset: 0
 *   reserved (should be 0): 0
 *   address: 0x66
 * ec_data:
 *   address_space_id: 0x1
 *   address_space_bit_width: 0x8
 *   register_bit_offset: 0
 *   reserved (should be 0): 0
 *   address: 0x62
 * uid: 0
 * gpe: 0x1c
 * ec_id: "\_SB_.PCI0.LPCB.H_EC"
 * compute checksum: passed
*/

unsigned char ecdt_table[]= {
	0x45, 0x43, 0x44, 0x54, 0x56, 0x00, 0x00, 0x00, 0x01, 0x74, 0x6d, 0x6b, 0x65, 0x63, 0x64, 0x74,
	0x65, 0x63, 0x64, 0x74, 0x30, 0x30, 0x30, 0x31, 0x01, 0x00, 0x00, 0x00, 0x6e, 0x6f, 0x6e, 0x65,
	0x00, 0x00, 0x00, 0x00, 0x01, 0x08, 0x00, 0x00, 0x66, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x01, 0x08, 0x00, 0x00, 0x62, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x1c, 0x5c, 0x5f, 0x53, 0x42, 0x5f, 0x2e, 0x50, 0x43, 0x49, 0x30, 0x2e, 0x4c, 0x50, 0x43, 0x42,
	0x2e, 0x48, 0x5f, 0x45, 0x43, 0x00, 
};

So maybe I'll just try your patch.

-- 
William 


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
