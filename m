From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: ACPI vs PCI: configuration space
Date: Wed, 18 Jun 2003 23:17:52 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030618221752.GY24357@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


OK, I've been bashing my head against this for two days,
it's time to get more eyes on the problem.  The problem is in
acpi_os_read_pci_configuration() and acpi_os_write_pci_configuration().
These functions can be called for busses which have not yet been scanned
(and therefore do not have a corresponding pci_bus).  The code in 2.5
doesn't work for ia64 beause we need a valid ->sysdata pointer to handle
PCI domains.

The current patch in the ia64 tree does this:

        struct pci_bus          bus;
+#ifdef CONFIG_IA64
+       struct pci_controller   ctrl;
+#endif
 
...
        bus.number = pci_id->bus;
+#ifdef CONFIG_IA64
+       ctrl.segment = pci_id->segment;
+       bus.sysdata = &ctrl;
+#endif
        result = pci_root_ops->read(&bus, PCI_DEVFN(pci_id->device,

I think we can all agree that's ugly.  But there's no _clear_ way to
improve this.

Try 1: Ask the architecture code to provide a sysdata for us.  That's bad;
it needs to allocate with GFP_ATOMIC (since this code can be called from
interrupt context).  So it can fail on low mem conditions.

Try 2: Define a `struct pci_controller' on architectures that don't have it.
And a macro pci_set_domain() so x86 can have a zero-length pci_controller.
Not the prettiest idea, but best of this batch.

Try 3: Move the segment/domain into the pci_bus.  This already got NAKed
by a few people.

Try 4: redefine the pci_ops again.  Haha, very funny.

It's kind of annoying to invent some structures and put some values into
them only to pull them out again.  This leads to try 5 ...

struct acpi_pci_ops {
	int (*read)(int domain, int bus, int devfn, int where, int size, u32 *val);
	int (*write)(int domain, int bus, int devfn, int where, int size, u32 val);
}

It reduces stack consumption, which is a clear win ... it's also _incredibly_
easy to implement since all the existing pci_ops call functions which take
exactly this form.

Go on, approve Try 5.  You know you want to ;-)

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
