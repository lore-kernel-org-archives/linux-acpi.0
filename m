From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI : dock: add error handling for acpi_bus_get_device
Date: Thu, 14 Jun 2018 09:54:40 +0200
Message-ID: <CAJZ5v0hjRsVVnvO0rBFxXesTDuE8M+W1YwwAYHp67RMMRikckA@mail.gmail.com>
References: <1528778292-41332-1-git-send-email-jiazhouyang09@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528778292-41332-1-git-send-email-jiazhouyang09@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhouyang Jia <jiazhouyang09@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jun 12, 2018 at 6:38 AM, Zhouyang Jia <jiazhouyang09@gmail.com> wrote:
> When acpi_bus_get_device fails, the lack of error-handling code may
> cause unexpected results.

It is perfectly predictable in this particular case: adev will be NULL
and acpi_device_enumerated(adev) will return false.

> This patch adds error-handling code after calling acpi_bus_get_device.

Which is not necessary.

Thanks,
Rafael
