From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 2/4] mm/acpi: use NUMA_NO_NODE
Date: Fri, 30 Aug 2013 14:48:05 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1308301447540.29484@chino.kir.corp.google.com>
References: <521FF494.6000504@huawei.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:53518 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309Ab3H3VsH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Aug 2013 17:48:07 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so2365308pdj.26
        for <linux-acpi@vger.kernel.org>; Fri, 30 Aug 2013 14:48:06 -0700 (PDT)
In-Reply-To: <521FF494.6000504@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jianguo Wu <wujianguo@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Rafael J . Wysocki" <rjw@sisk.pl>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On Fri, 30 Aug 2013, Jianguo Wu wrote:

> Use more appropriate NUMA_NO_NODE instead of -1
> 
> Signed-off-by: Jianguo Wu <wujianguo@huawei.com>

Acked-by: David Rientjes <rientjes@google.com>
