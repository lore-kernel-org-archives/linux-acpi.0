From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [patch 4/11]makeing dock driver supports bay and battery hotplug
Date: Thu, 28 Aug 2008 01:13:17 +0200
Message-ID: <871w0aqcfm.fsf@basil.nowhere.org>
References: <1219806876.32665.60.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:37875 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbYH0XNX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Aug 2008 19:13:23 -0400
In-Reply-To: <1219806876.32665.60.camel@sli10-desk.sh.intel.com> (Shaohua Li's message of "Wed, 27 Aug 2008 11:14:36 +0800")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Holger Macht <hmacht@suse.de>, mjg59 <mjg59@srcf.ucam.org>, Tejun Heo <htejun@gmail.com>

Shaohua Li <shaohua.li@intel.com> writes:

> @@ -714,6 +802,7 @@ static DEVICE_ATTR(docked, S_IRUGO, show
>  static ssize_t show_flags(struct device *dev,
>  			  struct device_attribute *attr, char *buf)
>  {
> +	struct dock_station *dock_station = *((struct dock_station **)dev->platform_data);

80 characters? multiple occurrences.

>  
> -postcore_initcall(dock_init);
> +subsys_initcall(dock_init);

Why so early?  

First that needs a comment. Also I don't understand it
(especially since it's modular too) 

-Andi
-- 
ak@linux.intel.com
