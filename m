From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/5] gpiolib: convert ACPI GPIO helpers to gpiod_ interfaces
Date: Mon, 07 Oct 2013 14:18:56 +0200
Message-ID: <1459866.s5LiRGpgct@vostro.rjw.lan>
References: <1380639537-23406-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1380639537-23406-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Mathias Nyman <mathias.nyman@linux.intel.com>, Alexandre Courbot <acourbot@nvidia.com>, Rob Landley <rob@landley.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday, October 01, 2013 05:58:52 PM Mika Westerberg wrote:
> Hi all,
> 
> This series converts the ACPI GPIO helpers in gpiolib-acpi.c to use the new
> and preferred GPIO descriptor based interface as suggested by the GPIO
> subsystem maintainer.
> 
> The first patch is just a cosmetic fix to move acpi_gpiochip_free_interrupts()
> closer to acpi_gpiochip_request_interrupts(). Patches [2-5/5] do the actual
> conversion.
> 
> The series is based on the latest patches from Alexandre Courbot and I've
> tested them on Intel Haswell based machine.
> 
> Please review.
> 
> Mika Westerberg (5):
>   gpiolib / ACPI: move acpi_gpiochip_free_interrupts next to the request function
>   gpiolib / ACPI: convert to gpiod interfaces
>   gpiolib / ACPI: add ACPI support for gpiod_get_index()
>   gpiolib / ACPI: allow passing GPIOF_ACTIVE_LOW for GpioInt resources
>   gpiolib / ACPI: document the GPIO descriptor based interface

The patches look good to me so

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

for the whole series.

Thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
