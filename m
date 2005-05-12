From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI / PME problem
Date: Thu, 12 May 2005 10:17:34 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD3057501EB74FE@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: Zi Zhou <Zi.Zhou-IrU4XInhIXM@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Interesting. Which kernel version are you using?
Does the system keep fire PME interrupt at boot time?
It should be done in BIOS to me. An easy way (if the BIOS isn't smart) =
is doing it in ACPI BIOS. Maybe one device's _INI or _REG method.

Thanks,
Shaohua

________________________________________
From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org =
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Zi Zhou
Sent: Thursday, May 12, 2005 10:02 AM
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [ACPI] ACPI / PME problem

Hi,
=A0
I have an in-house designed ASIC which requires PCI PowerManager =
Capability bits PME_Status and PME_En to be reset before ACPI does =
Interrupt routing(We use PIC due to BIOS limitation), otherwise system =
will hang after kernel message "ACPI: Using PIC for interrupt routing". =
It actually loop forever complaining "acpi_bus-0077 [04] =
acpi_bus_get_device=A0=A0 : No context for object [xxxxxxxx]=A0 " The =
objects belong to some PCI IRQ table=20
=A0
My BIOS is not smart enough to reset these bits at this moment. I prefer =
to do it in linux kernel. But I found that I hit the problem point so =
early in the kernel boot stage that pci_devices are not scanned and =
gathered together yet(basically pci_devices is still empty), which makes =
it very difficult to access pci configure space if it's possible at all. =

=A0
My question is: Should this be done in BIOS or there is way to do it in =
the kernel?
=A0
Thanks very much for your advice !
=A0
Zi


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
