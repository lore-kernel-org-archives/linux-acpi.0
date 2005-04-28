From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: [PATCH 6/6]suspend/resume SMP support
Date: Thu, 28 Apr 2005 00:22:54 -0700
Message-ID: <20050428002254.461fcf32.akpm@osdl.org>
References: <1113283867.27646.434.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1113283867.27646.434.camel-U5EdaLXB8smDugQYiPIPGdh3ngVCH38I@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, pavel-AlSwsSmVLrQ@public.gmane.org, zwane-T6AQWPvKiI1fDP7aoN8Z5Q@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>
> Using CPU hotplug to support suspend/resume SMP. Both S3 and S4 use
>  disable/enable_nonboot_cpus API. The S4 part is based on Pavel's
>  original S4 SMP patch.



On ia64, with tiger_defconfig:

kernel/built-in.o(.text+0x59e12): In function `suspend_prepare':
: undefined reference to `disable_nonboot_cpus'
kernel/built-in.o(.text+0x59e62): In function `suspend_prepare':
: undefined reference to `enable_nonboot_cpus'
kernel/built-in.o(.text+0x5a222): In function `suspend_finish':
: undefined reference to `enable_nonboot_cpus'


Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 include/linux/suspend.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN include/linux/suspend.h~suspend-resume-smp-support-fix include/linux/suspend.h
--- 25/include/linux/suspend.h~suspend-resume-smp-support-fix	Thu Apr 28 15:12:21 2005
+++ 25-akpm/include/linux/suspend.h	Thu Apr 28 15:13:13 2005
@@ -58,7 +58,7 @@ static inline int software_suspend(void)
 }
 #endif
 
-#ifdef CONFIG_HOTPLUG_CPU
+#if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_SOFTWARE_SUSPEND)
 extern void disable_nonboot_cpus(void);
 extern void enable_nonboot_cpus(void);
 #else
_



-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
