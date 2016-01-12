From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v2 1/2] memory-hotplug: don't BUG() in
 register_memory_resource()
Date: Tue, 12 Jan 2016 15:07:38 -0800 (PST)
Message-ID: <alpine.DEB.2.10.1601121507100.28831@chino.kir.corp.google.com>
References: <1451924251-4189-1-git-send-email-vkuznets@redhat.com> <1451924251-4189-2-git-send-email-vkuznets@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35025 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753126AbcALXHk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jan 2016 18:07:40 -0500
Received: by mail-pf0-f179.google.com with SMTP id 65so70054230pff.2
        for <linux-acpi@vger.kernel.org>; Tue, 12 Jan 2016 15:07:40 -0800 (PST)
In-Reply-To: <1451924251-4189-2-git-send-email-vkuznets@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Tang Chen <tangchen@cn.fujitsu.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Xishi Qiu <qiuxishi@huawei.com>, Sheng Yong <shengyong1@huawei.com>, Zhu Guihua <zhugh.fnst@cn.fujitsu.com>, Dan Williams <dan.j.williams@intel.com>, David Vrabel <david.vrabel@citrix.com>, Igor Mammedov <imammedo@redhat.com>

On Mon, 4 Jan 2016, Vitaly Kuznetsov wrote:

> Out of memory condition is not a bug and while we can't add new memory in
> such case crashing the system seems wrong. Propagating the return value
> from register_memory_resource() requires interface change.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Tang Chen <tangchen@cn.fujitsu.com>
> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Cc: Xishi Qiu <qiuxishi@huawei.com>
> Cc: Sheng Yong <shengyong1@huawei.com>
> Cc: Zhu Guihua <zhugh.fnst@cn.fujitsu.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Vrabel <david.vrabel@citrix.com>
> Cc: Igor Mammedov <imammedo@redhat.com>

Acked-by: David Rientjes <rientjes@google.com>
