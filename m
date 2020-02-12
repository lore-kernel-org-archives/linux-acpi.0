Return-Path: <SRS0=mEda=4A=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B77C2BA83
	for <linux-acpi@archiver.kernel.org>; Wed, 12 Feb 2020 15:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8C820661
	for <linux-acpi@archiver.kernel.org>; Wed, 12 Feb 2020 15:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgBLPc7 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 12 Feb 2020 10:32:59 -0500
Received: from foss.arm.com ([217.140.110.172]:34134 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727026AbgBLPc7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Feb 2020 10:32:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42937328;
        Wed, 12 Feb 2020 07:32:58 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4050B3F68F;
        Wed, 12 Feb 2020 07:32:57 -0800 (PST)
Date:   Wed, 12 Feb 2020 15:32:55 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "liuqi (BA)" <liuqi115@huawei.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: About PPTT find_acpi_cpu_topology_package()
Message-ID: <20200212153255.GC36981@bogus>
References: <7a888a84-d4c5-2b49-05f3-29876d49cae6@huawei.com>
 <20200212115945.GA36981@bogus>
 <be88fdfc-50a0-9753-4f8f-d80c303892be@huawei.com>
 <20200212135551.GB36981@bogus>
 <1a04ddf8-4903-2986-a94e-c070dc2c2160@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a04ddf8-4903-2986-a94e-c070dc2c2160@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 12, 2020 at 02:41:04PM +0000, John Garry wrote:
> On 12/02/2020 13:55, Sudeep Holla wrote:
> > On Wed, Feb 12, 2020 at 12:48:33PM +0000, John Garry wrote:
> > > On 12/02/2020 11:59, Sudeep Holla wrote:
> >
> > [...]
> >
>
> Hi Sudeep,
>
> > > > Yes, as mentioned above. We are not going to do extra work for lazy firmware.
> > >
> > > I don't think it's reasonable to just label this as lazy. The table may just
> > > not have the flag set unintentionally. FW and software guys make mistakes,
> > > like the mistakes in PPTT, itself.
> > >
> >
> > We are not talking about flags, it's UID and it is pretty important if
> > there are more than one objects of same time.
> >
>
> I am talking about the Processor ID valid flag, which is specifically
> related.
>

Ah OK, sorry I had forgotten the specific. I recall it now.

> > > > Linux also will be lazy on such platform and provide weird unique numbers
> > > > like in the above case you have mentioned.
> > >
> > > Personally I think that the kernel can be do better than provide meaningless
> > > values like this, since it knows the processor IDs and which physical
> > > package they belong to.
> > >
> >
> > This was discussed quite a lot, I can dig and point you to it. That's the
> > reason for choosing offset. We are *not going back* to this again. Fix the
> > firmware before it gets copied for all future platforms and Linux has to
> > deal with that *forever*.
>
> I would liked to have been made aware earlier of the oversight. Quite often
> we only find problems when someone or something complains.
>

Agreed.

> It is a strange API to provide offsets like this, and I did not realize that
> they were actually being exposed to userspace.
>

We couldn't come up with something that produces same result always and
obtained from firmware data. Yes that being in the user-space was the main
concern for not generating it in the Linux as we can't guarantee to generate
same ID for a given physical socket. Depends on the order in which we boot
them or something similar.

> >
> > > If not, at least make the user know of potential deficiencies in the table.
> > >
> >
> > How ? What are your suggestions ? Does adding a warning or note that UID
> > is missing and offset is chosen help ?
>
> I'd say so. I know now, but let's save others the potential hassle. And
> having this debate again.
>

No argument there. I agree completely.

> I am kind of fine with that.
>
> How about something like this:
>

Looks good to me. Please post the patch. I am not sure on Rafael's
preference on such lengthy warnings(does it need to be split ?)

--
Regards,
Sudeep
