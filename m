From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Re: S3 suspend and serial console
Date: Tue, 8 Feb 2005 17:31:43 +0100
Message-ID: <20050208163143.GF1622@elf.ucw.cz>
References: <4204CA50.8090906@gmx.net> <20050205155845.GA20131@hell.org.pl> <20050205220619.GA30739@message-id.gmane0305.slipkontur.de> <4206CF63.2090600@gmx.net> <20050207141655.GB8040@elf.ucw.cz> <42077B07.5090606@gmx.net> <20050207143242.GE8040@elf.ucw.cz> <4207A211.3000305@gmx.net> <20050208125453.GA1622@elf.ucw.cz> <4208C674.1000002@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4208C674.1000002-hi6Y0CQ0nG0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> >>Regarding the original problem:
> >>It seems the following call is sufficient to make the console work
> >>again. However, I haven't found a function which would give me
> >>the parameters needed to call ->set_termios.
> >>
> >>serial/8250.c: serial8250_set_termios
> >>
> >>Do you have any idea how to obtain the termios and tty structures
> >>for a given port, e.g. ttyS0?
> > 
> > Save some termios passed to it in static variable and than use that
> > one as a quick hack...
> 
> Yes, that will hopefully work. The hack I'm using right now causes
> random oopses, but at least the serial console can display them :-|

Are you using 8250.c? It seems to have some suspend/resume
support. Perhaps you should talk to Russell King?

> --- 1.44/drivers/acpi/sleep/main.c      2005-01-15 23:01:53 +01:00
> +++ edited/drivers/acpi/sleep/main.c    2005-02-08 13:16:13 +01:00
> @@ -18,6 +18,7 @@
>  #include <acpi/acpi_bus.h>
>  #include <acpi/acpi_drivers.h>
>  #include "sleep.h"
> +#include <linux/syscalls.h>
> 
>  u8 sleep_states[ACPI_S_STATE_COUNT];
> 
> @@ -82,6 +83,7 @@
>         acpi_status status = AE_OK;
>         unsigned long flags = 0;
>         u32 acpi_state = acpi_suspend_states[pm_state];
> +       struct file* filp;
> 
>         ACPI_FLUSH_CPU_CACHE();
> 
> @@ -126,6 +128,8 @@
>         if (pm_state > PM_SUSPEND_STANDBY)
>                 acpi_restore_state_mem();
> 
> +       filp = filp_open("/dev/ttyS0", O_WRONLY, 0);
> +       filp_close(filp, NULL);


> Any idea why that darn thing oopses on me at random locations?

Yes, you can only do such stuff from process context etc... not from
some random place like this.

								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
