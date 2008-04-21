From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 1/6] thermal: add the support for building the generic
  thermal as a module
Date: Mon, 21 Apr 2008 11:15:39 +0200
Message-ID: <20080421111539.34e284ec@hyperion.delvare>
References: <1207815114.27304.32.camel@acpi-hp-zz.sh.intel.com>
	<20080416095931.7855a9e8@hyperion.delvare>
	<1208765233.3550.6.camel@rzhang-1.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:16090 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333AbYDUJPy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Apr 2008 05:15:54 -0400
In-Reply-To: <1208765233.3550.6.camel@rzhang-1.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, Hans de Goede <j.w.r.degoede@hhs.nl>, linux-acpi <linux-acpi@vger.kernel.org>

On Mon, 21 Apr 2008 16:07:13 +0800, Zhang Rui wrote:
> Build the generic thermal driver as module "thermal_sys".
> 
> Make ACPI thermal, video, processor and fan SELECT the generic
> thermal driver, as these drivers rely on it to build the sysfs I/F.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/Kconfig      |    3 +++
>  drivers/misc/Kconfig      |    1 +
>  drivers/thermal/Kconfig   |    4 ++--
>  drivers/thermal/Makefile  |    3 ++-
>  drivers/thermal/thermal.c |    2 +-
>  include/linux/thermal.h   |   14 --------------
>  6 files changed, 9 insertions(+), 18 deletions(-)

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare
