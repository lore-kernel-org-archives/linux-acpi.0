From: Sergio Monteiro Basto <sergio-qOf5bGQp09kptuEoxK/DLR2eb7JE58TQ@public.gmane.org>
Subject: Re: "Found HC with no IRQ" empty /proc/bus/usb
Date: Sun, 03 Apr 2005 16:27:44 +0100
Message-ID: <1112542065.790.0.camel@bastov>
References: <424D8C48.1090804@atreus-systems.com>
Reply-To: sergio-qOf5bGQp09kptuEoxK/DLR2eb7JE58TQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <424D8C48.1090804-sAvY64jVBerkQYj/0HfcvtBPR1lH4CV8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

is the age of the Bios is less then 2001 ? probably is , if so, you
should append "acpi=3Dforce" to enable ACPI.
On some Bios configurations, you also have to enable ACPI and disable
APM ( on Bios configuration )




On Fri, 2005-04-01 at 13:00 -0500, Allan Mcintosh wrote:
> Hey,
>=20
> On my debian Dual 550MHz Pentium III machine, I am unable to get usb
> working. I didn't notice anything obvious in the bios that would disabl=
e
> USB. Any suggestions would be greatly appreciated.
>=20
> I have tried several kernels, most recently 2.6.10 and 2.6.11.5.
> I have also tried booting with variations of
>=20
> append=3D"noapic acpi=3Doff pci=3Dbiosirq"
>=20
>=20
> Upon loading uhci_hcd module I see the following
>=20
> $ dmesg
> <snip>
> usbcore: registered new driver usbfs
> usbcore: registered new driver hub
> usbcore: registered new driver hiddev
> usbcore: registered new driver usbhid
> drivers/usb/input/hid-core.c: v2.0:USB HID core driver
> USB Universal Host Controller Interface driver v2.2
> PCI: Enabling device 0000:00:07.2 (0000 -> 0001)
> PCI: No IRQ known for interrupt pin C of device 0000:00:07.2. Probably
> buggy MP table.
> uhci_hcd 0000:00:07.2: Found HC with no IRQ.  Check BIOS/PCI
> 0000:00:07.2 setup!
>=20
>=20
>=20
> $ lspci -vv
> <snip>
> 0000:00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev
> 01) (prog-if 00 [UHCI])
>         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbo=
rt-
> <TAbort- <MAbort- >SERR- <PERR-
>         Interrupt: pin D routed to IRQ 0
>         Region 4: I/O ports at ef80 [size=3D32]
>=20
>=20
> $ lsmod
> Module                  Size  Used by
> uhci_hcd               34640  0
> ehci_hcd               34180  0
> usbhid                 33184  0
> usbcore               123096  3 uhci_hcd,ehci_hcd,usbhid
> <snip>
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
--=20
S=E9rgio M.B.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
