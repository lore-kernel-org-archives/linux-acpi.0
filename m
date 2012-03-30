From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v3 3/3] PM / Runtime: Add may_power_off flag to subsys
 data
Date: Fri, 30 Mar 2012 01:49:23 -0400
Message-ID: <4F754963.4080104@kernel.org>
References: <1333001380-6050-1-git-send-email-ming.m.lin@intel.com> <1333001380-6050-4-git-send-email-ming.m.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:43501 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421Ab2C3Ft0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Mar 2012 01:49:26 -0400
In-Reply-To: <1333001380-6050-4-git-send-email-ming.m.lin@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Why?

-Len

On 03/29/2012 02:09 AM, Lin Ming wrote:

> Parent device will check child's may_power_off flag to see if child device can
> be powered off.
> 
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> ---
>  include/linux/pm.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index e4982ac..c9953b4 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -465,6 +465,7 @@ struct pm_subsys_data {
>  #ifdef CONFIG_PM_GENERIC_DOMAINS
>  	struct pm_domain_data *domain_data;
>  #endif
> +	bool may_power_off;
>  };
>  
>  struct dev_pm_info {


