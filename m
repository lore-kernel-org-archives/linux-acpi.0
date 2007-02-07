From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/4] Create sony-laptop
Date: Wed, 7 Feb 2007 15:50:35 -0500
Message-ID: <200702071550.35808.lenb@kernel.org>
References: <11708749163025-git-send-email-malattia@linux.it> <11708749161009-git-send-email-malattia@linux.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57538 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161109AbXBGUwB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Feb 2007 15:52:01 -0500
In-Reply-To: <11708749161009-git-send-email-malattia@linux.it>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: malattia@linux.it, "Morton, Andrew" <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org

Thanks for the follow-up Mattia, 

I've added this patch series to the acpi-test tree,
and added Lindent patch on top of it.  I'll double check
that it has all the patches from -mm and NAK those
when I do, so andrew doesn't get messed up.

However, some things need to be addressed
before it can go upstream:

What happens to sonypi?
Where is the patch to update MAINTAINERS for sony-laptop?
Documentation/acpi/sony_acpi.txt needs a revision, and a re-name,
and the Kconfig help text needs a revision too.

Finally, I don't have a Sony laptop so I can't test this.
I'd like to see successful test feedback from Andrew,
Luming, and other Sony owners before we push it.

thanks,
-Len

ps. I recommend that at some point you globally replace "sony_acpi"
in the driver with just "sony".


On Wednesday 07 February 2007 14:01, malattia@linux.it wrote:
> From: Mattia Dongili <malattia@linux.it>
> 
> 
> Move drivers/acpi/sony_acpi.c to drivers/misc/sony-laptop.c with all the
> necessary configuration.
> The SONY_LAPTOP config option substitutes the old ACPI_SONY and is 'default n'
> now.
> 
> Signed-off-by: Mattia Dongili <malattia@linux.it>
> ---
>  drivers/acpi/Kconfig       |   15 --
>  drivers/acpi/Makefile      |    1 -
>  drivers/acpi/sony_acpi.c   |  504 --------------------------------------------
>  drivers/misc/Kconfig       |   14 ++
>  drivers/misc/Makefile      |    1 +
>  drivers/misc/sony-laptop.c |  504 ++++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 519 insertions(+), 520 deletions(-)
>
