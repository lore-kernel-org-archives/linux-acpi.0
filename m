From: mizu <michal-VaXaUECoPuY@public.gmane.org>
Subject: Re: ACER 632 notebook reboots instead of poweroff
Date: Wed, 27 Oct 2004 16:18:33 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041027141833.GC8443@zimen.sk>
References: <20041026194029.GA10954@pooh>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041026194029.GA10954@pooh>
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


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

  the same problem is with my ACER 632 too.

  I've tried disable wakeup devices /proc/acpi/wakeup, but with no success.

 =20

  Sia
                        mizu

On Tue, Oct 26, 2004 at 09:40:29PM +0200, Laszlo 'GCS' Boszormenyi wrote:
> Hi,
>=20
>  I have a Gericom 1st supersonic (PIII 1.2Ghz) laptop, running Debian
> Sarge (up-to-date). I have it since ~2.4.14, and until 2.6.8.1 the
> 'halt' command shut down the machine correctly. Starting with 2.6.8.1-bk1
> it reboots. :( I realize that -bk1 has a big ACPI update, which may be
> the problem IMHO.
>  I have tried to look into existing bugreports, but could not find any
> similar to this on the Kernel Bugzilla nor in the ACPI Bugzilla. All I
> could found some note that Local APIC can cause problems, but even if I
> disable that, the problem remains. Asked LKML without any reply; hope
> here I can get some help, so if you need more information about it,
> please let me know.
> Some maybe relevant bits from the machine:
> 0000:00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo P=
RO133x] (rev c4)
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort+ >SERR- <PERR+
>         Latency: 0
>         Region 0: Memory at e8000000 (32-bit, prefetchable) [size=3D128M]
>         Capabilities: [a0] AGP version 2.0
>                 Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART6=
4- HTrans- 64bit- FW- AGP3- Rate=3Dx1,x2,x4
>                 Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA+ AGP+ GART64- 64bit=
- FW- Rate=3Dx1
>         Capabilities: [c0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,=
D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>=20
> 0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
> MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort+ >SERR- <PERR-
>         Latency: 0
>         Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=
=3D0
>         I/O behind bridge: 00009000-00009fff
>         Memory behind bridge: e0000000-e00fffff
>         Prefetchable memory behind bridge: f0000000-f7ffffff
>         BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
>         Capabilities: [80] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,=
D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>=20
>=20
> A dmesg between a working 2.6.8.1 and 2.6.8.1-bk1 reveals only minor(?)
> things:
>  Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> -CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000
> -CPU: After vendor identify, caps:  0383fbff 00000000 00000000 00000000
> +CPU: After generic identify, caps: 0383f9ff 00000000 00000000 00000000
> +CPU: After vendor identify, caps:  0383f9ff 00000000 00000000 00000000
>  CPU: L1 I cache: 16K, L1 D cache: 16K
>  CPU: L2 cache: 256K
> -CPU: After all inits, caps:        0383fbff 00000000 00000000 00000040
> +CPU: After all inits, caps:        0383f9ff 00000000 00000000 00000040
>  Intel machine check architecture supported.
> [...]
> -enabled ExtINT on CPU#0
> -ESR value before enabling vector: 00000000
> -ESR value after enabling vector: 00000000
> -Using local APIC timer interrupts.
> -calibrating APIC timer ...
> -..... CPU clock speed is 1199.0574 MHz.
> -..... host bus clock speed is 133.0285 MHz.
> +ACPI: IRQ9 SCI: Edge set to Level Trigger.
>  NET: Registered protocol family 16
>  PCI: PCI BIOS revision 2.10 entry at 0xfd84e, last bus=3D1
>  PCI: Using configuration type 1
>  mtrr: v2.0 (20020519)
> -ACPI: Subsystem revision 20040326
> -ACPI: IRQ9 SCI: Edge set to Level Trigger.
> +ACPI: Subsystem revision 20040715
> [...]
>  Initializing Cryptographic API
> -PCI: Disabling Via external APIC routing
>  PCI: Via IRQ fixup for 0000:00:07.5, from 255 to 5
>=20
> Anyone have at least a shot what can cause this problem?
> I would be happy to try out patches or back out ones from -bk1 if
> needed.
>=20
> Any help is greatly appreciated in advance,
> Laszlo/GCS
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Sybase ASE Linux Express Edition - download now for FREE
> LinuxWorld Reader's Choice Award Winner for best database on Linux.
> http://ads.osdn.com/?ad_id=3D5588&alloc_id=3D12065&op=3Dclick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel

--=20
              mizu
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
[-> E-mail:michal_AT_zimen_DOT_sk   =20
[-> ICQ:97165392
[-> WWW: http://michal.zimen.sk
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D

--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBf6459kFXwDL4DRkRAu5kAKCWjCe9BKUbznpvVGaOV09ffMR/twCffQMP
F4KBLs4Z5TI5zrniAR3oiYQ=
=Ny6D
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
