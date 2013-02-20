From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v4 1/4] acpi: move x86/mm/srat.c to
 x86/kernel/acpi/srat.c
Date: Tue, 19 Feb 2013 23:00:08 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1302192254440.27407@chino.kir.corp.google.com>
References: <1360894992-14818-1-git-send-email-lig.fnst@cn.fujitsu.com> <1360894992-14818-2-git-send-email-lig.fnst@cn.fujitsu.com> <alpine.DEB.2.02.1302191320410.6322@chino.kir.corp.google.com> <1361324355.7859.35.camel@liguang.fnst.cn.fujitsu.com>
 <1361325113.7859.37.camel@liguang.fnst.cn.fujitsu.com> <alpine.DEB.2.02.1302191802490.14999@chino.kir.corp.google.com> <1361326913.7859.41.camel@liguang.fnst.cn.fujitsu.com> <1361327201.7859.44.camel@liguang.fnst.cn.fujitsu.com>
 <alpine.DEB.2.02.1302191902470.18957@chino.kir.corp.google.com> <1361330196.7859.51.camel@liguang.fnst.cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:40219 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756453Ab3BTHAL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Feb 2013 02:00:11 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so3399976dak.33
        for <linux-acpi@vger.kernel.org>; Tue, 19 Feb 2013 23:00:10 -0800 (PST)
In-Reply-To: <1361330196.7859.51.camel@liguang.fnst.cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: li guang <lig.fnst@cn.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, isimatu.yasuaki@jp.fujitsu.com

On Wed, 20 Feb 2013, li guang wrote:

> Yes, I know there's no new changes in my patch as I said before(not
> based on lasted), but as I try to apply my patch(1/4), it will do
> the right work to move current srat.c from arch/x86/mm/ to
> arch/x86/kernel/acpi/ regardless of what I based is not latest.
> 

Sorry, but that makes no sense.  Your patch cannot be used cleanly if 
there have been subsequent changes to a hunk prior to applying it -- in 
this case the hunk would be the entire file since you're removing it.

These patches would also be pushed by the x86 maintainers, who are not 
cc'd on this patch, and I think it would be unfair to ask them to make up 
for your inability to generate a bleeding edge patch with linux-next.  The 
changes already cited in this thread have been in linux-next for almost 
two weeks, yet you refuse to rebase on top of them.
