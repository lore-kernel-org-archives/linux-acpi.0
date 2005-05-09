From: Dean Townsley <dean-5NrKhQnM7FRWk0Htik3J/w@public.gmane.org>
Subject: Re: Something seems to be wrong with my RSDP
Date: Mon, 09 May 2005 14:00:43 -0500
Message-ID: <E1DVDUh-0004L3-62@variable.uchicago.edu>
References: <427CB470.4060700@heiko-gerstung.de> <E1DUujy-0003sP-Om@variable.uchicago.edu> <427F4AC7.4090109@heiko-gerstung.de>  <E1DVBrz-0004I1-8U@variable.uchicago.edu>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: Message from Dean Townsley <dean-5NrKhQnM7FRWk0Htik3J/w@public.gmane.org>
   of "Mon, 09 May 2005 12:16:39 CDT." <E1DVBrz-0004I1-8U-hC4i9AumtbtiuyyxrZMbN/7wmygKZyH0@public.gmane.org>
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
Cc: Heiko Gerstung <hg-Zwoj8m1Se4ooLuGpnUaJU7NAH6kLmebB@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 09 May 2005 12:16:39 -0500 Dean Townsley wrote:
> 
> So my current guess is that there is an invalid RSDP floating around
> in addition to the real one, and the first code (which appears less
> sophisticated) is finding it instead of the real thing.

So far this appears to be what's happening.  I just replaced
acpi_find_rsdp()
with
acpi_tb_find_rsdp(ACPI_PHYSICAL_ADDRESSING,&addr)
(see patch below, with my extra debuging lines)
and it finds a valid RSDP at a DIFFERENT address than before.
(Compare the dmesg below to that in my last message)  It then goes on
to find the RSDT etc etc and works fine.  It seems that
acpi_tb_find_rsdp is a little more carful about where it scans (it
appears to do some checks that the other doesn't).


So the question is the same: why does acpi_table_init() use
acpi_find_rsdp() instead of acpi_tb_find_rsdp(..) ?
And additionally: is the substitution I've performed acceptable on a
permanent basis?

Later,
-Dean




***********dmesg snippet

Linux version 2.6.11 (dean@odysseus) (gcc version 2.95.4 20011002 (Debian prerelease)) #8 Mon May 9 13:03:20 CDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ffc0000 (usable)
 BIOS-e820: 000000000ffc0000 - 000000000ffe0000 (reserved)
 BIOS-e820: 000000000ffe0000 - 000000000ffe8000 (ACPI data)
 BIOS-e820: 000000000ffe8000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65472
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61376 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 Acer                                  ) @ 0x000fe030
ACPI: RSDP contents signature="RSD PTR " checksum=0x19 oem_id="Acer  " revision=0x00 rsdt_addr=0x0ffe0000
ACPI: RSDP checksum=0x0
ACPI: RSDT (v001 Acer   TM100    0x00000001 MSFT 0x00000001) @ 0x0ffe0000
ACPI: FADT (v001 Acer   TM100    0x00000001 MSFT 0x00000001) @ 0x0ffe0054
ACPI: BOOT (v001 Acer   TM100    0x00000001 MSFT 0x00000001) @ 0x0ffe002c
ACPI: DSDT (v001   Acer   AN100  0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0xf008
Allocating PCI resources starting at 10000000 (gap: 10000000:efff0000)
Built 1 zonelists
Kernel command line: BOOT_IMAGE=test26 ro root=306 acpi=force
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01201000)
Initializing CPU#0
CPU 0 irqstacks, hard=c04f0000 soft=c04ef000
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 798.462 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 254696k/261888k available (2566k kernel code, 6684k reserved, 1267k data, 168k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1585.15 BogoMIPS (lpj=792576)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps: 0383f9ff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Mobile Intel(R) Pentium(R) III CPU - M   800MHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
 tbxface-0120 [02] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:........................................................................................................................
Table [DSDT](id F004) - 436 Objects with 35 Devices 120 Methods 34 Regions
ACPI Namespace successfully loaded at root c0505b40
ACPI: setting ELCR to 0200 (from 0c00)
evxfevnt-0096 [03] acpi_enable           : Transition to ACPI mode successful


************patch tested

diff -ur linux-2.6.11-orig/drivers/acpi/tables.c linux-2.6.11/drivers/acpi/tables.c
--- linux-2.6.11-orig/drivers/acpi/tables.c	Wed Mar  2 01:38:07 2005
+++ linux-2.6.11/drivers/acpi/tables.c	Mon May  9 13:02:34 2005
@@ -572,14 +572,24 @@
 	struct acpi_table_rsdp	*rsdp = NULL;
 	unsigned long		rsdp_phys = 0;
 	int			result = 0;
+	struct acpi_pointer addr;
 
 	/* Locate and map the Root System Description Table (RSDP) */
 
+	if (ACPI_FAILURE(acpi_find_root_pointer(ACPI_PHYSICAL_ADDRESSING,&addr)))
+	{
+		printk(KERN_ERR PREFIX "Unable to locate RSDP\n");
+		return -ENODEV;
+	}
+
+	rsdp_phys=addr.pointer.physical;
+	/* old code
 	rsdp_phys = acpi_find_rsdp();
 	if (!rsdp_phys) {
 		printk(KERN_ERR PREFIX "Unable to locate RSDP\n");
 		return -ENODEV;
 	}
+	*/
 
 	rsdp = (struct acpi_table_rsdp *) __va(rsdp_phys);
 	if (!rsdp) {
@@ -590,11 +600,14 @@
 	printk(KERN_DEBUG PREFIX "RSDP (v%3.3d %6.6s                                ) @ 0x%p\n",
 		rsdp->revision, rsdp->oem_id, (void *) rsdp_phys);
 
+	printk(KERN_DEBUG PREFIX "RSDP contents signature=\"%8.8s\" checksum=0x%2.2x oem_id=\"%6.6s\" revision=0x%2.2x rsdt_addr=0x%8.8x\n",
+			rsdp->signature,rsdp->checksum,rsdp->oem_id,rsdp->revision,rsdp->rsdt_address);
 	if (rsdp->revision < 2)
 		result = acpi_table_compute_checksum(rsdp, sizeof(struct acpi_table_rsdp));
 	else
 		result = acpi_table_compute_checksum(rsdp, ((struct acpi20_table_rsdp *)rsdp)->length);
 
+	printk(KERN_DEBUG PREFIX "RSDP checksum=0x%x\n", result);
 	if (result) {
 		printk(KERN_WARNING "  >>> ERROR: Invalid checksum\n");
 		return -ENODEV;


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
