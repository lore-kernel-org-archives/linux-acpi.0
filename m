From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/3] Preparation for arranging hotplug memory in ZONE_MOVABLE.
Date: Tue, 20 Aug 2013 01:40:16 +0200
Message-ID: <15319045.yHqauUVrf3@vostro.rjw.lan>
References: <1376473028-29380-1-git-send-email-tangchen@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:50415 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751165Ab3HSX3p (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 Aug 2013 19:29:45 -0400
In-Reply-To: <1376473028-29380-1-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tang Chen <tangchen@cn.fujitsu.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, akpm@linux-foundation.org, liwanp@linux.vnet.ibm.com, tj@kernel.org, zhangyanfei@cn.fujitsu.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, August 14, 2013 05:37:05 PM Tang Chen wrote:
> These three trivial patches are from patch-set "Arrange hotpluggable memory as ZONE_MOVABLE."
> And they have been acked and reviewed by many people.
> 
> Hope they can be merged first. And the rest patches are coming soon.
> 
> 
> Tang Chen (3):
>   acpi: Print Hot-Pluggable Field in SRAT.
>   earlycpio.c: Fix the confusing comment of find_cpio_data().
>   acpi: Kill macro INVALID_TABLE().
> 
>  arch/x86/mm/srat.c |   11 +++++++----
>  drivers/acpi/osl.c |   36 ++++++++++++++++++++----------------
>  lib/earlycpio.c    |   27 ++++++++++++++-------------
>  3 files changed, 41 insertions(+), 33 deletions(-)

I've queued up this series for 3.12.

Thanks,
Rafael

