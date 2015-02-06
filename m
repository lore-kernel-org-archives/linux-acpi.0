From: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH V4] acpi:apd:add AMD ACPI2Platform device support for x86
 system.
Date: Fri, 6 Feb 2015 11:37:40 +0200
Message-ID: <20150206093740.GV18758@lahna.fi.intel.com>
References: <1423182892.2918.3.camel@kxue-X58A-UD3R>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423182892.2918.3.camel@kxue-X58A-UD3R>
Sender: linux-kernel-owner@vger.kernel.org
To: Ken Xue <Ken.Xue@amd.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Feb 06, 2015 at 08:34:52AM +0800, Ken Xue wrote:
> >From 1a6a3a5c0815cb1f52ec0a2b9601edfa9bfebe81 Mon Sep 17 00:00:00 2001
> From: Ken Xue <Ken.Xue@amd.com>
> Date: Fri, 6 Feb 2015 08:27:51 +0800
> Subject: [PATCH] acpi:apd:add AMD ACPI2Platform device support for x86 system.
> 
> This new feature is to interpret AMD specific ACPI device to
> platform device such as I2C, UART, GPIO found on AMD CZ and
> later chipsets. It based on example intel LPSS. Now, it can
> support AMD I2C, UART and GPIO.
> 
> Signed-off-by: Ken Xue <Ken.Xue@amd.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
