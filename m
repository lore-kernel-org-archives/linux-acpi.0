From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 08/13] ACPI: thinkpad-acpi: add sysfs led class support
 for thinklight (v3.1)
Date: Fri, 11 Apr 2008 17:24:02 -0700
Message-ID: <20080411172402.a863c6c7.randy.dunlap@oracle.com>
References: <1207799585-10112-1-git-send-email-hmh@hmh.eng.br>
	<1207799585-10112-9-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rgminet01.oracle.com ([148.87.113.118]:30705 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758049AbYDLA0K (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Apr 2008 20:26:10 -0400
In-Reply-To: <1207799585-10112-9-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Len Brown <lenb@kernel.org>, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>

On Thu, 10 Apr 2008 00:53:00 -0300 Henrique de Moraes Holschuh wrote:

> Add a sysfs led class interface to the thinklight (light subdriver).
> 
> Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> Cc: Richard Purdie <rpurdie@rpsys.net>
> ---
>  Documentation/laptops/thinkpad-acpi.txt |   25 +++++++++++---
>  drivers/misc/thinkpad_acpi.c            |   57 ++++++++++++++++++++++++++++++-
>  2 files changed, 76 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
> index 0f403ff..22c1ac4 100644
> --- a/Documentation/laptops/thinkpad-acpi.txt
> +++ b/Documentation/laptops/thinkpad-acpi.txt
> @@ -692,16 +692,31 @@ while others are still having problems. For more information:
>  
>  https://bugs.freedesktop.org/show_bug.cgi?id=2000
>  
> -ThinkLight control -- /proc/acpi/ibm/light
> -------------------------------------------
> +ThinkLight control
> +------------------
> +
> +procfs: /proc/acpi/ibm/light
> +sysfs attributes: as per led class, for the "tpacpi::thinklight" led
> +

Well, I would really prefer that we call LEDs "LED" instead of "led"
in user documentation.

> +procfs notes:
>  
> -The current status of the ThinkLight can be found in this file. A few
> -models which do not make the status available will show it as
> -"unknown". The available commands are:
> +The ThinkLight status can be read and set through the procfs interface.  A
> +few models which do not make the status available will show the ThinkLight
> +status as "unknown". The available commands are:
>  
>  	echo on  > /proc/acpi/ibm/light
>  	echo off > /proc/acpi/ibm/light
>  
> +sysfs notes:
> +
> +The ThinkLight sysfs interface is documented by the led class
> +documentation, in Documentation/leds-class.txt.  The ThinkLight led name
> +is "tpacpi::thinklight".
> +
> +Due to limitations in the sysfs led class, if the status of the thinklight
> +cannot be read or if it is unknown, thinkpad-acpi will report it as "off".
> +It is impossible to know if the status returned through sysfs is valid.
> +
>  Docking / undocking -- /proc/acpi/ibm/dock
>  ------------------------------------------


---
~Randy
