From: Alex Naidis <alex.naidis@linux.com>
Subject: Re: [PATCH] workqueue: Implement delayed_work_busy()
Date: Wed, 24 May 2017 22:32:52 +0200
Message-ID: <CACuw83qxQ2_b2wOwCe1_PhLn=CR9pf4p6ckC_RWhAJs0L3eVpA@mail.gmail.com>
References: <1495582493-10069-1-git-send-email-alex.naidis@linux.com>
 <20170524151154.GD24798@htj.duckdns.org> <CACuw83r65iSCQdV1WVR=wQqw0voJ_98HmsRF9XaAdeGtQ_daGQ@mail.gmail.com>
 <20170524200141.GM24798@htj.duckdns.org> <CACuw83qcNAX1RNr=G6cfGeLqTKL-rtDLpK60o65BB50dLPMOzA@mail.gmail.com>
 <20170524202143.GN24798@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:32852 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750774AbdEXUdN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 May 2017 16:33:13 -0400
In-Reply-To: <20170524202143.GN24798@htj.duckdns.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Hello,

2017-05-24 22:21 GMT+02:00 Tejun Heo <tj@kernel.org>:
> Hello,
>
> cc'ing ACPI folks.
>
> On Wed, May 24, 2017 at 10:16:02PM +0200, Alex Naidis wrote:
>> 2017-05-24 22:01 GMT+02:00 Tejun Heo <tj@kernel.org>:
>> > Hello, Alex.
>> >
>> > On Wed, May 24, 2017 at 09:58:19PM +0200, Alex Naidis wrote:
>> >> Yeah, I agree, it is wrong to rely on work_busy() providing correct data.
>> >> However sometimes it is useful to have an indicator like this to at least
>> >> catch some cases where requeuing work would be obsolete.
>> >> This applies for delayed work too.
>> >
>> > Can you elaborage on "requeueing work would be obsolate" a bit?
>> Sure.
>> The case that I mean is represented well by the usage of work_busy here:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/acpi/bus.c#n534
>> It checks work_busy() before requeuing the work, since in some cases
>> it is obsolete
>> to requeue the work if it is already pending or running.
>
> So, there is no point in testing whether a work item is pending before
> queeing it.  It's completely spurious.  The only part which makes
> sense is if it doesn't want to queue a work item if it's already
> running (but note that this isn't synchronized properly) for some
> reason, but given that it can race with workqueue operation and
> spuriously return false when the work item just started running, it
> can't be for correctness.
>
what I thought is that might be a good idea to catch at least
some cases where the work is already running. It is obviously wrong
to rely on the corectness of the return value.

Do you agree here or would you suggest another
alternative here?

> Rafael, Len, can you please explain why work_busy() test is there?
>
> Thanks.
>
> --
> tejun

Thank you!
Alex
