From: "Zhao Forrest" <forrest.zhao@gmail.com>
Subject: Re: [PATCH 2/2] acpi: Disable IRQ 0 through I/O APIC for some HP systems
Date: Mon, 7 Jul 2008 11:54:01 +0800
Message-ID: <ac8af0be0807062054nbced6b0pd378aeda91a3c538@mail.gmail.com>
References: <Pine.LNX.4.55.0807010055070.30785@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:15389 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753924AbYGGDyC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Jul 2008 23:54:02 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1300899waf.23
        for <linux-acpi@vger.kernel.org>; Sun, 06 Jul 2008 20:54:01 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.55.0807010055070.30785@cliff.in.clinika.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Ingo Molnar <mingo@elte.hu>, Matthew Garrett <mjg59@srcf.ucam.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-next@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

> Hello,
>
>  Matthew, you have not added your sign-off with the original patch, please
> do so now.
>
>  Rafael, please try this change together with
> patch-2.6.26-rc1-20080505-mpparse-acpi-noirq0-2 and see if this fixes your
> system.
>
>  I have tried the patches with a wildcard entry added to acpi_dmi_table[]
> so that it trips for my system.  The result is as follows:

Since we add a new entry to acpi_dmi_table[], I think it's necessary
for this new entry to preserve the semantics of this table, that is
"acpi=force overrules DMI blacklist", am I right?

Thanks,
Forrest
