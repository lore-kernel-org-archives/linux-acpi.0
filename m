From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [Proposal]Another way to save/restore PCI config space
	for suspend/resume
Date: Tue, 26 Oct 2004 17:09:05 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1098781745.8433.20.camel@sli10-desk.sh.intel.com>
References: <1098766257.8433.7.camel@sli10-desk.sh.intel.com>
	 <20041026051100.GA5844@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041026051100.GA5844-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Cc: ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2004-10-26 at 13:11, Andi Kleen wrote:
> On Tue, Oct 26, 2004 at 12:50:57PM +0800, Li Shaohua wrote:
> > Hi,
> > We suffer from PCI config space issue for a long time, which causes many
> > system can't correctly resume. Current Linux mechanism isn't sufficient.
> > Here is a another idea: 
> > Record all PCI writes in Linux kernel, and redo all the write after
> > resume in order. The idea assumes Firmware will restore all PCI config
> 
> This won't work very well for some cases. e.g. on AMD x86-64 the 
> IOMMU is flushed by setting/clearing a bit in PCI config space.
> AGP implementations work similar. You really don't want to track
> all these flushes, it would be far too costly.
Possibly we can consider some optimizations, such as a driver can
explicitly disable the 'pci record'. The main problem we encountered is
the correctness of suspend/resume.
> 
> > space to the boot time state, which is true at least for IA32.
> > 
> > Reason:
> > 1. Current PCI save/restore routines only cover first 64 bytes
> 
> The driver could set a flag if it wants more.
Extend PCI config space is device specific, general code can't do it.

> > 2. No PCI bridge driver currently.
> 
> That could be fixed I guess? 
if all PCI devices and bridges have drivers, this could be fixed. But I
think it's far away. Another issue here is the hierarchy of devices. A
device in the below of device tree doesn't means it must be resumed
later. Such as a PCI IRQ router, it must resume before all PCI devices.

> 
> > 3. Some special devices can't or are difficult to save/restore config
> > space with current model. Such as PCI link device, it's a sysdev, but
> > its resume code can't be invoked with irq disabled.
> 
> In this case it would be IMHO better to have specialized suspend/resume
> functions in the drivers for these oddball devices.
> 
> Most likely they will require some special handling anyways
> (like special delays etc.) that can't be done by the generic code 
> 
> > 4. ACPI possibly changes special devices' config space, such as host
> > bridge or LPC bridge. The special devices generally are vender specific,
> > and possibly will not have a driver forever.
> 
> I didn't get that one.
One case here is the ASL code will disable/enable EHCI per current OS
(such as disable EHCI if OS isn't win) in some systems. The
disable/enable bit is in ICH.

Thanks,
Shaohua



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
