From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: getting new hardware (arbor M1526) buttons to work w/ acpi
Date: Thu, 26 Aug 2010 15:20:11 +0800
Message-ID: <1282807211.3707.88.camel@rui>
References: <AANLkTinTLAhRL48sP=B86RMEahx2dg_aczuwS+vn78js@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21593 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752579Ab0HZHQ4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Aug 2010 03:16:56 -0400
In-Reply-To: <AANLkTinTLAhRL48sP=B86RMEahx2dg_aczuwS+vn78js@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yedidia Klein <yedidia@atarplpl.co.il>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

That's interesting.

The first question would be how to catch the hotkey events.
is this hotkey event routed via ACPI?

can you attach the acpidump of this machine please?

thanks,
rui

On Thu, 2010-08-26 at 13:56 +0800, Yedidia Klein wrote:
> Hello list,
> 
> I've a kiosk computer named arbor m1526
> (http://www.arbor.com.tw/products/detail.aspx?Product_Name=M1526.)
> this hardware has some functions key (F1-F8) that are connected to
> Embedded Controller.
> 
> The company do not provide Linux support to these buttons but provided
> information on addresses as follows:
> EC RAM Address 0x0501
> 
> Bit0 = 1 indicative F1 Button be pressed
> Bit1 = 1 indicative F2 Button be pressed
> Bit2 = 1 indicative F3 Button be pressed
> Bit3 = 1 indicative F4 Button be pressed
> Bit4 = 1 indicative F5 Button be pressed
> Bit5 = 1 indicative F6 Button be pressed
> Bit6 = 1 indicative F7 Button be pressed
> Bit7 = 1 indicative F8 Button be pressed
> P.S. If read finish please clear EC ram bit flag.
> 
> I would like to write a new acpi patch/file to the linux kernel for
> supporting these buttons.
> seems to me that the right place is writing a new file at drivers/platform/x86
> 
> I'm looking for some good doc. or template for writing a new hardware
> acpi support.
> 
> any help will be appreciate,
> 
> tnx,
> 
> --Y
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


