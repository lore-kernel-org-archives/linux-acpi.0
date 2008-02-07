From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 053/112] the generic thermal sysfs driver
Date: Thu, 07 Feb 2008 14:10:01 -0800
Message-ID: <47AB81B9.1000702@oracle.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org> <203d3d4aa482339b4816f131f713e1b8ee37f6dd.1202376824.git.len.brown@intel.com> <20080207084645.c6e67aad.randy.dunlap@oracle.com> <200802071705.02695.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rgminet01.oracle.com ([148.87.113.118]:47430 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933843AbYBGWMH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 17:12:07 -0500
In-Reply-To: <200802071705.02695.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Thomas Sujith <sujith.thomas@intel.com>

Len Brown wrote:
> Thanks for the review, Randy.
> 
> I've corrected the issues you pointed out, as well as
> run the doc through ispell and run thermal.c through Lindent.
> 
> I've left the goto labels where Lindent put them.
> If there is a Linux style consensus on that issue,
> perhaps the Linux community can enhance Lindent?

I'd say that there is concensus but no one to touch Lindent.
[Similarly for kconfig select dependency problems. :( ]

> (I'm not going to move a bunch of labels around,
>  just to have the next Lindent sweep move them back)

Lindent has several other known issues as far as Linux kernel
is concerned.  I.e., it's not a fine tool to use and not review
what it did.

> Also, regarding the kernel-doc syntax, that too
> would be a good thing for Lindent, or some other tool
> to do for us -- or at least to complain about for us:-)

So noted, added to the todo list.

Thanks.

> thanks,
> -Len
> 
> From 54c82f9ae5b2106cc79633a611367883c374ad3f Mon Sep 17 00:00:00 2001
> From: Len Brown <len.brown@intel.com>
> Date: Thu, 7 Feb 2008 16:55:08 -0500
> Subject: [PATCH] ACPI: thermal: syntax, spelling, kernel-doc
> Organization: Intel Open Source Technology Center
> 
> Reviewed-by: Randy Dunlap <randy.dunlap@oracle.com>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  Documentation/thermal/sysfs-api.txt |   23 ++++++++--------
>  drivers/thermal/Kconfig             |    4 +-
>  drivers/thermal/thermal.c           |   49 ++++++++++++++++++++---------------
>  3 files changed, 41 insertions(+), 35 deletions(-)

-- 
~Randy
