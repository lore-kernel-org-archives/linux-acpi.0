From: Rakib Mullick <rakib.mullick@gmail.com>
Subject: Re: [PATCH -v1] acpi: Fix possible recursive locking in hwregs.c
Date: Thu, 3 Nov 2011 23:01:31 +0600
Message-ID: <CADZ9YHhvSP2UEc8+burfsiykVbJDfi5n2p9Lb0nSpV2-WD5HzA@mail.gmail.com>
References: <1320317323.5711.5.camel@localhost.localdomain>
	<1320321770.2813.10.camel@hp6530s>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60396 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934085Ab1KCRBb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Nov 2011 13:01:31 -0400
In-Reply-To: <1320321770.2813.10.camel@hp6530s>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Brown, Len" <len.brown@intel.com>, "Moore, Robert" <robert.moore@intel.com>

On 11/3/11, Lin Ming <ming.m.lin@intel.com> wrote:
> On Thu, 2011-11-03 at 18:48 +0800, Rakib Mullick wrote:
>> Calling pm-suspend might trigger a recursive lock in it's code path. In
>> function acpi_hw_clear_acpi_status,
>
> As I replied at https://lkml.org/lkml/2011/9/22/6, I still don't think
> there is a recursive lock.
>
> Or do you have a real test case to trigger the recursive lock you
> mentioned?
>
As I said before, recursive lock trigger's on a modified kernel (when
calling pm-suspend), not with the mainline kernel. If you think that,
since it's not happening with original kernel, so we shouldn't go for
fix - that's a different thing, I don't have any argue. But, the issue
is on.

Thanks,
Rakib
