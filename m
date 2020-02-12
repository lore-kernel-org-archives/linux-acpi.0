Return-Path: <SRS0=mEda=4A=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EEDC2BA83
	for <linux-acpi@archiver.kernel.org>; Wed, 12 Feb 2020 13:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BBA42082F
	for <linux-acpi@archiver.kernel.org>; Wed, 12 Feb 2020 13:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgBLNzz (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 12 Feb 2020 08:55:55 -0500
Received: from foss.arm.com ([217.140.110.172]:33178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgBLNzz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Feb 2020 08:55:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F3AD328;
        Wed, 12 Feb 2020 05:55:54 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9994E3F6CF;
        Wed, 12 Feb 2020 05:55:53 -0800 (PST)
Date:   Wed, 12 Feb 2020 13:55:51 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "liuqi (BA)" <liuqi115@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: About PPTT find_acpi_cpu_topology_package()
Message-ID: <20200212135551.GB36981@bogus>
References: <7a888a84-d4c5-2b49-05f3-29876d49cae6@huawei.com>
 <20200212115945.GA36981@bogus>
 <be88fdfc-50a0-9753-4f8f-d80c303892be@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be88fdfc-50a0-9753-4f8f-d80c303892be@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 12, 2020 at 12:48:33PM +0000, John Garry wrote:
> On 12/02/2020 11:59, Sudeep Holla wrote:

[...]

> > Yes, as mentioned above. We are not going to do extra work for lazy firmware.
>
> I don't think it's reasonable to just label this as lazy. The table may just
> not have the flag set unintentionally. FW and software guys make mistakes,
> like the mistakes in PPTT, itself.
>

We are not talking about flags, it's UID and it is pretty important if
there are more than one objects of same time.

> > Linux also will be lazy on such platform and provide weird unique numbers
> > like in the above case you have mentioned.
>
> Personally I think that the kernel can be do better than provide meaningless
> values like this, since it knows the processor IDs and which physical
> package they belong to.
>

This was discussed quite a lot, I can dig and point you to it. That's the
reason for choosing offset. We are *not going back* to this again. Fix the
firmware before it gets copied for all future platforms and Linux has to
deal with that *forever*.

> If not, at least make the user know of potential deficiencies in the table.
>

How ? What are your suggestions ? Does adding a warning or note that UID
is missing and offset is chosen help ? I am kind of fine with that.

--
Regards,
Sudeep
