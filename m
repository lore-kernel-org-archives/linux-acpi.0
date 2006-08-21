From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] misc,acpi,backlight: MSI S270 Laptop support, third try
Date: Mon, 21 Aug 2006 15:58:31 -0700
Message-ID: <20060821155831.daa8425e.akpm@osdl.org>
References: <20060820225209.GA5453@curacao>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:1203 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751297AbWHUW6v (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Aug 2006 18:58:51 -0400
In-Reply-To: <20060820225209.GA5453@curacao>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: len.brown@intel.com, rubini@vision.unipv.it, pavel@suse.cz, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Mon, 21 Aug 2006 00:52:09 +0200
Lennart Poettering <mzxreary@0pointer.de> wrote:

> +static ssize_t store_auto_brightness(
> +        struct device *dev,
> +        struct device_attribute *attr,
> +        const char *buf, size_t count) {
> +        
> +        int enable, ret;

Please follow the usual kernel coding style, which would yield something like:

static ssize_t store_auto_brightness(struct device *dev,
		struct device_attribute *attr, const char *buf, size_t count)
{
        int enable, ret;

(affects entire patch).

And please also prepare and maintain a standalone changelog.  The one you have here
is full of references to some long-gone email.  Think: "how will my changelog look
when it is in the main git tree".

Thanks.
