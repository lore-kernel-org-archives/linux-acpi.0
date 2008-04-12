From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 09/13] ACPI: thinkpad-acpi: add sysfs led class support
 to thinkpad leds (v3.1)
Date: Fri, 11 Apr 2008 17:21:10 -0700
Message-ID: <20080411172110.c592616d.randy.dunlap@oracle.com>
References: <1207799585-10112-1-git-send-email-hmh@hmh.eng.br>
	<1207799585-10112-10-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:10604 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756782AbYDLAWL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Apr 2008 20:22:11 -0400
In-Reply-To: <1207799585-10112-10-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Len Brown <lenb@kernel.org>, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>

On Thu, 10 Apr 2008 00:53:01 -0300 Henrique de Moraes Holschuh wrote:

> Add a sysfs led class interface to the led subdriver.
> 
> Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> Cc: Richard Purdie <rpurdie@rpsys.net>
> ---
>  Documentation/laptops/thinkpad-acpi.txt |   47 +++++++++--
>  drivers/misc/thinkpad_acpi.c            |  136 ++++++++++++++++++++++++++++++-
>  2 files changed, 176 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
> index 22c1ac4..27ca0f9 100644
> --- a/Documentation/laptops/thinkpad-acpi.txt
> +++ b/Documentation/laptops/thinkpad-acpi.txt
> @@ -875,28 +875,63 @@ The cmos command interface is prone to firmware split-brain problems, as
>  in newer ThinkPads it is just a compatibility layer.  Do not use it, it is
>  exported just as a debug tool.
>  
> -LED control -- /proc/acpi/ibm/led
> ----------------------------------
> +LED control
> +-----------
>  
> -Some of the LED indicators can be controlled through this feature. The
> -available commands are:
> +procfs: /proc/acpi/ibm/led
> +sysfs attributes: as per led class, see below for names
> +
> +Some of the LED indicators can be controlled through this feature.  On
> +some older ThinkPad models, it is possible to query the status of the
> +LED indicators as well.  Newer ThinkPads cannot query the real status
> +of the LED indicators.
> +
> +procfs notes:
> +
> +The available commands are:
>  
>  	echo '<led number> on' >/proc/acpi/ibm/led
>  	echo '<led number> off' >/proc/acpi/ibm/led
>  	echo '<led number> blink' >/proc/acpi/ibm/led
>  
>  The <led number> range is 0 to 7. The set of LEDs that can be
> -controlled varies from model to model. Here is the mapping on the X40:
> +controlled varies from model to model. Here is the common ThinkPad
> +mapping:
>  
>  	0 - power
>  	1 - battery (orange)
>  	2 - battery (green)
> -	3 - UltraBase
> +	3 - UltraBase/dock
>  	4 - UltraBay
> +	5 - UltraBase battery slot
> +	6 - (unknown)
>  	7 - standby
>  
>  All of the above can be turned on and off and can be made to blink.
>  
> +sysfs notes:
> +
> +The ThinkPad LED sysfs interface is described in detail by the led class
> +documentation, in Documentation/leds-class.txt.
> +
> +The leds are named (in LED ID order, from 0 to7):

                                               to 7):

> +"tpacpi::power", "tpacpi:orange:batt", "tpacpi:green:batt",
> +"tpacpi::dock_active", "tpacpi::bay_active", "tpacpi::dock_batt",
> +"tpacpi::unknown_led", "tpacpi::standby".
> +
> +Due to limitations in the sysfs led class, if the status of the LED
> +indicators cannot be read due to an error, thinkpad-acpi will report it as
> +a brightness of zero (same as LED off).
> +
> +If the thinkpad firmware doesn't support reading the current status,
> +trying to read the current LED brightness will just return whatever
> +brightness was last written to that attribute.
> +
> +These LEDs can blink using hardware acceleration.  To request that a
> +ThinkPad indicator LED should blink in hardware accelerated mode, use the
> +"timer" trigger, and leave the delay_on and delay_off parameters set to
> +zero (to request hardware acceleration autodetection).
> +
>  ACPI sounds -- /proc/acpi/ibm/beep
>  ----------------------------------


---
~Randy
