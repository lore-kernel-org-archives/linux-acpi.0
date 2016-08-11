From: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v10 0/8] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
Date: Thu, 11 Aug 2016 18:15:50 +0800
Message-ID: <510fa357-a729-4ce1-7c10-4cef06feb7b7@linaro.org>
References: <1469535565-20924-1-git-send-email-fu.wei@linaro.org>
 <0befd611-91a7-88e9-1686-82929c1745e8@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0befd611-91a7-88e9-1686-82929c1745e8-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org
Cc: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rruigrok-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, wei-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org, leo.duran-5C7GfCeVMHo@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

On 2016/8/11 17:37, Tomasz Nowicki wrote:
> Hi Fu,
>
> Do you mind if I send IORT series where new drivers/acpi/arm64 directory
> would be introduced in first place ? This means your GTDT set would
> depend on IORT.

I think it's reasonable as the IORT for ITS is the key device enablement
for PCI MSI. I talked to Fuwei offline and he is fine with it.

But both the GTDT patchset and IORT are in good shape now, can we
targeting both of them for 4.9 kernel (since all go via tip tree)?

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
