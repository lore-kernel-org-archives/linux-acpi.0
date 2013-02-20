From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v4 1/4] acpi: move x86/mm/srat.c to
 x86/kernel/acpi/srat.c
Date: Tue, 19 Feb 2013 19:04:35 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1302191902470.18957@chino.kir.corp.google.com>
References: <1360894992-14818-1-git-send-email-lig.fnst@cn.fujitsu.com> <1360894992-14818-2-git-send-email-lig.fnst@cn.fujitsu.com> <alpine.DEB.2.02.1302191320410.6322@chino.kir.corp.google.com> <1361324355.7859.35.camel@liguang.fnst.cn.fujitsu.com>
 <1361325113.7859.37.camel@liguang.fnst.cn.fujitsu.com> <alpine.DEB.2.02.1302191802490.14999@chino.kir.corp.google.com> <1361326913.7859.41.camel@liguang.fnst.cn.fujitsu.com> <1361327201.7859.44.camel@liguang.fnst.cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:53422 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935557Ab3BTDEh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Feb 2013 22:04:37 -0500
Received: by mail-pa0-f52.google.com with SMTP id fb1so3727013pad.25
        for <linux-acpi@vger.kernel.org>; Tue, 19 Feb 2013 19:04:36 -0800 (PST)
In-Reply-To: <1361327201.7859.44.camel@liguang.fnst.cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: li guang <lig.fnst@cn.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, isimatu.yasuaki@jp.fujitsu.com

On Wed, 20 Feb 2013, li guang wrote:

> > > No, it doesn't.  From next-20130219, you're missing at least two patches:
> > > 
> > > 3795e4893203 ("acpi, memory-hotplug: extend movablemem_map ranges to the end of node")
> > > 9a561f4dfd70 ("acpi, memory-hotplug: support getting hotplug info from SRAT")
> > > 
> > > I'm trying to be patient in reviewing your patches, but please double 
> > > check your work.
> > 
> > I have to say my latest pull has these commit, and can apply
> > successfully.
> > really don't know why you can't apply.

You should not be pulling linux-next, you should be fetching.
> 
> I mean although my patches did not based on latest linux-next(miss
> several commits), but as I can see, they can be applied to latest
> linux-next (tag next-20130218) successfully.
> 

next-20130218 is not the latest linux-next as I've already said.  Do this: 
go to 
http://git.kernel.org/?p=linux/kernel/git/next/linux-next-history.git;a=blob_plain;f=arch/x86/mm/srat.c;hb=HEAD 
and search for handle_movablemem().  That's one of the functions added in 
one of the commits I mentioned and was from February.  Now search your 
patch for handle_movablemem().  See a problem?
