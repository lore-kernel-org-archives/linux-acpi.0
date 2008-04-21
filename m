From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 3/6] thermal: add hwmon sysfs I/F
Date: Mon, 21 Apr 2008 11:25:54 +0200
Message-ID: <20080421112554.3768a4da@hyperion.delvare>
References: <1207815360.27304.39.camel@acpi-hp-zz.sh.intel.com>
	<20080416224555.15304b3d@hyperion.delvare>
	<1208765272.3550.7.camel@rzhang-1.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:1081 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755091AbYDUJ0G (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Apr 2008 05:26:06 -0400
In-Reply-To: <1208765272.3550.7.camel@rzhang-1.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, Hans de Goede <j.w.r.degoede@hhs.nl>, linux-acpi <linux-acpi@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, waldi@debian.org

On Mon, 21 Apr 2008 16:07:52 +0800, Zhang Rui wrote:
> "hwmon_already_available" was used at the beginning.
> I renamed this flag later but forget to change the logic. :)
> Please review the patch below.
> 
> 
> Add hwmon sys I/F for generic thermal driver.
> 
> Note: we have one hwmon class device for EACH TYPE of the thermal zone device.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/thermal/thermal.c |  163 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/thermal.h   |   24 ++++++
>  2 files changed, 187 insertions(+)

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare
