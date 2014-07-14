From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [Regression]: Changing brightness does not work with v3.16-rc4
Date: Mon, 14 Jul 2014 10:06:21 +0800
Message-ID: <53C33B1D.4070500@intel.com>
References: <20140712180636.698e2e4c@saldaea>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:57261 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752194AbaGNCGe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 13 Jul 2014 22:06:34 -0400
In-Reply-To: <20140712180636.698e2e4c@saldaea>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Julian Wollrath <jwollrath@web.de>, linux-acpi@vger.kernel.org

On 07/13/2014 12:06 AM, Julian Wollrath wrote:
> Hi,
> 
> changing the brightness on my Thinkpad X230 with Intel HD4000 graphics,
> stopped working after commit 886129a8eebe (ACPI / video: change
> acpi-video brightness_switch_enabled default to 0). Changing it back to
> 1, fixes the problem, if "acpi_osi=!Windows 2012" is also set. Before
> that commit just setting "acpi_osi=!Windows 2012" was enough to get
> changing the brightness working.

Does your system have /sys/class/backlight/intel_backlight? Does it work
if you manually change the brightness file like this:
# cd /sys/class/backlight/intel_backlight
# cat max_brightness
xxxxx
# echo xxx > brightness
# echo xxx > brightness
...

Thanks,
Aaron

> 
> 
> With best regards,
> Julian Wollrath
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

