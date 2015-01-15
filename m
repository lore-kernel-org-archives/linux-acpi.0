From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH] TCO Watchdog warning interrupt driver creation
Date: Thu, 15 Jan 2015 06:49:03 -0800
Message-ID: <54B7D35F.5010907@roeck-us.net>
References: <B9C02DB17496AC4197F41A146D371B9B075AF9DE@hasmsx107.ger.corp.intel.com> <20141211040404.GA28797@vmdeb7> <5489AA6B.9080802@roeck-us.net> <B9C02DB17496AC4197F41A146D371B9B075C5FE3@hasmsx107.ger.corp.intel.com> <E73BFCB9-87CB-447D-839C-9ED4031FC6E2@infradead.org> <B9C02DB17496AC4197F41A146D371B9B075C6189@hasmsx107.ger.corp.intel.com> <54AF6288.6040305@roeck-us.net> <B9C02DB17496AC4197F41A146D371B9B075CC9FA@hasmsx107.ger.corp.intel.com> <20150114181657.GB13907@roeck-us.net> <B9C02DB17496AC4197F41A146D371B9B075D41C0@hasmsx107.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <B9C02DB17496AC4197F41A146D371B9B075D41C0-Jy8z56yoSI9wl47ZQwxUxrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Muller, Francois-nicolas" <francois-nicolas.muller-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Darren Hart <dvhart-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "'platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Linux ACPI Mailing List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On 01/15/2015 05:27 AM, Muller, Francois-nicolas wrote:
> TCO driver is anyway auto-loaded by mfd driver lpc_ich as a sub-function of it.
>
> The aim of my patch is only to add warning interrupt support in TCO driver.
> For this it need the GPE number which is exposed by Bios in acpi tables.
> So the patch registers also the TCO driver as an acpi driver to be able to retrieve this value.
>
> The acpi code part is only required by the interrupt handling support, not needed for the loading of the driver itself (already done by lpc_ich).
>
> In this context I don't see the point of dissociating the driver part from the loading, unless the loading would need to be reverted later.
>

Ok, makes sense.

Regarding the patch itself, I'll leave it up to Wim to decide what to do.
Personally I dislike the notion of panicing as response to a watchdog timeout.

Guenter

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
