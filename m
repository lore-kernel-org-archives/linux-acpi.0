From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: [Proposal]Another way to save/restore PCI config
	space for suspend/resume
Date: Wed, 27 Oct 2004 08:50:46 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1098838245.12245.4.camel@sli10-desk.sh.intel.com>
References: <1098766257.8433.7.camel@sli10-desk.sh.intel.com>
	 <20041026092106.GC28897@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041026092106.GC28897-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 2004-10-26 at 17:21, Pavel Machek wrote:
> Hi!
> 
> > We suffer from PCI config space issue for a long time, which causes many
> > system can't correctly resume. Current Linux mechanism isn't sufficient.
> > Here is a another idea: 
> > Record all PCI writes in Linux kernel, and redo all the write after
> > resume in order. The idea assumes Firmware will restore all PCI config
> > space to the boot time state, which is true at least for IA32.
> 
> That looks extremely ugly to me. If you want to do something special
> in resume function, just do it there. It will probably share a lot of
> code with your init function, anyway.
How can you handle devices without driver? And how to save/restore
config space for special devices, such as LPC bridge and host bridge?

-Shaohua



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
