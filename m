From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 10/16] irqchip/gic: Add missing forward declaration for struct device
Date: Mon, 13 Mar 2017 22:45:24 +0100
Message-ID: <4273177.TJH56Hy810@aspire.rjw.lan>
References: <1488809970-25568-1-git-send-email-sakari.ailus@linux.intel.com> <1488809970-25568-11-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:44435 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752799AbdCMVut (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 13 Mar 2017 17:50:49 -0400
In-Reply-To: <1488809970-25568-11-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

On Monday, March 06, 2017 04:19:24 PM Sakari Ailus wrote:
> A pointer to struct device is used in the header as a function argument
> but there's no declaration for it. Add one.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  include/linux/irqchip/arm-gic.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
> index eafc965..b16afa1 100644
> --- a/include/linux/irqchip/arm-gic.h
> +++ b/include/linux/irqchip/arm-gic.h
> @@ -100,6 +100,7 @@
>  
>  #include <linux/irqdomain.h>
>  
> +struct device;
>  struct device_node;
>  struct gic_chip_data;

That should be folded into the patch that really depends on it and then it
would require an ACK from the maintainer of arm-gic.h.

Thanks,
Rafael

