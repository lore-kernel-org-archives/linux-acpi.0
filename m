From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 0/2] additional sysfs entries for CPPC
Date: Mon, 17 Apr 2017 18:20:53 +0200
Message-ID: <2277460.NbhXrg4XLS@aspire.rjw.lan>
References: <1490817000-13876-1-git-send-email-pprakash@codeaurora.org> <94a244fe-27be-7615-f7f9-e5ac77af851a@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:49973 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754031AbdDQQ05 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 17 Apr 2017 12:26:57 -0400
In-Reply-To: <94a244fe-27be-7615-f7f9-e5ac77af851a@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Prakash, Prashanth" <pprakash@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, hotran@apm.com, ahs3@redhat.com, Alexey Klimov <alexey.klimov@arm.com>, George Cherian <george.cherian@cavium.com>

On Monday, April 17, 2017 09:42:15 AM Prakash, Prashanth wrote:
> Cc++
> 
> Any feedback on this?
> 
> On 3/29/2017 1:49 PM, Prashanth Prakash wrote:
> > This patch-set adds few additional sysfs entries to expose the
> > performance capabilities of each CPU. The performance capabilities
> > include highest perf, lowest perf, nominal perf and lowest
> > non-linear perf. See 8.4.7.1 for ACPI 6.1 spec for details on
> > these capabilities.
> >
> > cppc_cpufreq driver operates in KHz scale whereas the delivered
> > performance computed in userspace will be in abstract CPPC scale, so
> > exposing perf capabilities should allow userspace to figure out the
> > conversion factor from CPPC scale to KHz.
> >
> > Changes in V2:
> >  - Removed caching of perf caps based on Rafael's inputs
> >
> > Prashanth Prakash (2):
> >   ACPI / CPPC: Read lowest non linear perf in cppc_get_perf_caps
> >   ACPI / CPPC: add sysfs entries for CPPC perf capabilities
> >
> >  drivers/acpi/cppc_acpi.c | 80 ++++++++++++++++++++++++++----------------------
> >  include/acpi/cppc_acpi.h |  3 +-
> >  2 files changed, 46 insertions(+), 37 deletions(-)

I am about to get to this.

Thanks,
Rafael

