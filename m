From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [RFC 0/6] S3 SMP support with physcial CPU hotplug
Date: Mon, 04 Apr 2005 10:05:42 +0800
Message-ID: <1112580342.4194.329.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Zwane Mwaikambo <zwane-T6AQWPvKiI1fDP7aoN8Z5Q@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,
The following 6 patches try to add suspend-to-ram (or S3) SMP support
for IA32. It's for support HT based system suspend/resume currently and
most of the code are also useful for physical CPU hotplug.

In a SMP system, after S3 resume, the BP is starting to execute the ACPI
wakeup address just like the UP case. And the APs possibly are in a
BIOS's busy loop. This just looks like the boot time case, we must use a
SIPI circle to wakeup the APs.

We uses the CPU hotplug infrastructure. In order to reuse the SMP boot
code, we clean up all CPU states after the CPU is dead, including its
idle thread, runqueue and other CPU states. Since the CPU is in idle
thread before suspend, we don't require to save and restore after resume
most of the CPU states.

Now the sequences of S3 are:
1. hotremove all APs, put them into idle thread.
2. follow UP S3 code path.
3. warm boot all APs.
4. UP all APs.

The patches are against 2.6.11-rc1 with Zwane's CPU hotplug patch in -mm
tree. To test the SMP S3, please don't enable MTRR driver (it's SMP
broken for Suspend/resume). And please kill syslogd, there is a bug in
the sususpend/resume refrigerator mechanism, which can be fixed by
swsusp2 refrigerator.
I'm looking forward to your comments. Thanks in advance!

Thanks,
Shaohua



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
