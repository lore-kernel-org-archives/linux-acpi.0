From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI / WMI: Call acpi_wmi_init() later
Date: Sat, 6 Jan 2018 00:30:23 +0100
Message-ID: <CAJZ5v0jxVUxFetwPaj76FoeQjHtSSwO+4jiEqadA1WXZ_YNNoQ@mail.gmail.com>
References: <20171208151159.urdcrzl5qpfd6jnu@earth.li> <2601877.IhOx20xkUK@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35347 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752370AbeAEXaY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Jan 2018 18:30:24 -0500
In-Reply-To: <2601877.IhOx20xkUK@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>
Cc: Jonathan McDowell <noodles@earth.li>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Platform Driver <platform-driver-x86@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>

On Wed, Jan 3, 2018 at 12:49 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Calling acpi_wmi_init() at the subsys_initcall() level causes ordering
> issues to appear on some systems and they are difficult to reproduce,
> because there is no guaranteed ordering between subsys_initcall()
> calls, so they may occur in different orders on different systems.
>
> In particular, commit 86d9f48534e8 (mm/slab: fix kmemcg cache
> creation delayed issue) exposed one of these issues where genl_init()
> and acpi_wmi_init() are both called at the same initcall level, but
> the former must run before the latter so as to avoid a NULL pointer
> dereference.
>
> For this reason, move the acpi_wmi_init() invocation to the
> initcall_sync level which should still be early enough for things
> to work correctly in the WMI land.
>
> Link: https://marc.info/?t=151274596700002&r=1&w=2
> Reported-by: Jonathan McDowell <noodles@earth.li>
> Reported-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Tested-by: Jonathan McDowell <noodles@earth.li>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Guys, this fixes a crash on boot.

If there are no concerns/objections I will just take it through the ACPI tree.

> ---
>  drivers/platform/x86/wmi.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Index: linux-pm/drivers/platform/x86/wmi.c
> ===================================================================
> --- linux-pm.orig/drivers/platform/x86/wmi.c
> +++ linux-pm/drivers/platform/x86/wmi.c
> @@ -1458,5 +1458,5 @@ static void __exit acpi_wmi_exit(void)
>         class_unregister(&wmi_bus_class);
>  }
>
> -subsys_initcall(acpi_wmi_init);
> +subsys_initcall_sync(acpi_wmi_init);
>  module_exit(acpi_wmi_exit);
>
> --
