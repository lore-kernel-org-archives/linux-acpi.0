From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/3 V3] acpi:soc: merge common codes for creating platform device
Date: Fri, 30 Jan 2015 16:08:08 +0100
Message-ID: <10727316.ODV2mHv2Vx@vostro.rjw.lan>
References: <1418892285.17614.6.camel@kxue-X58A-UD3R> <6052429.AmgHyeF3V4@vostro.rjw.lan> <4AC89B18A26BAB43B540DB1C94E2802C05AA96E0@scybexdag03.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4AC89B18A26BAB43B540DB1C94E2802C05AA96E0@scybexdag03.amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Xue, Ken" <Ken.Xue@amd.com>
Cc: "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Friday, January 30, 2015 07:07:14 AM Xue, Ken wrote:
> Hi Rafael,
> 	I looked into your patch in https://patchwork.kernel.org/patch/5677461/.
> 	I found that "XXX_platform_notify" should be implemented separately  in LPSS and APD driver  instead of "acpi_soc_platform_notify" in acpi_soc.
> 	Because there is WA can't be share with two drivers. And it can make LPSS or APD driver more flexible.
> 
> 	Then only "acpi_soc_create_device" can be shared by LPSS and APD. Maybe, the meaning of acpi_soc becomes less than what we expected.
> 	So, can we go back to two separated drivers without any binding?

I don't want code duplication between them, though.  So if there's a function
that may be shared between them, it should be shared.  And so on.  No duplicate
data structure definitions etc.

> And try thoughts about acpi_soc, if there were more common features.

As I said.  If you can do that without code duplication, please feel free to try.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
