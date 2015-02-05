From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V4] acpi:apd:add AMD ACPI2Platform device support for x86 system.
Date: Thu, 05 Feb 2015 16:09:38 +0100
Message-ID: <1767774.KlJWFImEzb@vostro.rjw.lan>
References: <1422928460.2528.16.camel@kxue-X58A-UD3R> <1423105637.18208.35.camel@kxue-X58A-UD3R> <20150205120214.GR18758@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150205120214.GR18758@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, Ken Xue <Ken.Xue@amd.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thursday, February 05, 2015 02:02:14 PM mika.westerberg@linux.intel.com wrote:
> On Thu, Feb 05, 2015 at 11:07:17AM +0800, Ken Xue wrote:
> > >From d22789f089ee644413a144633f368f45cb0ac9d8 Mon Sep 17 00:00:00 2001
> > From: Ken Xue <Ken.Xue@amd.com>
> > Date: Thu, 5 Feb 2015 11:04:44 +0800
> > Subject: [PATCH] acpi:apd:add AMD ACPI2Platform device support for x86 system.
> > 
> > This new feature is to interpret AMD specific ACPI device to
> > platform device such as I2C, UART found on AMD CZ and later chipsets. It
> > based on example intel LPSS. Now, it can support AMD I2C & UART.
> 
> You are missing Signed-off-by here.
> 
> Anyway looks good to me,
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks!

Ken, can you please resend this one with a sign-off?  I can't apply it
otherwise.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
