From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: fadt.boot_flags.MSI_not_supported
Date: Wed, 27 Sep 2006 21:23:15 -0700
Message-ID: <20060927212315.59ccbbe4.rdunlap@xenotime.net>
References: <CFF307C98FEABE47A452B27C06B85BB6019B425D@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:7303 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751285AbWI1EV7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Sep 2006 00:21:59 -0400
Received: from midway.site ([71.117.233.155]) by xenotime.net for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2006 21:21:58 -0700
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6019B425D@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

On Wed, 27 Sep 2006 20:14:58 -0400 Brown, Len wrote:

> sifting through ACPI 3.0a I just noticed a bit (3)
> in the FADT boot_flag to indicate the platform
> does not support MSI.
> 
> Has anybody noticed fadt.boot_flags bit 3 set on their box?

Would we observe that in kernel boot messages or by using
acpidump?

---
~Randy
