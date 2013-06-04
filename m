From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/1] ACPI: ghes: Remove redundant platform_set_drvdata()
Date: Tue, 04 Jun 2013 13:10:41 +0200
Message-ID: <1557779.lOKEfHNnMB@vostro.rjw.lan>
References: <1369827977-29975-1-git-send-email-sachin.kamat@linaro.org> <20130604031828.GA20448@gchen.bj.intel.com> <CAK9yfHwU-Xfy_K9cLXRX-cRssANZZ040DSe86O=JL9_riUvs-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:57813 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751674Ab3FDLBm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 4 Jun 2013 07:01:42 -0400
In-Reply-To: <CAK9yfHwU-Xfy_K9cLXRX-cRssANZZ040DSe86O=JL9_riUvs-w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, Huang Ying <ying.huang@intel.com>, gong.chen@linux.intel.com

On Tuesday, June 04, 2013 09:04:07 AM Sachin Kamat wrote:
> On 4 June 2013 08:48, Chen Gong <gong.chen@linux.intel.com> wrote:
> > On Wed, May 29, 2013 at 05:16:17PM +0530, Sachin Kamat wrote:
> >> Date: Wed, 29 May 2013 17:16:17 +0530
> >> From: Sachin Kamat <sachin.kamat@linaro.org>
> >> To: linux-acpi@vger.kernel.org
> >> Cc: rjw@sisk.pl, lenb@kernel.org, sachin.kamat@linaro.org, Huang Ying
> >>  <ying.huang@intel.com>
> >> Subject: [PATCH 1/1] ACPI: ghes: Remove redundant platform_set_drvdata()
> >> X-Mailer: git-send-email 1.7.9.5
> >>
> >> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
> >> driver is bound) removes the need to set driver data field to
> >> NULL.
> >>
> > Your description doesn't give any meaningful explanation.
> 
> It just means that setting driver data to NULL is not necessary.

I've queued up the patch for 3.11.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
