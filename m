From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH -v2] ACPI, APEI, ERST debug support
Date: Wed, 11 Aug 2010 08:13:49 -0700
Message-ID: <4C62BE2D.3030609@oracle.com>
References: <1281490670.2744.1331.camel@yhuang-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:18370 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825Ab0HKPQv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Aug 2010 11:16:51 -0400
In-Reply-To: <1281490670.2744.1331.camel@yhuang-dev>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <lenb@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>

On 08/10/10 18:37, Huang Ying wrote:
> Hi, Len,
> 
> There is build error on i386 in the previous version. This new version fixed
> it, please replace it in acpi-test.git.
> 
> Best Regards,
> Huang Ying
> ------------------------------->
> This patch adds debugging/testing support to ERST. A misc device is
> implemented to export raw ERST read/write/clear etc operations to user
> space. With this patch, we can add ERST testing support to
> linuxfirmwarekit ISO (linuxfirmwarekit.org) to verify the kernel
> support and the firmware implementation.
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

A patch against linux-next (or some acpi tree) would have been better
for testing, but anyway, I fixed that little problem.

Acked-by: Randy Dunlap <randy.dunlap@oracle.com>

Thanks.

-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
