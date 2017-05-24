From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] workqueue: Implement delayed_work_busy()
Date: Wed, 24 May 2017 16:21:43 -0400
Message-ID: <20170524202143.GN24798@htj.duckdns.org>
References: <1495582493-10069-1-git-send-email-alex.naidis@linux.com>
 <20170524151154.GD24798@htj.duckdns.org>
 <CACuw83r65iSCQdV1WVR=wQqw0voJ_98HmsRF9XaAdeGtQ_daGQ@mail.gmail.com>
 <20170524200141.GM24798@htj.duckdns.org>
 <CACuw83qcNAX1RNr=G6cfGeLqTKL-rtDLpK60o65BB50dLPMOzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36833 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964823AbdEXUVp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 May 2017 16:21:45 -0400
Content-Disposition: inline
In-Reply-To: <CACuw83qcNAX1RNr=G6cfGeLqTKL-rtDLpK60o65BB50dLPMOzA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Naidis <alex.naidis@linux.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Hello,

cc'ing ACPI folks.

On Wed, May 24, 2017 at 10:16:02PM +0200, Alex Naidis wrote:
> 2017-05-24 22:01 GMT+02:00 Tejun Heo <tj@kernel.org>:
> > Hello, Alex.
> >
> > On Wed, May 24, 2017 at 09:58:19PM +0200, Alex Naidis wrote:
> >> Yeah, I agree, it is wrong to rely on work_busy() providing correct data.
> >> However sometimes it is useful to have an indicator like this to at least
> >> catch some cases where requeuing work would be obsolete.
> >> This applies for delayed work too.
> >
> > Can you elaborage on "requeueing work would be obsolate" a bit?
> Sure.
> The case that I mean is represented well by the usage of work_busy here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/acpi/bus.c#n534
> It checks work_busy() before requeuing the work, since in some cases
> it is obsolete
> to requeue the work if it is already pending or running.

So, there is no point in testing whether a work item is pending before
queeing it.  It's completely spurious.  The only part which makes
sense is if it doesn't want to queue a work item if it's already
running (but note that this isn't synchronized properly) for some
reason, but given that it can race with workqueue operation and
spuriously return false when the work item just started running, it
can't be for correctness.

Rafael, Len, can you please explain why work_busy() test is there?

Thanks.

-- 
tejun
