From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/1] ACPI: ghes: Remove redundant platform_set_drvdata()
Date: Fri, 28 Jun 2013 12:44:14 +0200
Message-ID: <2698240.JNzF6KSaOM@vostro.rjw.lan>
References: <1369827977-29975-1-git-send-email-sachin.kamat@linaro.org> <1557779.lOKEfHNnMB@vostro.rjw.lan> <CAK9yfHxdfjxwr8jgS6YUBC0gkQ_yKwO0eBJgFK+eGaWoOPCkPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:54054 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755104Ab3F1Ker (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Jun 2013 06:34:47 -0400
In-Reply-To: <CAK9yfHxdfjxwr8jgS6YUBC0gkQ_yKwO0eBJgFK+eGaWoOPCkPQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-acpi@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>, Tony Luck <tony.luck@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>

On Friday, June 28, 2013 02:14:29 PM Sachin Kamat wrote:
> Hi Rafael,
> 
> On 4 June 2013 16:40, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Tuesday, June 04, 2013 09:04:07 AM Sachin Kamat wrote:
> >> On 4 June 2013 08:48, Chen Gong <gong.chen@linux.intel.com> wrote:
> >> > On Wed, May 29, 2013 at 05:16:17PM +0530, Sachin Kamat wrote:
> >> >> Date: Wed, 29 May 2013 17:16:17 +0530
> >> >> From: Sachin Kamat <sachin.kamat@linaro.org>
> >> >> To: linux-acpi@vger.kernel.org
> >> >> Cc: rjw@sisk.pl, lenb@kernel.org, sachin.kamat@linaro.org, Huang Ying
> >> >>  <ying.huang@intel.com>
> >> >> Subject: [PATCH 1/1] ACPI: ghes: Remove redundant platform_set_drvdata()
> >> >> X-Mailer: git-send-email 1.7.9.5
> >> >>
> >> >> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
> >> >> driver is bound) removes the need to set driver data field to
> >> >> NULL.
> >> >>
> >> > Your description doesn't give any meaningful explanation.
> >>
> >> It just means that setting driver data to NULL is not necessary.
> >
> > I've queued up the patch for 3.11.
> 
> Did not find the $subject patch in your merge queue for 3.11 [1].
> 
> Also. did not find any patches queued up in MyungJoo Ham's devfreq tree.
> 
> [1] https://lkml.org/lkml/2013/6/27/277

This particular patch has to go through the Tony Luck's RAS tree as it
modifies the APEI code.  I dropped it after we had a few patches in two trees
by mistake.

About devfreq status you need to ask MyungJoo Ham.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
