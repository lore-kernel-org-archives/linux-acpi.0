Return-Path: <SRS0=FQkT=TG=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE7AC04A6B
	for <linux-acpi@archiver.kernel.org>; Mon,  6 May 2019 12:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FFCC20830
	for <linux-acpi@archiver.kernel.org>; Mon,  6 May 2019 12:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbfEFMHz (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 6 May 2019 08:07:55 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43417 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfEFMHz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 May 2019 08:07:55 -0400
Received: from 79.184.253.223.ipv4.supernova.orange.pl (79.184.253.223) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 8f8b8ef4e30ad709; Mon, 6 May 2019 14:07:53 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Len Brown <lenb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linuxarm <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v2 1/5] ACPI/PPTT: Trivial, Modify the case of CPU
Date:   Mon, 06 May 2019 14:07:52 +0200
Message-ID: <9111298.efd3gzfPJI@kreacher>
In-Reply-To: <51abea94-15d6-e712-411e-bf7fcf2902b6@arm.com>
References: <20190426220309.55654-1-jeremy.linton@arm.com> <CAJZ5v0hNj-pWqxQkVjRrvEHswTk+qJsuj0JM8ckZWCbqzRuLGA@mail.gmail.com> <51abea94-15d6-e712-411e-bf7fcf2902b6@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
Message-ID: <20190506120752.8K3cHvKN2MTs5U_Px2rAzll9LNscSObQEHQzQ9rkETI@z>

On Wednesday, May 1, 2019 5:46:49 PM CEST Jeremy Linton wrote:
> Hi,
> 
> And sorry about the delay...
> 
> On 4/29/19 3:50 AM, Rafael J. Wysocki wrote:
> > On Sat, Apr 27, 2019 at 12:03 AM Jeremy Linton <jeremy.linton@arm.com> wrote:
> >>
> >> CPU is an acronym and customarily capitalized. Much of the
> >> commenting in the PPTT code has been using "cpu" rather
> >> than "CPU". Correct that, and other human readable strings.
> >>
> >> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> > 
> > It would be better to say "Modify the spelling of CPU" in the subject
> > IMO, but apart from that
> 
> Hmmm, spelling doesn't seem quite right either, how about "capitalization"?

That would work for me too.



