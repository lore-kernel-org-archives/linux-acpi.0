From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 0/2] more patches for removable drive bay
Date: Tue, 19 Dec 2006 23:28:32 -0500
Message-ID: <200612192328.32595.lenb@kernel.org>
References: <20061216144042.a994bf91.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56139 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964875AbWLTE3G (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Dec 2006 23:29:06 -0500
In-Reply-To: <20061216144042.a994bf91.kristen.c.accardi@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Thanks for removing the new procfs code Kristen.

applied.
-Len

On Saturday 16 December 2006 17:40, Kristen Carlson Accardi wrote:
> Hi Len,
> Here's a set of patches for changing the removable drive bay driver
> (drivers/acpi/bay) from using the old proc interface to using a sysfs
> interface instead.  I made the bay driver a platform driver, and 
> so it's entries will now be located in /sys/devices/platform/bay.X.
> There are still 2 entries - one for checking whether the bay is
> present (present) that is read only, and one that is write only for
> ejecting the bay (eject).  Let me know if you would prefer me to fold
> these into the original bay driver patch.
> 
> Thanks,
> Kristen
> --
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
