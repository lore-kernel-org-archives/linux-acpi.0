From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH 0/2] additional sysfs entries for CPPC
Date: Tue, 3 Jan 2017 11:37:48 -0700
Message-ID: <b147a3c2-5435-84b2-f3ff-6fb96e764fd5@redhat.com>
References: <1481763994-28146-1-git-send-email-pprakash@codeaurora.org>
Reply-To: ahs3@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34916 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759596AbdACShv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Jan 2017 13:37:51 -0500
Received: by mail-qk0-f174.google.com with SMTP id u25so373110221qki.2
        for <linux-acpi@vger.kernel.org>; Tue, 03 Jan 2017 10:37:51 -0800 (PST)
In-Reply-To: <1481763994-28146-1-git-send-email-pprakash@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prashanth Prakash <pprakash@codeaurora.org>, linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, alexey.klimov@arm.com, hotran@apm.com, cov@codeaurora.org

On 12/14/2016 06:06 PM, Prashanth Prakash wrote:
> This patch-set adds few additional sysfs entries to expose the
> performance capabilities of each CPU. The performance capabilities
> include highest perf, lowest perf, nominal perf and lowest 
> non-linear perf. See 8.4.7.1 for ACPI 6.1 spec for details on
> these capabilities.
> 
> cppc_cpufreq driver operates in KHz scale whereas the delivered
> performance computed in userspace will be in abstract CPPC scale, so
> exposing perf capabilities should allow userspace to figure out the
> conversion factor from CPPC scale to KHz.
> 
> Prashanth Prakash (2):
>   ACPI / CPPC: read all perf caps in a single cppc read command
>   ACPI / CPPC: add sysfs entries for CPPC perf capabilities
> 
>  drivers/acpi/cppc_acpi.c | 164 ++++++++++++++++++++++++++++++-----------------
>  include/acpi/cppc_acpi.h |   3 +-
>  2 files changed, 107 insertions(+), 60 deletions(-)
> 

Nice addition, Prashanth.  I had thought about doing this, but got distracted.
Thanks for following through :).  I have not had a chance to test these yet, but
will do so as soon as I can; my initial review is pretty positive, though.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
