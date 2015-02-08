From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V4] acpi:apd:add AMD ACPI2Platform device support for x86 system.
Date: Mon, 09 Feb 2015 00:21:36 +0100
Message-ID: <3231153.UiLytMu4Xy@vostro.rjw.lan>
References: <1423182892.2918.3.camel@kxue-X58A-UD3R> <20150206093740.GV18758@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51437 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754898AbbBHW6f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 8 Feb 2015 17:58:35 -0500
In-Reply-To: <20150206093740.GV18758@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
Cc: Ken Xue <Ken.Xue@amd.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Friday, February 06, 2015 11:37:40 AM mika.westerberg@linux.intel.com wrote:
> On Fri, Feb 06, 2015 at 08:34:52AM +0800, Ken Xue wrote:
> > >From 1a6a3a5c0815cb1f52ec0a2b9601edfa9bfebe81 Mon Sep 17 00:00:00 2001
> > From: Ken Xue <Ken.Xue@amd.com>
> > Date: Fri, 6 Feb 2015 08:27:51 +0800
> > Subject: [PATCH] acpi:apd:add AMD ACPI2Platform device support for x86 system.
> > 
> > This new feature is to interpret AMD specific ACPI device to
> > platform device such as I2C, UART, GPIO found on AMD CZ and
> > later chipsets. It based on example intel LPSS. Now, it can
> > support AMD I2C, UART and GPIO.
> > 
> > Signed-off-by: Ken Xue <Ken.Xue@amd.com>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
