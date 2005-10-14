From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [RFC]convert ACPI driver model to Linux driver model -      takes 2
Date: Fri, 14 Oct 2005 17:35:44 +0800
Message-ID: <59D45D057E9702469E5775CBB56411F19C4F95@pdsmsx406>
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
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,
>
>> On Fri, 2005-10-14 at 04:43 +0800, Bjorn Helgaas wrote:
>>> You now have both 'acpi_driver' and 'acpi_phys_driver' (and
>>> 'acpi_device' and 'acpi_phys_device').  What exactly is the
>>> distinction?  Is the distinction necessary?  Can you just stuff
>>> the generic device stuff into 'struct acpi_device' itself?
>
>> Devices in ACPI bus use acpi_phys_driver, other devices use
acpi_driver.
>
>I'm sorry to be dense, but this doesn't help me.  What do you
>mean by "devices in ACPI bus" as opposed to other ACPI devices?
>
>Let's say I want to write a driver for something in ACPI, like
>a fan.  How do I decide whether to use acpi_phys_driver or
>acpi_driver?
>
>Do you mean that I can use either one, and that you want to
>migrate drivers from acpi_driver to acpi_phys_driver over time?
>
In my mind, the devices which don't belong to other physical buses (such
as PCI, PNP) are ACPI bus devices. These devices are:
+//		"PNP0C09," /* EC */
+//		"ACPI0003," /* AC */
+//		"PNP0C0F," /* Link */
+//		"PNP0C0A," /* battery */
+//		"PNP0C0C,PNP0C0E,PNP0C0D,ACPI_FPB,ACPI_FSB," /* button
*/
+//		"PNP0C0B," /* fan */
+//		"PNP0A03," /* PCI root */
+//		ACPI_POWER_HID"," /* power */
+//		ACPI_PROCESSOR_HID"," /* CPU */
+//		ACPI_THERMAL_HID"," /* thermal */
The devices only can use acpi_phys_driver. Other devices still use
acpi_driver.

>If that's the case, I think we should end up with acpi_driver,
>not acpi_phys_driver, because "phys" doesn't tell me anything
>useful.  And there aren't very many ACPI drivers, so I don't
>really see the problem with just moving them all at once.
I agree we should just have acpi_driver. Non ACPI bus devices should
directly use ACPI services instead of registering an acpi_driver. The
issue is there are some ACPI drivers whose devices are hard to catalog,
such as video, hotkey. Anyway, the change should be slow.
The other issue is some ACPI drivers such as pci_root.c processor.c now
support hotplug. They require two call backs (.add, .start). The
callbacks are called in different sequence at the hotplug time and boot
time. Linux driver model provides .probe callback, so it's hard to
convert pci_root.c and processor.c.
For the acpi_device/acpi_phys_device, do you think we should just have
acpi_device as well?

Thanks,
Shaohua


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
