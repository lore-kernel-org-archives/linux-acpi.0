From: Rakib Mullick <rakib.mullick@gmail.com>
Subject: Re: [PATCH -v2] acpi: Fix possible recursive locking in hwregs.c
Date: Mon, 7 Nov 2011 18:13:58 +0600
Message-ID: <CADZ9YHg7yKMkqwz3wjg+=jF_DBojAvUwADkXUBRXc=s0SsC1pA@mail.gmail.com>
References: <1320592697.7439.3.camel@localhost.localdomain>
	<4EB6E416.4080201@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59972 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374Ab1KGMN6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Nov 2011 07:13:58 -0500
In-Reply-To: <4EB6E416.4080201@linux.vnet.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, akpm@linux-foundation.org, ming Lin <ming.m.lin@intel.com>, len.brown@intel.com

On Mon, Nov 7, 2011 at 1:46 AM, Srivatsa S. Bhat
<srivatsa.bhat@linux.vnet.ibm.com> wrote:
> On 11/06/2011 08:48 PM, Rakib Mullick wrote:
>
> It would be a good idea to also give the lockdep warning in the changelog
> (though you triggered it in a modified kernel), since that would make
> it very clear as to what problem your patch is trying to solve.

At the time of this reply, it's been taken. So, I'll keep it on mind
for next time.

> [And please line-wrap your changelog to 80 characters at most, per line].
>
Gmail's email editor automatically puts break on a line, that's why I
didn't put any line break on changelog. While I was reading my patch
on lkml.org, I've noticed that it creates a big one line changelog,
which is a bit weird. So, will keep it under 80 line from next time.

> Code-wise, the patch looks good to me. So,
> Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
>

Thanks,
Rakib
