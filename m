From: David Rientjes <rientjes@google.com>
Subject: Re: [Patch v5 0/7] acpi,memory-hotplug: implement framework for hot
 removing memory
Date: Thu, 15 Nov 2012 14:51:52 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211151450040.27188@chino.kir.corp.google.com>
References: <1352962777-24407-1-git-send-email-wency@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:63997 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752Ab2KOWvz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Nov 2012 17:51:55 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so1411767pad.19
        for <linux-acpi@vger.kernel.org>; Thu, 15 Nov 2012 14:51:54 -0800 (PST)
In-Reply-To: <1352962777-24407-1-git-send-email-wency@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Wen Congyang <wency@cn.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@linux-foundation.org>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, Jiang Liu <jiang.liu@huawei.com>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Minchan Kim <minchan.kim@gmail.com>, Mel Gorman <mgorman@suse.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Toshi Kani <toshi.kani@hp.com>

On Thu, 15 Nov 2012, Wen Congyang wrote:

> Note:
> 1. The following commit in pm tree can be dropped now(The other two patches
>    are already dropped):
>    54c4c7db6cb94d7d1217df6d7fca6847c61744ab
> 2. This patchset requires the following patch(It is in pm tree now)
>    https://lkml.org/lkml/2012/11/1/225
> 

So this is based on the acpi-general branch of 
git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git correct?

And the branch's HEAD commit 54c4c7db6cb9 ("ACPI / memory-hotplug: call 
acpi_bus_trim() to remove memory device") can be reverted before this 
series is applied?
