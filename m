From: David Rientjes <rientjes@google.com>
Subject: Re: [Patch v5 4/7] acpi_memhotplug.c: free memory device if
 acpi_memory_enable_device() failed
Date: Thu, 15 Nov 2012 15:36:53 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211151536410.27188@chino.kir.corp.google.com>
References: <1352962777-24407-1-git-send-email-wency@cn.fujitsu.com> <1352962777-24407-5-git-send-email-wency@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:39897 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800Ab2KOXg7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Nov 2012 18:36:59 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so1433581pad.19
        for <linux-acpi@vger.kernel.org>; Thu, 15 Nov 2012 15:36:58 -0800 (PST)
In-Reply-To: <1352962777-24407-5-git-send-email-wency@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Wen Congyang <wency@cn.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@linux-foundation.org>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, Jiang Liu <jiang.liu@huawei.com>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Minchan Kim <minchan.kim@gmail.com>, Mel Gorman <mgorman@suse.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Toshi Kani <toshi.kani@hp.com>, Jiang Liu <liuj97@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Christoph Lameter <cl@linux.com>

On Thu, 15 Nov 2012, Wen Congyang wrote:

> If acpi_memory_enable_device() fails, acpi_memory_enable_device() will
> return a non-zero value, which means we fail to bind the memory device to
> this driver.  So we should free memory device before
> acpi_memory_device_add() returns.
> 
> CC: David Rientjes <rientjes@google.com>
> CC: Jiang Liu <liuj97@gmail.com>
> CC: Len Brown <len.brown@intel.com>
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: Paul Mackerras <paulus@samba.org>
> CC: Christoph Lameter <cl@linux.com>
> Cc: Minchan Kim <minchan.kim@gmail.com>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
> CC: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
> CC: Rafael J. Wysocki <rjw@sisk.pl>
> CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>

Acked-by: David Rientjes <rientjes@google.com>
