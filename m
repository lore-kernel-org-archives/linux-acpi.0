From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 4/5] ACPI: remove deprecated ACPI procfs I/F
Date: Sat, 12 Jun 2010 11:04:55 +0800
Message-ID: <1276311895.19052.17253.camel@rzhang1-desktop>
References: <1276235281.19052.15874.camel@rzhang1-desktop>
	 <alpine.LFD.2.00.1006111202430.4096@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5121 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751982Ab0FLDEc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Jun 2010 23:04:32 -0400
In-Reply-To: <alpine.LFD.2.00.1006111202430.4096@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Sat, 2010-06-12 at 00:06 +0800, Len Brown wrote:
> On Fri, 11 Jun 2010, Zhang Rui wrote:
> 
> > 
> > 1. Remove some deprecated ACPI procfs I/F, including
> >    /proc/acpi/info, /proc/acpi/dsdt, /proc/acpi/fadt.
> 
> yay!
> 
> > 2. Move the code for sysfs I/F to driver/acpi/sysfs.c.
> 
> two patches please: the delete of a user visible function
> in the first, and move the code in the second.
> 
Okay, further more, I'll re-generate the patch in this way,
Patch 01. Remove all the deprecated procfs I/F.
Patch 02. Introduce driver/acpi/sysfs.c and move the code for
          ACPI sysfs I/F to this file.
Patch 03. Introduce drivers/acpi/debugfs.c and remove
          drivers/acpi/debug.c as it's NULL.
Patch 04. Introduce the new module parameter.

what do you think?

thanks,
rui

