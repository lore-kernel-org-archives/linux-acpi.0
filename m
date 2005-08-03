From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: ACPI hot-plug notification help needed
Date: Wed, 3 Aug 2005 14:27:11 -0600
Message-ID: <200508031427.11057.bjorn.helgaas@hp.com>
References: <200507251735.23394.bjorn.helgaas@hp.com> <200508021641.26007.bjorn.helgaas@hp.com> <20050803123627.A4443@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050803123627.A4443-39QZ/XbsZ5/mO6KZMuUCQVaTQe2KTcn/@public.gmane.org>
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
To: Keshavamurthy Anil S <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Did you have a patch to fake add/remove notifications?  I'd
be interested in it.

On Wednesday 03 August 2005 1:36 pm, Keshavamurthy Anil S wrote:
> We are trying to get away with all drivers having to explicitly
> install a hotplug notify handler for all of their devices described
> in the namespace. With this changes, the ACPI core would then
> be responsible for handling this hotplug event, responsible for
> creating acpi_device's and calling respective drivers add() method.

Exactly.

> Once the devices are added by calling acpi_bus_add_device(),
> I think you also need to call acpi_bus_start() to actuall start
> the devices.

Yup.  It should work the same way as the initial enumeration
in acpi_scan_init() -- add and start the root, then add and
start any children.

> In case of a root bridge hotplug, after the root bridge
> has been successfully added by calling acpi_bus_add_device(),
> the root bridge driver (acpiphp.ko see acpiphp_glue.c) needs
> to configure the bridge before we call acpi_bus_start(), so
> need some intraction with the ACPI core and the drivers
> between acpi_bus_add() and acpi_bus_start() calls.

I see the acpiphp_configure_bridge() call between the add
and start calls, which I assume is what you mean here.

But rather than adding more interaction between the drivers
and the ACPI core, I think it would be better to put this
configuration in the driver's add() or start() method.
Then you have more consistency between the "present at boot"
case and the "hot-added later" case, at least in terms of
the driver/core interaction.

(I know the driver probably has to handle hot-added bridges
specially because the BIOS treats them differently, but that
seems like something only acpiphp_glue.c needs to know about.)

Sorry for so much talk and so little code :-)  I'll try to
rectify that...


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
