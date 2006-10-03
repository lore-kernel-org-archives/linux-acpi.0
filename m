From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] misc,acpi,backlight: MSI S270 Laptop support
Date: Mon, 2 Oct 2006 18:48:40 -0700
Message-ID: <20061002184840.e5c090f2.akpm@osdl.org>
References: <20061003011056.GA28731@ecstasy.ring2.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:10401 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030237AbWJCBss (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Oct 2006 21:48:48 -0400
In-Reply-To: <20061003011056.GA28731@ecstasy.ring2.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, s270-linux@mail.0pointer.de

On Tue, 3 Oct 2006 03:10:56 +0200
Lennart Poettering <mzxreary@0pointer.de> wrote:

> From: Lennart Poettering <mzxreary@0pointer.de>
> 
> A driver for the special features of MSI S270 laptops (and maybe other
> MSI laptops). This driver implements a backlight device for
> controlling LCD brightness (/sys/class/backlight/msi-laptop-bl/).  In
> addition it allows access to the WLAN and Bluetooth states through a
> platform driver (/sys/devices/platform/msi-laptop-pf/).
> 
> ...
>

err, this driver has only about fifteen tab characters in it.  The whole
thing is using lean-on-the-spacebar instead of hard tabs.

fix, please??

> +static ssize_t store_lcd_level(
> +                struct device *dev, struct device_attribute *attr, const char *buf, size_t count) {

No, kernel-style is

static ssize_t store_lcd_level(struct device *dev,
	struct device_attribute *attr, const char *buf, size_t count)
{

or thereabouts.


