From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 14/16] of: Add nop implementation of of_get_next_parent()
Date: Mon, 13 Mar 2017 22:55:01 +0100
Message-ID: <3876288.h7t1S52nK5@aspire.rjw.lan>
References: <1488809970-25568-1-git-send-email-sakari.ailus@linux.intel.com> <1488809970-25568-15-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:55366 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752688AbdCMWA1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 13 Mar 2017 18:00:27 -0400
In-Reply-To: <1488809970-25568-15-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

On Monday, March 06, 2017 04:19:28 PM Sakari Ailus wrote:
> To avoid #ifdefs where the function is used.

A bit more explanation?

About where this happens (or will happen) to be used with CONFIG_OF unset?

Plus, that would require an ACK from Rob.

> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  include/linux/of.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/of.h b/include/linux/of.h
> index d48e225..c05fe25 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -586,6 +586,12 @@ static inline struct device_node *of_get_parent(const struct device_node *node)
>  	return NULL;
>  }
>  
> +static inline struct device_node *of_get_next_parent(
> +	const struct device_node *node)
> +{
> +	return NULL;
> +}
> +
>  static inline struct device_node *of_get_next_child(
>  	const struct device_node *node, struct device_node *prev)
>  {
> 

Thanks,
Rafael

