From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH] [suspend/resume] wrong wakeup address
Date: Fri, 15 Oct 2004 13:15:47 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041015111546.GB2015@elf.ucw.cz>
References: <16A54BF5D6E14E4D916CE26C9AD30575546CFA@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD30575546CFA-4yWAQGcml66iAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> acpi_wakeup_address is returned by 'alloc_bootmem_low', so it's a
> virtual address, but 'acpi_set_firmware_wakeing_vector' requires a
> physical address. But what makes me confused is my Toshiba works (S3)
> with/without the patch. Hope this patch (against 2.6.9-rc4) fixes some
> systems which can't resume.

Could you verify that address passed to firmware_waking_vector() is
actually different? If the toshiba works with wrong return
address... perhaps only high bits differ and toshiba just ignores
them?

Anyway it could explain quite a lot of failures.

								Pavel 

> Thanks,
> Shaohua
> 
> Signed-off-by Li Shaohua <Shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> ===== drivers/acpi/sleep/main.c 1.40 vs edited =====
> --- 1.40/drivers/acpi/sleep/main.c	2004-08-17 23:15:34 +08:00
> +++ edited/drivers/acpi/sleep/main.c	2004-10-15 16:58:33 +08:00
> @@ -12,6 +12,7 @@
>  #include <linux/irq.h>
>  #include <linux/dmi.h>
>  #include <linux/device.h>
> +#include <asm/io.h>
>  #include <linux/suspend.h>
>  #include <acpi/acpi_bus.h>
>  #include <acpi/acpi_drivers.h>
> @@ -56,7 +57,8 @@ static int acpi_pm_prepare(u32 pm_state)
>  		if (!acpi_wakeup_address)
>  			return -EFAULT;
>  		acpi_set_firmware_waking_vector(
> -			(acpi_physical_address) acpi_wakeup_address);
> +			(acpi_physical_address) virt_to_phys(
> +			(void *)acpi_wakeup_address));
>  	}
>  	ACPI_FLUSH_CPU_CACHE();
>  	acpi_enable_wakeup_device_prep(acpi_state);



-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
