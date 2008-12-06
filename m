From: Matthias Heinz <mheinz@cs.uni-frankfurt.de>
Subject: Re: samsung x360, acpi support
Date: Sat, 6 Dec 2008 14:26:07 +0100
Message-ID: <200812061426.08294.mheinz@cs.uni-frankfurt.de>
References: <200812041915.39971.mheinz@cs.uni-frankfurt.de> <20081206114358.GA4821@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.rbi.informatik.uni-frankfurt.de ([141.2.1.1]:33506 "EHLO
	hera.rbi.informatik.uni-frankfurt.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751997AbYLFN0x (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Dec 2008 08:26:53 -0500
In-Reply-To: <20081206114358.GA4821@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

Am Samstag, 6. Dezember 2008 schrieb Matthew Garrett:
> Do you have the i915 module loaded? NVID is simply the vendor's name for
> the ACPI object representing the video controller.

Its compiled into my kernel. I can add the config of both kernels, if needed. 
I even compiled the 2.6.28-rc7 kernel with the config of the 2.6.26, but the 
backlight support didnt work. It looks like its something that changed over 
the time.


> There's no standardised way for controlling LEDs via ACPI, so it's
> probably a wifi driver issue.

I'll report it there then.


> The brightness keys will be trapped by the BIOS and brightness change
> code run in system management mode before ACPI is enabled, which only
> happens part-way through the Linux boot process. So it's normal for the
> behaviour to change at that point. It's also not unusual for hotkeys to
> be sent via the ekyboard - ACPI doesn't have any specified way for
> handling generic hotkeys other than the sleep and power buttons.

Then this is totally fine and i have to find a way to intercept those key 
events before X can grab them.


Regards,
Matthias
