From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 5/5] ACPI: introduce module parameter acpi.aml_debug
Date: Fri, 11 Jun 2010 12:11:14 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1006111209180.4096@localhost.localdomain>
References: <1276235286.19052.15875.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:57319 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823Ab0FKQLb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Jun 2010 12:11:31 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L3U006UNYARTB44@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 11 Jun 2010 11:11:21 -0500 (CDT)
In-reply-to: <1276235286.19052.15875.camel@rzhang1-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Lin Ming <ming.m.lin@intel.com>, "Moore, Robert" <robert.moore@intel.com>

On Fri, 11 Jun 2010, Zhang Rui wrote:

> Introduce module parameter acpi.aml_debug.
> 
> With acpi.aml_debug set, we can get AML debug object
> output (Store (AAA, Debug)), even with CONFIG_ACPI_DEBUG
> cleared.
> 
> Together with the runtime custom method,
> we can debug AML code problems without rebuilding the kernel.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/acpica/acglobal.h |    2 +-
>  drivers/acpi/sysfs.c           |    4 ++++
>  include/acpi/acpixf.h          |    2 +-
>  3 files changed, 6 insertions(+), 2 deletions(-)

Is there an update to Documentation/acpi/ ?

thanks,
Len Brown, Intel Open Source Technology Center


