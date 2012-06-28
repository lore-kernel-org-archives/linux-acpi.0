From: Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: [PATCH 5/8] don't print message if request_resource() failed
Date: Thu, 28 Jun 2012 10:46:20 +0800
Message-ID: <4FEBC57C.20302@cn.fujitsu.com>
References: <4FE97DD5.6030205@cn.fujitsu.com> <4FE97F13.3000804@cn.fujitsu.com> <alpine.DEB.2.00.1206262122160.24245@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:61813 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932252Ab2F1Cl5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Jun 2012 22:41:57 -0400
In-Reply-To: <alpine.DEB.2.00.1206262122160.24245@chino.kir.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Rientjes <rientjes@google.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yasuaki ISIMATU <isimatu.yasuaki@jp.fujitsu.com>

At 06/27/2012 12:23 PM, David Rientjes Wrote:
> On Tue, 26 Jun 2012, Wen Congyang wrote:
> 
>> If register_memory_resource() fails, the caller(add_memory()) will
>> return -EEXIST, and add_memory() returns -EEXIST only when
>> register_memory_resource() fails. The function acpi_memory_enable_device()
>> doesn't treat such erro as a fetal error, and don't want this message.
>> The function that calls add_memory() has printed message if add_memory()
>> failed, so don't print message in register_memory_resource().
>>
> 
> That may be true for acpi_memory_enable_device(), but have you checked 
> other callers to add_memory()?
> 

There are four functions that call add_memory():
1. acpi_memory_enable_device()
2. memory_probe_store()
   This caller is the callback of system call write. The user can get the return
   value by errno.
3. add_memory_merged()
   This caller does not check the return value. I guess add_memory() always
   successes in this place.
4. bp_state reserve_additional_memory()
   This caller prints message if add_memory() failed.

So I think we can remove this message...

Thanks
Wen Congyang
