From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [Proposal]Another way to save/restore PCI config space for
 suspend/resume
Date: Tue, 26 Oct 2004 12:50:57 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1098766257.8433.7.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,
We suffer from PCI config space issue for a long time, which causes many
system can't correctly resume. Current Linux mechanism isn't sufficient.
Here is a another idea: 
Record all PCI writes in Linux kernel, and redo all the write after
resume in order. The idea assumes Firmware will restore all PCI config
space to the boot time state, which is true at least for IA32.

Reason:
1. Current PCI save/restore routines only cover first 64 bytes
2. No PCI bridge driver currently.
3. Some special devices can't or are difficult to save/restore config
space with current model. Such as PCI link device, it's a sysdev, but
its resume code can't be invoked with irq disabled.
4. ACPI possibly changes special devices' config space, such as host
bridge or LPC bridge. The special devices generally are vender specific,
and possibly will not have a driver forever.

Possibly we must consider other factors:
1.tracking writes alone will not be enough. Some PCI devices may have
restrictions such as something has to be written after it is read and
the like. Still we should be able to do this if we can trace all pci
reads and writes and repeat it at restore.
2. For support hotplug, add a callback for hotplug PCI remove. When a
device is removed, all records about it are removed.
What's your opinions?

Thanks,
Shaohua



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
