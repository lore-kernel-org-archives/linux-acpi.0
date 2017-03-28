From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI : Update platform device numa node based on _PXM method
Date: Wed, 29 Mar 2017 00:15:09 +0200
Message-ID: <13204058.j7zPSh58G6@aspire.rjw.lan>
References: <1490108070-24061-1-git-send-email-shankerd@codeaurora.org> <1932728.uFK6bUjlgv@aspire.rjw.lan> <6b298342-2746-f6d5-0b0e-67c20fd4c002@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:45301 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752323AbdC1WVC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Mar 2017 18:21:02 -0400
In-Reply-To: <6b298342-2746-f6d5-0b0e-67c20fd4c002@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: shankerd@codeaurora.org
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Vikram Sethi <vikrams@codeaurora.org>

On Tuesday, March 28, 2017 05:14:13 PM Shanker Donthineni wrote:
> Hi Rafael,
> 
> 
> On 03/28/2017 04:43 PM, Rafael J. Wysocki wrote:
> > On Tuesday, March 21, 2017 09:54:30 AM Shanker Donthineni wrote:
> >> The optional _PXM method evaluates to an integer that identifies the
> >> proximity domain of a device object. This patch implements support for
> >> ACPI _PXM method and updates the platform device numa node id using
> >> acpi_get_node(), which provides the PXM to NUMA mapping information.
> >>
> >> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
> > What exactly is the motivation here?
> 
> We have a couple of platform devices some of them are attached
> to socket0 and others to a different socket. We would like to covert
> memory allocations in Qualcomm platform device drivers to a NUMA
> aware allocation to improve performance.

All of the above information should be there in the patch changelog and
presumably the patch should be a part of a larger series so the way this
feature is going to be used is more clear.

Thanks,
Rafael

