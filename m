From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v4 1/4] acpi: move x86/mm/srat.c to
 x86/kernel/acpi/srat.c
Date: Tue, 19 Feb 2013 18:08:02 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1302191802490.14999@chino.kir.corp.google.com>
References: <1360894992-14818-1-git-send-email-lig.fnst@cn.fujitsu.com> <1360894992-14818-2-git-send-email-lig.fnst@cn.fujitsu.com> <alpine.DEB.2.02.1302191320410.6322@chino.kir.corp.google.com> <1361324355.7859.35.camel@liguang.fnst.cn.fujitsu.com>
 <1361325113.7859.37.camel@liguang.fnst.cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:50154 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934450Ab3BTCIF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Feb 2013 21:08:05 -0500
Received: by mail-pb0-f49.google.com with SMTP id xa12so2594264pbc.36
        for <linux-acpi@vger.kernel.org>; Tue, 19 Feb 2013 18:08:04 -0800 (PST)
In-Reply-To: <1361325113.7859.37.camel@liguang.fnst.cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: li guang <lig.fnst@cn.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, isimatu.yasuaki@jp.fujitsu.com

On Wed, 20 Feb 2013, li guang wrote:

> > > This doesn't apply to Linus' tree nor does it apply to linux-next.  Which 
> > > tree are you basing this on?
> > 
> > I did based on linux-next, 
> > but it seems without commit 479a99a8e510c8839e0d3d3de8391f8bc61b9760
> > which you may want to see.
> > let me see why it missed.
> 
> I pulled latest for linux-next
> and can apply my patches smoothly.
> 

No, it doesn't.  From next-20130219, you're missing at least two patches:

3795e4893203 ("acpi, memory-hotplug: extend movablemem_map ranges to the end of node")
9a561f4dfd70 ("acpi, memory-hotplug: support getting hotplug info from SRAT")

I'm trying to be patient in reviewing your patches, but please double 
check your work.
