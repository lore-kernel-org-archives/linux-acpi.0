From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: drivers for Lenovo 3000 series?
Date: Mon, 13 Apr 2009 09:27:49 +0800
Message-ID: <1239586069.5564.9.camel@localhost.localdomain>
References: <d0cc17060904120051h11e44079u5cf8174466b4e71e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:22527 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750734AbZDMB0c (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 12 Apr 2009 21:26:32 -0400
In-Reply-To: <d0cc17060904120051h11e44079u5cf8174466b4e71e@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andika Triwidada <andika@startrek.or.id>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Sun, 2009-04-12 at 15:51 +0800, Andika Triwidada wrote:
> Hi all,
> 
> I have a Lenovo 3000 G430 [1] which seems to work ok except for
> brightness control
> 
> but from [2]:
> "... The ACPI and EC firmware are completely incompatible with
> ThinkPads, and ibm-acpi/thinkpad-acpi will not support it. The Lenovo
> 3000 are not ThinkPads."
> 
> so, what do you suggest? create a new driver for Lenovo 3000 series?
> Can I use thinkpad_acpi.c as a start or should I start from scratch?
Will you please check whether there exists the ACPI generic backlight
I/F under the /sys/class/backlight/acpi_video0/*? If exists, please
check whether the backlight can be controlled by using the sys ACPI I/f.
   for example: echo 5 > /sys/class/backlight/*/brightness
   (Of course you had better test it under the X environment. And you
should assure that the acpi video driver is loaded).

Will you please attach the output of acpidump?
> 
> Thanks
> Andika Triwidada
> 
> [1] http://research.indocisc.com/~andika/g430/lenovo-g430.html
> [2] http://www.thinkwiki.org/wiki/Category:Lenovo_3000
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

