From: vgod spam <vgod.spam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH]Panasonic Hotkey Driver
Date: Sat, 21 Aug 2004 19:50:31 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <f824eca2040821045017e87b3c@mail.gmail.com>
References: <41244219.1090603@linuxboxen.org>
	<87zn4pl116.wl%miura@da-cha.org>
	<87n00pkqc5.wl%miura@da-cha.org>
	<41270B53.3060903@linuxboxen.org> <87d61klqzh.wl%miura@da-cha.org>
Reply-To: vgod spam <vgod.spam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <87d61klqzh.wl%miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Hiroshi Miura <miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org>
Cc: ACPI-Devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,
I found a little problem in your driver(ver 0.5)...

> result = acpi_bus_register_driver(&acpi_hotkey_driver);
> if (ACPI_FAILURE(result)) {
>             ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error registering hotkey driver\n"));
>             return_VALUE(-ENODEV);
>}
The return value of acpi_bus_register_driver is the number of devices
that were claimed by the driver, or a negative error status for
failure. But ACPI_FAILURE is a macro for checking whether the value is
zero or not. I think using "if ( result < 0 ) {.." here is better.

BTW, I have wrote a user space hotkey handler in Perl, which supported
LCD brightness adjustment now:)
It is available at http://vgod.info/dl/w2d/hotkey


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
