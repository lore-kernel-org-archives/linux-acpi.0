From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi:apd:add AMD ACPI2Platform device support for x86 system.
Date: Mon, 24 Nov 2014 02:47:32 +0100
Message-ID: <2267517.glgofXUn7B@vostro.rjw.lan>
References: <1416290291-5802-1-git-send-email-Ken.Xue@amd.com> <20864469.6Ozf1NSibZ@vostro.rjw.lan> <4AC89B18A26BAB43B540DB1C94E2802C05A48D06@scybexdag03.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56746 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750900AbaKXB0U (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 23 Nov 2014 20:26:20 -0500
In-Reply-To: <4AC89B18A26BAB43B540DB1C94E2802C05A48D06@scybexdag03.amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Xue, Ken" <Ken.Xue@amd.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Wu, Jeff" <Jeff.Wu@amd.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andriy Shevchenko <andriy.shevchenko@intel.com>

On Monday, November 24, 2014 01:02:30 AM Xue, Ken wrote:
> 
> On Tuesday, November 18, 2014 01:58:11 PM Ken Xue wrote:
> > This new feature is to interpret AMD specific ACPI device to platform 
> > device such as I2C, UART found on AMD CZ and later chipsets. It is 
> > based on example INTEL LPSS. Now, it can support AMD I2C & UART.
> > 
> > Signed-off-by: Ken Xue <Ken.Xue@amd.com>
> > Signed-off-by: Jeff Wu <Jeff.Wu@amd.com>
> 
> Generally speaking, this seems to duplicate much code from acpi_lpss which should be re-used instead.  What about moving the code that will be common between acpi_lpss and the new driver into a new file (say acpi_soc.c)?
> 
> Also, you need to avoid automatic creation of platform devices when !X86_AMD_PLATFORM_DEVICE in analogy with what acpi_lpss does, or bad things will happen.
> 
> [ken] sounds fair enough.  Let me take action to merge drivers to acpi_soc.c ? or you have other plan?

I'd prefer the common code to reside in one file (or one .c file and one header
file), and the driver-specific code to stay in separate per-driver files.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
