From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH -v3] ACPI, APEI, ERST debug support
Date: Thu, 12 Aug 2010 08:57:09 -0700
Message-ID: <4C6419D5.80705@oracle.com>
References: <1281585317.2744.1468.camel@yhuang-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:52367 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045Ab0HLQAc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Aug 2010 12:00:32 -0400
In-Reply-To: <1281585317.2744.1468.camel@yhuang-dev>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <lenb@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>

On 08/11/10 20:55, Huang Ying wrote:
> Hi, Len,
> 
> This is v3 of ERST debug support patch, fixes i386 build error and
> warning. Please replace it in acpi-test.git.
> 
> Best Regards,
> Huang Ying
> -------------------------------------------->
> This patch adds debugging/testing support to ERST. A misc device is
> implemented to export raw ERST read/write/clear etc operations to user
> space. With this patch, we can add ERST testing support to
> linuxfirmwarekit ISO (linuxfirmwarekit.org) to verify the kernel
> support and the firmware implementation.
> 
> 
> v3:
> 
> - Fix ssize_t printk format string instead of cast.
> 
> v2:
> 
> - Fix build error on i386
> 
> Signed-off-by: Huang Ying <ying.huang@intel.com>
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  drivers/acpi/apei/Kconfig    |    9 +
>  drivers/acpi/apei/Makefile   |    1 
>  drivers/acpi/apei/erst-dbg.c |  207 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 217 insertions(+)
>  create mode 100644 drivers/acpi/apei/erst-dbg.c


Works for me.  Thanks.

Acked-by: Randy Dunlap <randy.dunlap@oracle.com>


-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
