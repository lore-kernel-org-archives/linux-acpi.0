From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2] kaslr: get ACPI SRAT table to avoid movable memory
Date: Mon, 4 Sep 2017 16:39:14 +0800
Message-ID: <20170904083914.GD30906@x1>
References: <20170903143123.22031-1-fanc.fnst@cn.fujitsu.com>
 <2895411.GR6mzpbNLk@aspire.rjw.lan>
 <20170904022619.GB30906@x1>
 <4f2f9d6e-8d6e-e518-bcb6-493d898b7341@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50632 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750839AbdIDIjZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 4 Sep 2017 04:39:25 -0400
Content-Disposition: inline
In-Reply-To: <4f2f9d6e-8d6e-e518-bcb6-493d898b7341@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, keescook@chromium.org, arnd@arndb.de, dyoung@redhat.com, dave.jiang@intel.com, lv.zheng@intel.com, indou.takao@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, yasu.isimatu@gmail.com

On 09/04/17 at 04:17pm, Dou Liyang wrote:
> With "movable_node=1024M" option in cmdline, KASLR will can't access
> the node3 memory.

So you have extended the movable_node option from no value specified to
adding a limit value, then why don't you go one step further to extend
it as movable_node=xxx@start. With this, you can eat the cake you have.

My personal opinion, could that other peopel have better idea. But dig
into acpi tables to grab the srat table, that is really not a good idea.

Chao has spent time to know the srat table, maybe he can try to make a
patch with the "movable_node=xxx@start" handling in kaslr.c, let's see
what it looks like.

Thanks
Baoquan

> 
> I am looking for the solution of this. Not find a good way.
> 
> Sometimes, I will remember that proverb:
> 
>   You cannot have your cake and eat it too. :-)
> 
> Thanks,
> 	dou.
> > touch ACPI tables with so many lines of code.
> > 
> > Thanks
> > Baoquan
> > 
> > 
> > 
> 
> 
