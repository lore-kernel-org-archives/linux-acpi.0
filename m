From: Mizu <michal-VaXaUECoPuY@public.gmane.org>
Subject: S3,S4 on Acer TM632XC
Date: Sat, 26 Apr 2003 11:47:05 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030426094705.GA11796@icmza.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi.

  I was testing $SUBJ with kernel 2.5.68 (acpi ver=3D3D20030328)

  With this kernel options:  acpi_sleep=3D3Ds3_bios pci=3D3Dnoacpi

  echo -n 3 >/proc/acpi/sleep
  this is a debug message:

    Enabling SEP on CPU 0
    Back to C!

    Debug: sleeping function called from illegal context
    		at mm/slab.c:1664
    Call Trace:
    [...]  __might_sleep+..
    	   kmalloc
	   acpi_os_allocate
	   acpi_ut_callocate
	   acpi_evalute
	   acpi_leave_sleep_state
	   acpi_system_suspend
	   acpi_suspend
	   acpi_system_write_sleep
	   vfs_write
	   sys_write
	   syscall_call

  .................F R E E Z Y....................


  Without s3_bios, there is no backlight of LCD.


++
 And later, i saw this kernel messages. (Automatic sleeping function
after x=3D
y minutes
?)=3D20

kern.log:
 Debug: sleeping function called from illegal context at
mm/page_alloc.c:541
Apr 25 10:24:08 mizu kernel: Call Trace:
Apr 25 10:24:08 mizu kernel:  [<c011f637>] __might_sleep+0x5f/0x74
Apr 25 10:24:08 mizu kernel:  [<c014aff8>] __alloc_pages+0x2c6/0x2cb
Apr 25 10:24:08 mizu kernel:  [<c011ac2e>] pte_alloc_one+0x2d/0x98
Apr 25 10:24:08 mizu kernel:  [<c015667b>] pte_alloc_map+0x89/0x210
Apr 25 10:24:08 mizu kernel:  [<c015845c>] remap_page_range+0x113/0x30b
Apr 25 10:24:08 mizu kernel:  [<c014adbc>] __alloc_pages+0x8a/0x2cb
Apr 25 10:24:08 mizu kernel:  [<d0b762c0>] +0x0/0xa20 [nvidia]
Apr 25 10:24:08 mizu kernel:  [<d0b762c0>] +0x0/0xa20 [nvidia]
Apr 25 10:24:08 mizu kernel:  [<d0a0f41c>] KernMapAGPPages+0x37/0x71
[nvidia]
Apr 25 10:24:08 mizu kernel:  [<d0b762c0>] +0x0/0xa20 [nvidia]
Apr 25 10:24:08 mizu kernel:  [<d0b76300>] +0x40/0xa20 [nvidia]
Apr 25 10:24:08 mizu kernel:  [<d0b762c0>] +0x0/0xa20 [nvidia]
Apr 25 10:24:08 mizu kernel:  [<d0a0cffe>] nv_kern_mmap+0x1a4/0x2bf
[nvidia]
Apr 25 10:24:08 mizu kernel:  [<c015bdfa>] do_mmap_pgoff+0x263/0x6a0
Apr 25 10:24:08 mizu kernel:  [<c015beaa>] do_mmap_pgoff+0x313/0x6a0
Apr 25 10:24:08 mizu kernel:  [<c0112e1f>] old_mmap+0xf7/0x14f
Apr 25 10:24:08 mizu kernel:  [<c010c58b>] math_state_restore+0x29/0x41
Apr 25 10:24:08 mizu kernel:  [<c010afaf>] syscall_call+0x7/0xb
Apr 25 10:24:08 mizu kernel:=3D20
Apr 25 10:25:30 mizu kernel: spurious 8259A interrupt: IRQ7.
Apr 25 10:50:05 mizu kernel: Debug: sleeping function called from
illegal context at mm/page_alloc.c:541
Apr 25 10:50:05 mizu kernel: Call Trace:
Apr 25 10:50:05 mizu kernel:  [<c011f637>] __might_sleep+0x5f/0x74
Apr 25 10:50:05 mizu kernel:  [<c014aff8>] __alloc_pages+0x2c6/0x2cb
Apr 25 10:50:05 mizu kernel:  [<c011ac2e>] pte_alloc_one+0x2d/0x98
Apr 25 10:50:05 mizu kernel:  [<c015667b>] pte_alloc_map+0x89/0x210
Apr 25 10:50:05 mizu kernel:  [<c015845c>] remap_page_range+0x113/0x30b
Apr 25 10:50:05 mizu kernel:  [<c014adbc>] __alloc_pages+0x8a/0x2cb
Apr 25 10:50:05 mizu kernel:  [<d0b762c0>] +0x0/0xa20 [nvidia]
Apr 25 10:50:05 mizu kernel:  [<d0b762c0>] +0x0/0xa20 [nvidia]
Apr 25 10:50:05 mizu kernel:  [<d0a0f41c>] KernMapAGPPages+0x37/0x71
[nvidia] And later, i saw this kernel messages. (Automatic sleeping
function after x=3D
y minutes
?)=3D20

kern.log:
 Debug: sleeping function called from illegal context at
mm/page_alloc.c:541
Apr 25 10:24:08 mizu kernel: Call Trace:
Apr 25 10:24:08 mizu kernel:  [<c011f637>] __might_sleep+0x5f/0x74
Apr 25 10:24:08 mizu kernel:  [<c014aff8>] __alloc_pages+0x2c6/0x2cb
Apr 25 10:24:08 mizu kernel:  [<c011ac2e>] pte_alloc_one+0x2d/0x98
Apr 25 10:24:08 mizu kernel:  [<c015667b>] pte_alloc_map+0x89/0x210
Apr 25 10:24:08 mizu kernel:  [<c015845c>] remap_page_range+0x113/0x30b
Apr 25 10:24:08 mizu kernel:  [<c014adbc>] __alloc_pages+0x8a/0x2cb
Apr 25 10:24:08 mizu kernel:  [<d0b762c0>] +0x0/0xa20 [nvidia]
Apr 25 10:24:08 mizu kernel:  [<d0b762c0>] +0x0/0xa20 [nvidia]
Apr 25 10:24:08 mizu kernel:  [<d0a0f41c>] KernMapAGPPages+0x37/0x71
[nvidia]
Apr 25 10:24:08 mizu kernel:  [<d0b762c0>] +0x0/0xa20 [nvidia]
Apr 25 10:24:08 mizu kernel:  [<d0b76300>] +0x40/0xa20 [nvidia]
Apr 25 10:24:08 mizu kernel:  [<d0b762c0>] +0x0/0xa20 [nvidia]
Apr 25 10:24:08 mizu kernel:  [<d0a0cffe>] nv_kern_mmap+0x1a4/0x2bf
[nvidia]
Apr 25 10:24:08 mizu kernel:  [<c015bdfa>] do_mmap_pgoff+0x263/0x6a0
Apr 25 10:24:08 mizu kernel:  [<c015beaa>] do_mmap_pgoff+0x313/0x6a0
Apr 25 10:24:08 mizu kernel:  [<c0112e1f>] old_mmap+0xf7/0x14f
Apr 25 10:24:08 mizu kernel:  [<c010c58b>] math_state_restore+0x29/0x41
Apr 25 10:24:08 mizu kernel:  [<c010afaf>] syscall_call+0x7/0xb
Apr 25 10:24:08 mizu kernel:=3D20
Apr 25 10:25:30 mizu kernel: spurious 8259A interrupt: IRQ7.
Apr 25 10:50:05 mizu kernel: Debug: sleeping function called from
illegal context at mm/page_alloc.c:541
Apr 25 10:50:05 mizu kernel: Call Trace:
Apr 25 10:50:05 mizu kernel:  [<c011f637>] __might_sleep+0x5f/0x74
Apr 25 10:50:05 mizu kernel:  [<c014aff8>] __alloc_pages+0x2c6/0x2cb
Apr 25 10:50:05 mizu kernel:  [<c011ac2e>] pte_alloc_one+0x2d/0x98
Apr 25 10:50:05 mizu kernel:  [<c015667b>] pte_alloc_map+0x89/0x210
Apr 25 10:50:05 mizu kernel:  [<c015845c>] remap_page_range+0x113/0x30b
Apr 25 10:50:05 mizu kernel:  [<c014adbc>] __alloc_pages+0x8a/0x2cb
Apr 25 10:50:05 mizu kernel:  [<d0b762c0>] +0x0/0xa20 [nvidia]
Apr 25 10:50:05 mizu kernel:  [<d0b762c0>] +0x0/0xa20 [nvidia]
Apr 25 10:50:05 mizu kernel:  [<d0a0f41c>] KernMapAGPPages+0x37/0x71
[nvidia]=20
Apr 25 10:50:05 mizu kernel:  [<d0b762c0>] +0x0/0xa20 [nvidia]
Apr 25 10:50:05 mizu kernel:  [<d0b76300>] +0x40/0xa20 [nvidia]
Apr 25 10:50:05 mizu kernel:  [<d0b762c0>] +0x0/0xa20 [nvidia]
Apr 25 10:50:05 mizu kernel:  [<d0a0cffe>] nv_kern_mmap+0x1a4/0x2bf
[nvidia]
Apr 25 10:50:05 mizu kernel:  [<c015bdfa>] do_mmap_pgoff+0x263/0x6a0
Apr 25 10:50:05 mizu kernel:  [<c015beaa>] do_mmap_pgoff+0x313/0x6a0
Apr 25 10:50:05 mizu kernel:  [<c0112e1f>] old_mmap+0xf7/0x14f
Apr 25 10:50:05 mizu kernel:  [<c010c58b>] math_state_restore+0x29/0x41
Apr 25 10:50:05 mizu kernel:  [<c010afaf>] syscall_call+0x7/0xb
Apr 25 10:50:05 mizu kernel:=3D20

=3D2E
++

Sometimes S4 works good (with same Trace messages ;( ), but sometimes
when =3D
i try to S4, there was something like ide-disk BUG. I dont have
that message, becouse there was only console message + FREEZY !

I've ALI chipset:

ALI15X3: IDE controller at PCI slot 00:10.0
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x2480-0x2487, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x2488-0x248f, BIOS settings: hdc:pio, hdd:pio


++
On the pci, there is this device:

00:11.0 Bridge: ALi Corporation M7101 PMU
        Subsystem: Acer Incorporated [ALI]: Unknown device 102b
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr-=3D
 Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3D3Dmedium
>TAbort- =3D
<TAbort- <MAbort- >SERR- <PERR-

I read in kernel src: pci/devices.h:
   DEVICE(1025,7101,"M7101 PCI PMU Power Management Controller")
=3D2E...
Do i need this device to correct Power Management ?
=20
---END OF QUESTIONS..  ;)


Thx=3D20

				mizu=20


--=20
--=20
_______M_i_z_u________

--> Linux Friendly <--
[-> E-mail:michal-VaXaUECoPuY@public.gmane.org   =20
[-> ICQ:97165392
[-> WWW: http://www.mizu.sk


--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+qlWZ9kFXwDL4DRkRAgn5AKC37xfsnWpOkZZQcvtSAaFXuHhXuQCgq2Yx
Jg9PjmVEFaFFzjmfclxk7tw=
=Ry1X
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
