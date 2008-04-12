From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 06/13] ACPI: thinkpad-acpi: claim tpacpi as an official
 short handle
Date: Fri, 11 Apr 2008 17:21:42 -0700
Message-ID: <20080411172142.cf278f63.randy.dunlap@oracle.com>
References: <1207799585-10112-1-git-send-email-hmh@hmh.eng.br>
	<1207799585-10112-7-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:10775 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757606AbYDLAX6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Apr 2008 20:23:58 -0400
In-Reply-To: <1207799585-10112-7-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Len Brown <lenb@kernel.org>, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Thu, 10 Apr 2008 00:52:58 -0300 Henrique de Moraes Holschuh wrote:

> Unfortunately, a lot of stuff in the kernel has size limitations, so
> "thinkpad-acpi" ends up eating up too much real estate.  We were using
> "tpacpi" in symbols already, but this shorthand was not visible to
> userland.
> 
> Document that the driver will use tpacpi as a short hand where necessary,
> and use it to name the kernel thread for NVRAM polling (now named
> "ktpacpi_nvramd").
> 
> Also, register a module alias with the shorthand.  One can refer to the
> module using the shorthand name.
> 
> Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> ---
>  Documentation/laptops/thinkpad-acpi.txt |    5 +++++
>  drivers/misc/thinkpad_acpi.c            |    8 ++++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
> index bbc8275..0f403ff 100644
> --- a/Documentation/laptops/thinkpad-acpi.txt
> +++ b/Documentation/laptops/thinkpad-acpi.txt
> @@ -18,6 +18,11 @@ This driver used to be named ibm-acpi until kernel 2.6.21 and release
>  moved to the drivers/misc tree and renamed to thinkpad-acpi for kernel
>  2.6.22, and release 0.14.
>  
> +The driver is named "thinkpad-acpi".  In some places, like module
> +names, "thinkpad_acpi" is used because of userspace issues.
> +
> +"tpacpi" is used as a shorthand where "thinkpad-acpi" would be too
> +long due to lenght limitations on some Linux kernel versions.

               length

>  
>  Status
>  ------

---
~Randy
