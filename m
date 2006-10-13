From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/3] Add support for the generic backlight device to the
 TOSHIBA ACPI driver
Date: Fri, 13 Oct 2006 14:56:58 -0700
Message-ID: <20061013145658.99de9f54.akpm@osdl.org>
References: <20061013102419.GD4234@homac.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:9951 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030212AbWJMV5D (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Oct 2006 17:57:03 -0400
In-Reply-To: <20061013102419.GD4234@homac.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Holger Macht <hmacht@suse.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, len.brown@intel.com

On Fri, 13 Oct 2006 12:24:19 +0200
Holger Macht <hmacht@suse.de> wrote:

> +static int set_lcd(int value)
> +{
> +	u32 hci_result;
> +
> +	value = value << HCI_LCD_BRIGHTNESS_SHIFT;
> +	hci_write1(HCI_LCD_BRIGHTNESS, value, &hci_result);
> +	if (hci_result != HCI_SUCCESS)
> +		return -EFAULT;
> +
> +	return 0;

-EFAULT seems a bit random.  Would -EIO be more appropriate?
