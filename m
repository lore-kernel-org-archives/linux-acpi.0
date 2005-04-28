From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Re: [PATCH 6/6]suspend/resume SMP support
Date: Thu, 28 Apr 2005 10:20:37 +0200
Message-ID: <20050428082037.GG1906@elf.ucw.cz>
References: <20050428074201.GA1906@elf.ucw.cz> <200504281611.00254.luming.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200504281611.00254.luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Zwane Mwaikambo <zwane-T6AQWPvKiI1fDP7aoN8Z5Q@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> >  > > On ia64, with tiger_defconfig:
> >  > >
> >  > > kernel/built-in.o(.text+0x59e12): In function `suspend_prepare':
> >  > > : undefined reference to `disable_nonboot_cpus'
> >  > >
> >  > > kernel/built-in.o(.text+0x59e62): In function `suspend_prepare':
> >  > > : undefined reference to `enable_nonboot_cpus'
> >  > >
> >  > > kernel/built-in.o(.text+0x5a222): In function `suspend_finish':
> >  > > : undefined reference to `enable_nonboot_cpus'
> >  >
> >  > Pavel,
> >  > Could IA64 do software suspend? There possibly are other troubles here.
> >
> >  Someone would have to write low-level support. Bring me ia64 notebook
> >  and I'll do it ;-)))))))))))))))))))).
> 
> I just checked DSDT on one ia64 box, it has S0, S4, S5 object.
> So, the platform should have sufficient support for sleep-to-disk.

No arguments about that one... Something like
arch/i386/power/{swsusp.S,cpu.c} needs to be written for ia64,
then. I'm not goot at ia64 assembly (never done that), and do not have
ia64 machine nearby, so I'm probably not doing that work.

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
