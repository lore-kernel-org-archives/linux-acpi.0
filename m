From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/3]making ACPICA safe for suspend/resume - take 2
Date: Thu, 27 Jan 2005 09:01:22 +0800
Message-ID: <1106787682.9062.7.camel@sli10-desk.sh.intel.com>
References: <1106293737.19407.60.camel@sli10-desk.sh.intel.com>
	 <20050121095219.GA18373@elf.ucw.cz>
	 <1106704432.5756.11.camel@sli10-desk.sh.intel.com>
	 <20050126115804.GC10264@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050126115804.GC10264-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2005-01-26 at 19:58, Pavel Machek wrote:
> > > > The patches are designed to solve the issue of making call to ACPICA
> > > > safe for suspend/resume time. Please see the detail in
> > > > http://sourceforge.net/mailarchive/forum.php?thread_id=6378210&forum_id=6102
> > > > The new patches remove PCI link device resume code and let PCI device
> > > > driver resume code indirectly reconfigure Link's IRQ (call
> > > > pci_enable_device), so we will haven't an issue of invoking ACPICA with
> > > > interrupt disabled. This also works for suspend to disk case. After this
> > > > we only need to guarantee there is enough free memory for S3. One
> > > > problem of the idea is we must fix many PCI drivers, but it's ok to me.
> > > 
> > > Well, having to modify all the drivers should mean "this should be
> > > merged after 2.6.11" (I'm in process of converting all the drivers to
> > > pm_message_t, and would prefer another set of "touch all drivers"
> > > changes not to interfere).
> > There isn't conflict between the pm_message_t converting and adding
> > pci_enable/disable_device to me. It would be better we do them in the
> > meantime, so we don't require another round of change. If so, I can help
> > doing the converting also.
> 
> Well, when something breaks, we will not know "what was it". Plus, it
> is going to be quite an intrusive change and we are already at -rc2.
Ok, that makes sense, though I think pci_enable/disable_device hasn't
impact.

> If driver can do pci_enable_device to solve "ACPICA with interrupts
> isabled" problem, 
This is just one part. pci_disable_device will disable bus master and
possibly do more, I think it's much safer.

> why can't be the same done in code that calls
> device's suspend() method from PCI code? That would be smaller change,
> and we would not duplicate a lot of code.
This is good for pci_disable_device (suspend), but not for resume. We
must restore PCI config and then call pci_enable_device.

Thanks,
Shaohua



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
