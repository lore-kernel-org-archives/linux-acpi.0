From: Zwane Mwaikambo <zwane-tGiaVUSOoeej7qYf8Sx8sA@public.gmane.org>
Subject: Re: [PATCH] SMP parsing rewrite, phase 1
Date: Tue, 21 Jan 2003 02:12:29 -0500 (EST)
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <Pine.LNX.4.44.0301202345130.2653-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0301201834310.26042-100000@dexter.groveronline.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44.0301201834310.26042-100000-SNx59YkgthvyYw2uXbqB2185lzT46atW@public.gmane.org>
To: Andy Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org, Martin Bligh <mbligh-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 20 Jan 2003, Andy Grover wrote:

> Hi all,
> 
> The below patch against 2.5.59 is also available from 
> ftp://ftp.kernel.org/pub/linux/kernel/people/grover/ ,
> or bk pull http://linux-acpi.bkbits.net/linux-smp-init .
> 
> Before I spent any more time carving up mpparse.c, I just wanted to have
> the chance for feedback from others.

Booted fine on ghetto SMP, 4way i686, 1 IOAPIC, 1 ISA bus with a BSP APIC 
ID of 2;


===============================================================================

MPTable, version 2.0.15 Linux

-------------------------------------------------------------------------------

MP Floating Pointer Structure:

  location:			BIOS
  physical address:		0x000fd110
  signature:			'_MP_'
  length:			16 bytes
  version:			1.4
  checksum:			0xc1
  mode:				Virtual Wire

-------------------------------------------------------------------------------

MP Config Table Header:

  physical address:		0x0xfd000
  signature:			'PCMP'
  base table length:		268
  version:			1.4
  checksum:			0xdd
  OEM ID:			'BOCHSCPU'
  Product ID:			'0.1         '
  OEM table pointer:		0x00000000
  OEM table size:		0
  entry count:			22
  local APIC address:		0xfee00000
  extended table length:	0
  extended table checksum:	0

-------------------------------------------------------------------------------

MP Config Base Table Entries:

--
Processors:	APIC ID	Version	State		Family	Model	Step	Flags
		 0	 0x11	 AP, usable	 6	 0	 0	 0x0201
		 1	 0x11	 AP, usable	 6	 0	 0	 0x0201
		 2	 0x11	 BSP, usable	 6	 0	 0	 0x0201
		 3	 0x11	 AP, usable	 6	 0	 0	 0x0201
--
Bus:		Bus ID	Type
		 0	 ISA   
--
I/O APICs:	APIC ID	Version	State		Address
		 4	 0x11	 usable		 0xfec00000
--
I/O Ints:	Type	Polarity    Trigger	Bus ID	 IRQ	APIC ID	PIN#
		INT	 conforms    conforms	     0	   0	      4	   0
		INT	 conforms    conforms	     0	   1	      4	   1
		INT	 conforms    conforms	     0	   2	      4	   2
		INT	 conforms    conforms	     0	   3	      4	   3
		INT	 conforms    conforms	     0	   4	      4	   4
		INT	 conforms    conforms	     0	   5	      4	   5
		INT	 conforms    conforms	     0	   6	      4	   6
		INT	 conforms    conforms	     0	   7	      4	   7
		INT	 conforms    conforms	     0	   8	      4	   8
		INT	 conforms    conforms	     0	   9	      4	   9
		INT	 conforms    conforms	     0	  10	      4	  10
		INT	 conforms    conforms	     0	  11	      4	  11
		INT	 conforms    conforms	     0	  12	      4	  12
		INT	 conforms    conforms	     0	  13	      4	  13
		INT	 conforms    conforms	     0	  14	      4	  14
		INT	 conforms    conforms	     0	  15	      4	  15

===============================================================================


-- 
function.linuxpower.ca
