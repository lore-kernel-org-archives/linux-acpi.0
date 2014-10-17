From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 00/12] Add ACPI _DSD and unified device properties support
Date: Fri, 17 Oct 2014 20:04:52 +0200
Message-ID: <D04C5E60-527A-4CA9-954D-60A82AF0413A@arndb.de>
References: <2660541.BycO7TFnA2@vostro.rjw.lan> <11223831.j9KAEfSQsY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <11223831.j9KAEfSQsY@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@linaro.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Darren Hart <dvhart@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-acpi@vger.kernel.org



On October 17, 2014 2:01:33 PM CEST, "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
>Hi Everyone,
>
>Hving had a couple of chats with Grant and Arnd during LinuxCon EU/LPC,
>we
>now have version 5 taking all feedback into account (hopefully).

Awesome, that was really fast. I'm currently on my way his me in the train, replying from my phone, but it looks good now. I'll have a more detailed look next week but I'm definitely happy to see this go in (to next and 3.19) now, any details we still find can be fixed on top.

> In
>short, if
>we are passed a struct fwnode_handle pointer, we can get from it to the
>appropriate device node pointer (either struct acpi_device or struct
>device_node)
>using container_of() after we've checked the type.  This is needed for
>the code
>that needs to access child nodes of a device in case when they don't
>have
>struct device representations (whatever the reason).  This has been
>suggested
>by Grant and pretty much everyone involved agrees that it's better that
>the
>alternatives presented so far.

Yes, it's nice enough that I now take back all the objections I had for the child accessory API.

        Arnd
