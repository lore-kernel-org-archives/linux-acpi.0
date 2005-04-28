From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: [PATCH 6/6]suspend/resume SMP support
Date: Thu, 28 Apr 2005 00:41:08 -0700
Message-ID: <20050428004108.3c670bf2.akpm@osdl.org>
References: <1113283867.27646.434.camel@sli10-desk.sh.intel.com>
	<20050428002254.461fcf32.akpm@osdl.org>
	<1114673297.26367.3.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1114673297.26367.3.camel-U5EdaLXB8smDugQYiPIPGdh3ngVCH38I@public.gmane.org>
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
> On Thu, 2005-04-28 at 15:22, Andrew Morton wrote:
> > -#ifdef CONFIG_HOTPLUG_CPU
> > +#if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_SOFTWARE_SUSPEND)
> ACPI_SLEEP also requires it. So it will be
> #if defined(CONFIG_HOTPLUG_CPU) && (defined(CONFIG_SOFTWARE_SUSPEND) || defined(CONFIG_ACPI_SLEEP))
> 

But does setting CONFIG_ACPI_SLEEP cause kernel/power/smp.o to be actually
compiled and linked?  I don't think so?

Anyway, please send a tested fix.


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
