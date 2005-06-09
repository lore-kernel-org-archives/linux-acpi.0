From: Klaus Muth <muth-5lHx5lHeYlQ@public.gmane.org>
Subject: Re: ACPI: RSDP - ERROR: Invalid checksum
Date: Thu, 9 Jun 2005 11:13:13 +0200
Message-ID: <200506091113.14327.muth@hagos.de>
References: <200506071546.57120.muth@hagos.de> <200506081529.49355.muth@hagos.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200506081529.49355.muth-5lHx5lHeYlQ@public.gmane.org>
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

Am Mittwoch, 8. Juni 2005 15:29 schrieb Klaus Muth:
> Hi!
>
> Ok, I do the Ingrid.
AAARGH. Another Ingrid. Seems, that the acpi_find_rsdp() is rather optimistic 
about finding the RSDP [arch/i386/kernel/acpi/boot.c, acpi_scan_rsdp]:
 /*
  * Scan all 16-byte boundaries of the physical memory region for the
  * RSDP signature.
  */
 for (offset = 0; offset < length; offset += 16) {
  if (strncmp((char *) (start + offset), "RSD PTR ", sig_len))
   continue;
  return (start + offset);
 }

It seems to happen, that the IBM BIOS contains just the string "RSD PTR " 
exactly at a 16-Byte-Boundary before the real RSDP block, so the wrnog 
address is returned and acpi_table_init() in drivers/acpi/tables.c fails to 
checksum this block of course.

The patched up RedHat Kernel uses 
static struct acpi_table_rsdp * __init
acpi_find_root_pointer(void)
{
 struct acpi_table_rsdp * rsdp;

 /*
  * Physical address is given
  */
 /*
  * Region 1) Search EBDA (low memory) paragraphs
  */
 rsdp = acpi_tb_scan_memory_for_rsdp(__va(LO_RSDP_WINDOW_BASE),
      LO_RSDP_WINDOW_SIZE);

 if (rsdp)
  return rsdp;

 /*
  * Region 2) Search upper memory: 16-byte boundaries in E0000h-F0000h
  */
 rsdp = acpi_tb_scan_memory_for_rsdp(__va(HI_RSDP_WINDOW_BASE),
            HI_RSDP_WINDOW_SIZE);

 
          
 if (rsdp)
  return rsdp;

 printk(KERN_ERR "ACPI: System description tables not found\n");
 return NULL;
}

to find the RSDP and seems to find it in Region 2. GRRRR.

Is there any patch to do the same with a vanilla 2.6 Kernel?
-- 
Klaus Muth
HAGOS eG                      Industriestr. 62      fon: (+49) 711 78805-86
EDV-Programmierung            70565  Stuttgart      fax: (+49) 711 78805-35
http://www.hagos.de               Germany              mailto:muth-5lHx5lHeYlQ@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
