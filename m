From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [RFC]convert ACPI driver model to Linux driver model -      takes 2
Date: Fri, 14 Oct 2005 09:54:52 -0600
Message-ID: <200510140954.52206.bjorn.helgaas@hp.com>
References: <59D45D057E9702469E5775CBB56411F19C4F95@pdsmsx406>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <59D45D057E9702469E5775CBB56411F19C4F95@pdsmsx406>
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
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Friday 14 October 2005 3:35 am, Li, Shaohua wrote:
> >> On Fri, 2005-10-14 at 04:43 +0800, Bjorn Helgaas wrote:
> >I'm sorry to be dense, but this doesn't help me.  What do you
> >mean by "devices in ACPI bus" as opposed to other ACPI devices?
> >...
> In my mind, the devices which don't belong to other physical buses (such
> as PCI, PNP) are ACPI bus devices.

PCI is a physical bus.  It defines wires and electrical things
that happen on those wires.  Neither PNP nor ACPI is a physical
bus.  So every device in the ACPI namespace seems like an "ACPI
bus device".

> These devices are: 
> +//		"PNP0C09," /* EC */
> ...
> +//		ACPI_THERMAL_HID"," /* thermal */
> The devices only can use acpi_phys_driver. Other devices still use
> acpi_driver.

What is the rule by which you determine that the above devices
should use acpi_phys_driver, and all other devices should use
acpi_driver?

> >If that's the case, I think we should end up with acpi_driver,
> >not acpi_phys_driver, because "phys" doesn't tell me anything
> >useful.  And there aren't very many ACPI drivers, so I don't
> >really see the problem with just moving them all at once.
> I agree we should just have acpi_driver. Non ACPI bus devices should
> directly use ACPI services instead of registering an acpi_driver.

Maybe it would help me understand this if you gave an example of
a non ACPI bus device that should just use ACPI services instead
of registering a driver.

> The issue is there are some ACPI drivers whose devices are hard to
> catalog, such as video, hotkey.

I see that the ACPI video driver does not claim by _HID or _CID,
but by a special match function.  But what is the problem?
driver_probe_device() supports an optional match function, so
it looks like ACPI video could be done in that model.

Hotkey does look strange.  When it registers, it has no list of
_HIDs to claim.  But hotkeys cause ACPI notify events, which go
to a specific object in the ACPI namespace.  So it looks like
it has a way via /proc to tell the driver which devices to
claim.

But this doesn't seem so much different than a PCI driver that
can be told dynamically to claim new PCI IDs.  Could a similar
mechanism be used here?

> For the acpi_device/acpi_phys_device, do you think we should just have
> acpi_device as well?

Yes, unless you can explain why we need both.


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
