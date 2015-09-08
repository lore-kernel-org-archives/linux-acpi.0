From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 5/6] ACPI / gpio: Split acpi_get_gpiod_by_index()
Date: Tue, 8 Sep 2015 11:20:51 +0200
Message-ID: <CACRpkda7x45R+10aXGrafHMWPbr=6_Cxjpvcga5aK1Mn-fzZ1g@mail.gmail.com>
References: <1596179.pGEt0Ullqu@vostro.rjw.lan>
	<8402685.WoxEi8zV68@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33931 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866AbbIHJUv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Sep 2015 05:20:51 -0400
Received: by obbda8 with SMTP id da8so49893053obb.1
        for <linux-acpi@vger.kernel.org>; Tue, 08 Sep 2015 02:20:51 -0700 (PDT)
In-Reply-To: <8402685.WoxEi8zV68@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Darren Hart <darren.hart@intel.com>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, David Woodhouse <dwmw2@infradead.org>, Dustin Byford <dustin@cumulusnetworks.com>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Thu, Aug 27, 2015 at 4:41 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Split acpi_get_gpiod_by_index() into three smaller routines to
> allow the subsequent change of the generic firmware node properties
> code to be more strarightforward.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Feel free to merge this through the ACPI tree if it's a dependency.
If it's not, tell me so I can merge it into the GPIO tree.

Yours,
Linus Walleij
