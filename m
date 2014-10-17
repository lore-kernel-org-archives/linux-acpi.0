From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 10/12] gpio: Support for unified device properties interface
Date: Fri, 17 Oct 2014 20:09:51 +0200
Message-ID: <E99B44D9-C9E3-4C0B-8B18-450121793EB5@arndb.de>
References: <2660541.BycO7TFnA2@vostro.rjw.lan> <11223831.j9KAEfSQsY@vostro.rjw.lan> <1510578.dSiEYPPI9m@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:52108 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127AbaJQSY3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Oct 2014 14:24:29 -0400
In-Reply-To: <1510578.dSiEYPPI9m@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Darren Hart <dvhart@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>



On October 17, 2014 2:16:00 PM CEST, "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
>From: Mika Westerberg <mika.westerberg@linux.intel.com>
>
>Some drivers need to deal with only firmware representation of its
>GPIOs. An example would be a GPIO button array driver where each button
>is described as a separate firmware node in device tree. Typically
>these
>child nodes do not have physical representation in the Linux device
>model.
>
>In order to help device drivers to handle such firmware child nodes we
>add dev[m]_get_named_gpiod_from_child() that takes a child firmware
>node pointer as its second argument (the first one is the parent device
>itself), finds the GPIO using whatever is the underlying firmware
>method, and requests the GPIO properly.

Could we also have a wrapper around this function without a "name" argument, using just the index?

       Arnd
