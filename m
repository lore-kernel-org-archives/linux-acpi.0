From: "Li, Feng (GE Healthcare)" <Feng.Li-sCFLEkgZW7GbXiaaNHstOg@public.gmane.org>
Subject: Could not deliver interrupts to the PCI board
Date: Mon, 7 Mar 2005 10:50:01 +0800
Message-ID: <D02325A0F0177A468FD385A98178C53E0C3DF60A@SHAMLVEM01.e2k.ad.ge.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
content-class: urn:content-classes:message
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

Hello guys,
     I am trying to port our old pci drivers from Linux 2.4 kernel to =
Linux 2.6 kernel.
Now i am working in Linux 2.6.11. I found a strange problem , after i =
installed the new driver(based on 2.6.11 kernel)
into kernel, our pci device is recognized as IO-APIC-edge,  and no =
interrupts can be catched by our driver.( The PCI device shuold be a=20
IO-APIC-level type)
     So we disabled the ACPI service and restart the computer again, =
then the pci device can be recognized as
IO-APIC-level, the driver works well! I think,there are maybe some =
changes in 2.6.11 for ACPI sleep=20
and hibernate that essentially puts ACPI in control of interrupts for =
many devices.Should i  need to add ACPI=20
declaration data to the driver ?

Thanks very much!
Li Feng

=20



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
