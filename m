From: Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [Proposal]Another way to save/restore PCI config space for suspend/resume
Date: Wed, 27 Oct 2004 13:14:27 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041027131427.C2382@unix-os.sc.intel.com>
References: <1098766257.8433.7.camel@sli10-desk.sh.intel.com>
Reply-To: Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1098766257.8433.7.camel-U5EdaLXB8smDugQYiPIPGdh3ngVCH38I@public.gmane.org>; from shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org on Tue, Oct 26, 2004 at 12:50:57PM +0800
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Oct 26, 2004 at 12:50:57PM +0800, Li Shaohua wrote:
> Hi,
> We suffer from PCI config space issue for a long time, which causes many
> system can't correctly resume. Current Linux mechanism isn't sufficient.
> Here is a another idea: 
> Record all PCI writes in Linux kernel, and redo all the write after
> resume in order. The idea assumes Firmware will restore all PCI config
> space to the boot time state, which is true at least for IA32.
> 
A large percentage of them may be irrelevant with respect to 
suspend/resume (e.g. pci device tree and resource scan...).  Apart 
from the performance problems, generic code doing device specific 
config accesses may have correctness problems. For example, you 
will not be able to capture/replay config cycles or other device 
specific initialization (e.g. using memory mapped IO) that BIOS may 
have done before boot. This may be required for correct access to
device specific areas. The same thing is true about device specific 
config accesses that may have been done by the corresponding 
driver after boot. Without device specific knowledge, we may see 
unpredictable behavior and non-repeatable and hard to debug problems.

I don't see how generic code can do the right thing for device
specific accesses. Devices like p2p bridges that have standard
definitions can be handled separately.

Rajesh



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
