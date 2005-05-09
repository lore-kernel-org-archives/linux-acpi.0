From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Something seems to be wrong with my RSDP
Date: Mon, 9 May 2005 13:18:40 -0700
Message-ID: <971FCB6690CD0E4898387DBF7552B90E0170B05A@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dean Townsley <dean-5NrKhQnM7FRWk0Htik3J/w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Heiko Gerstung <hg-Zwoj8m1Se4ooLuGpnUaJU7NAH6kLmebB@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

acpi_tb_find_rsdp is the up-to-date version. acpi_find_rsdp should be
removed.

Acpi_tb_find_rsdp correctly searches the EBDA (Extended BIOS Data Area),
and I think that acpi_find_rsdp does not.

Bob


> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Dean Townsley
> Sent: Monday, May 09, 2005 12:01 PM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Cc: Heiko Gerstung
> Subject: Re: [ACPI] Something seems to be wrong with my RSDP
>=20
> On Mon, 09 May 2005 12:16:39 -0500 Dean Townsley wrote:
> >
> > So my current guess is that there is an invalid RSDP floating around
> > in addition to the real one, and the first code (which appears less
> > sophisticated) is finding it instead of the real thing.
>=20
> So far this appears to be what's happening.  I just replaced
> acpi_find_rsdp()
> with
> acpi_tb_find_rsdp(ACPI_PHYSICAL_ADDRESSING,&addr)
> (see patch below, with my extra debuging lines)
> and it finds a valid RSDP at a DIFFERENT address than before.
> (Compare the dmesg below to that in my last message)  It then goes on
> to find the RSDT etc etc and works fine.  It seems that
> acpi_tb_find_rsdp is a little more carful about where it scans (it
> appears to do some checks that the other doesn't).
>=20
>=20
> So the question is the same: why does acpi_table_init() use
> acpi_find_rsdp() instead of acpi_tb_find_rsdp(..) ?
> And additionally: is the substitution I've performed acceptable on a
> permanent basis?
>=20
> Later,
> -Dean
>=20
>=20
>=20
>=20
> ***********dmesg snippet
>=20
> Linux version 2.6.11 (dean@odysseus) (gcc version 2.95.4 20011002
(Debian
> prerelease)) #8 Mon May 9 13:03:20 CDT 2005
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000000ffc0000 (usable)
>  BIOS-e820: 000000000ffc0000 - 000000000ffe0000 (reserved)
>  BIOS-e820: 000000000ffe0000 - 000000000ffe8000 (ACPI data)
>  BIOS-e820: 000000000ffe8000 - 0000000010000000 (ACPI NVS)
>  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
> 255MB LOWMEM available.
> On node 0 totalpages: 65472
>   DMA zone: 4096 pages, LIFO batch:1
>   Normal zone: 61376 pages, LIFO batch:14
>   HighMem zone: 0 pages, LIFO batch:1
> DMI 2.3 present.
> ACPI: RSDP (v000 Acer                                  ) @ 0x000fe030
> ACPI: RSDP contents signature=3D"RSD PTR " checksum=3D0x19 =
oem_id=3D"Acer  "
> revision=3D0x00 rsdt_addr=3D0x0ffe0000
> ACPI: RSDP checksum=3D0x0
> ACPI: RSDT (v001 Acer   TM100    0x00000001 MSFT 0x00000001) @
0x0ffe0000
> ACPI: FADT (v001 Acer   TM100    0x00000001 MSFT 0x00000001) @
0x0ffe0054
> ACPI: BOOT (v001 Acer   TM100    0x00000001 MSFT 0x00000001) @
0x0ffe002c
> ACPI: DSDT (v001   Acer   AN100  0x00001000 MSFT 0x0100000e) @
0x00000000
> ACPI: PM-Timer IO Port: 0xf008
> Allocating PCI resources starting at 10000000 (gap: 10000000:efff0000)
> Built 1 zonelists
> Kernel command line: BOOT_IMAGE=3Dtest26 ro root=3D306 acpi=3Dforce
> Local APIC disabled by BIOS -- you can enable it with "lapic"
> mapped APIC to ffffd000 (01201000)
> Initializing CPU#0
> CPU 0 irqstacks, hard=3Dc04f0000 soft=3Dc04ef000
> PID hash table entries: 1024 (order: 10, 16384 bytes)
> Detected 798.462 MHz processor.
> Using pmtmr for high-res timesource
> Console: colour VGA+ 80x25
> Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Memory: 254696k/261888k available (2566k kernel code, 6684k reserved,
> 1267k data, 168k init, 0k highmem)
> Checking if this processor honours the WP bit even in supervisor
mode...
> Ok.
> Calibrating delay loop... 1585.15 BogoMIPS (lpj=3D792576)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> CPU: After generic identify, caps: 0383f9ff 00000000 00000000 00000000
> 00000000 00000000 00000000
> CPU: After vendor identify, caps: 0383f9ff 00000000 00000000 00000000
> 00000000 00000000 00000000
> CPU: L1 I cache: 16K, L1 D cache: 16K
> CPU: L2 cache: 512K
> CPU: After all inits, caps: 0383f9ff 00000000 00000000 00000040
00000000
> 00000000 00000000
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU: Intel Mobile Intel(R) Pentium(R) III CPU - M   800MHz stepping 04
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
>  tbxface-0120 [02] acpi_load_tables      : ACPI Tables successfully
> acquired
> Parsing all Control
>
Methods:................................................................
..
> ......................................................
> Table [DSDT](id F004) - 436 Objects with 35 Devices 120 Methods 34
Regions
> ACPI Namespace successfully loaded at root c0505b40
> ACPI: setting ELCR to 0200 (from 0c00)
> evxfevnt-0096 [03] acpi_enable           : Transition to ACPI mode
> successful
>=20
>=20
> ************patch tested
>=20
> diff -ur linux-2.6.11-orig/drivers/acpi/tables.c linux-
> 2.6.11/drivers/acpi/tables.c
> --- linux-2.6.11-orig/drivers/acpi/tables.c	Wed Mar  2 01:38:07 2005
> +++ linux-2.6.11/drivers/acpi/tables.c	Mon May  9 13:02:34 2005
> @@ -572,14 +572,24 @@
>  	struct acpi_table_rsdp	*rsdp =3D NULL;
>  	unsigned long		rsdp_phys =3D 0;
>  	int			result =3D 0;
> +	struct acpi_pointer addr;
>=20
>  	/* Locate and map the Root System Description Table (RSDP) */
>=20
> +	if
> (ACPI_FAILURE(acpi_find_root_pointer(ACPI_PHYSICAL_ADDRESSING,&addr)))
> +	{
> +		printk(KERN_ERR PREFIX "Unable to locate RSDP\n");
> +		return -ENODEV;
> +	}
> +
> +	rsdp_phys=3Daddr.pointer.physical;
> +	/* old code
>  	rsdp_phys =3D acpi_find_rsdp();
>  	if (!rsdp_phys) {
>  		printk(KERN_ERR PREFIX "Unable to locate RSDP\n");
>  		return -ENODEV;
>  	}
> +	*/
>=20
>  	rsdp =3D (struct acpi_table_rsdp *) __va(rsdp_phys);
>  	if (!rsdp) {
> @@ -590,11 +600,14 @@
>  	printk(KERN_DEBUG PREFIX "RSDP (v%3.3d %6.6s
> ) @ 0x%p\n",
>  		rsdp->revision, rsdp->oem_id, (void *) rsdp_phys);
>=20
> +	printk(KERN_DEBUG PREFIX "RSDP contents signature=3D\"%8.8s\"
> checksum=3D0x%2.2x oem_id=3D\"%6.6s\" revision=3D0x%2.2x
rsdt_addr=3D0x%8.8x\n",
> +
rsdp->signature,rsdp->checksum,rsdp->oem_id,rsdp-
> >revision,rsdp->rsdt_address);
>  	if (rsdp->revision < 2)
>  		result =3D acpi_table_compute_checksum(rsdp, sizeof(struct
> acpi_table_rsdp));
>  	else
>  		result =3D acpi_table_compute_checksum(rsdp, ((struct
> acpi20_table_rsdp *)rsdp)->length);
>=20
> +	printk(KERN_DEBUG PREFIX "RSDP checksum=3D0x%x\n", result);
>  	if (result) {
>  		printk(KERN_WARNING "  >>> ERROR: Invalid checksum\n");
>  		return -ENODEV;
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: NEC IT Guy Games.
> Get your fingers limbered up and give it your best shot. 4 great
events, 4
> opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
> win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=3D20
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
