From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: Re: [PATCH 3/6] acpi,memory-hotplug : add physical memory hotplug
 code to acpi_memhotplug.c
Date: Fri, 5 Oct 2012 14:54:01 -0400
Message-ID: <CAHGf_=rCoCs2Lu9gjydTECRydvOkXfbzFGNKJ52CW9oTiOT2Og@mail.gmail.com>
References: <506C0AE8.40702@jp.fujitsu.com> <506C0EC6.9000503@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:52867 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709Ab2JESyW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Oct 2012 14:54:22 -0400
In-Reply-To: <506C0EC6.9000503@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Cc: x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rientjes@google.com, liuj97@gmail.com, len.brown@intel.com, cl@linux.com, minchan.kim@gmail.com, akpm@linux-foundation.org, wency@cn.fujitsu.com

On Wed, Oct 3, 2012 at 6:09 AM, Yasuaki Ishimatsu
<isimatu.yasuaki@jp.fujitsu.com> wrote:
> From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
>
> For hot removing physical memory, the patch adds remove_memory() into
> acpi_memory_remove_memory(). But we cannot support physical memory
> hot remove. So remove_memory() do nothinig.

I don't understand this explanation. Why do we need do nothing change?
I guess you need to fold this patch into another meaningful fix.
