From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: ACPI_VIDEO and BACKLIGHT_CLASS_DEVICE
Date: Fri, 12 Nov 2010 10:07:07 +0800
Message-ID: <1289527627.8148.1462.camel@rui>
References: <Pine.LNX.4.44L0.1011101646240.1587-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:48386 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752159Ab0KLCF4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Nov 2010 21:05:56 -0500
In-Reply-To: <Pine.LNX.4.44L0.1011101646240.1587-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, 2010-11-11 at 06:02 +0800, Alan Stern wrote:
> Rui:
> 
> Why does CONFIG_ACPI_VIDEO depend on BACKLIGHT_CLASS_DEVICE?  Doesn't
> ACPI_VIDEO apply to any sort of video adapter, including plain old VGA
> adapters attached to a non-LCD device?
> 
There is an ACPI device node (an ACPI video bus device) for the VGA
controller and another ACPI device node (an ACPI video output device)
for the LCD display.
And ACPI_VIDEO knows how to switch the backlight of this integrated
LCD. :)

thanks,
rui


