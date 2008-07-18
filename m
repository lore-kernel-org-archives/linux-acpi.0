From: "Ray Lee" <ray-lk@madrabbit.org>
Subject: Re: Please pull ACPI updates
Date: Fri, 18 Jul 2008 08:57:08 -0700
Message-ID: <2c0942db0807180857v54748277ja4b330537309a861@mail.gmail.com>
References: <200807161633.01375.jbarnes@virtuousgeek.org>
	 <alpine.LFD.1.10.0807170807040.2959@woody.linux-foundation.org>
	 <alpine.LFD.1.10.0807170835320.2959@woody.linux-foundation.org>
	 <487F71E8.9050705@firstfloor.org>
	 <2c0942db0807171211s39e2653fwdc50f92d9c3020d2@mail.gmail.com>
	 <487FA24B.9060803@firstfloor.org>
	 <alpine.LFD.1.10.0807171259010.2959@woody.linux-foundation.org>
	 <alpine.LFD.1.10.0807171304220.2959@woody.linux-foundation.org>
	 <alpine.LFD.1.10.0807171323320.2959@woody.linux-foundation.org>
	 <20080718132521.GA94799@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.176]:5202 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbYGRP5K (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jul 2008 11:57:10 -0400
Received: by el-out-1112.google.com with SMTP id z25so88797ele.1
        for <linux-acpi@vger.kernel.org>; Fri, 18 Jul 2008 08:57:09 -0700 (PDT)
In-Reply-To: <20080718132521.GA94799@dspnet.fr.eu.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Olivier Galibert <galibert@pobox.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, Ray Lee <ray-lk@madrabbit.org>, Jesse Barnes <jbarn>

On Fri, Jul 18, 2008 at 6:25 AM, Olivier Galibert <galibert@pobox.com> wrote:
> You say "don't rebase on the most recent kernel version".  Andi seems
> to accept that going forwards.  You say "use topic branches that are
> based on whatever kernel version you had at the time, I'll do the
> merge".  That's ok too.  His remaining question is "what do I do with
> broken patches _in_the_topic_branch_?".  He wants to
> amend/merge/split/reorder within the topic branch so that the branch
> itself is bisectable.  So what should be done there?

If the patches have problems, then make a new topic branch and redo
them there, or reorder, amend, squash, whatever inside the original
branch. The problem comes once you open that branch out for other
people to pull from, or if that branch had pulled patches from someone
else. At that point you're destroying the history that other people
are now already sharing, in a meta-data sense (changing the sha1), as
well as invalidating whatever test points that people may have had on
those commits.

In short, don't rewrite public history. If you want to share out your
works-in-progress, just let people know that those branches of yours
are volatile and not to be trusted. But you can't pull someone else's
public history, and then make it volatile; subtle trouble ensues.
