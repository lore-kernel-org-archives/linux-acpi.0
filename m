From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 5/8] don't print message if request_resource() failed
Date: Tue, 26 Jun 2012 21:23:05 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1206262122160.24245@chino.kir.corp.google.com>
References: <4FE97DD5.6030205@cn.fujitsu.com> <4FE97F13.3000804@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55799 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780Ab2F0EXH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Jun 2012 00:23:07 -0400
Received: by pbbrp8 with SMTP id rp8so989259pbb.19
        for <linux-acpi@vger.kernel.org>; Tue, 26 Jun 2012 21:23:07 -0700 (PDT)
In-Reply-To: <4FE97F13.3000804@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Wen Congyang <wency@cn.fujitsu.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yasuaki ISIMATU <isimatu.yasuaki@jp.fujitsu.com>

On Tue, 26 Jun 2012, Wen Congyang wrote:

> If register_memory_resource() fails, the caller(add_memory()) will
> return -EEXIST, and add_memory() returns -EEXIST only when
> register_memory_resource() fails. The function acpi_memory_enable_device()
> doesn't treat such erro as a fetal error, and don't want this message.
> The function that calls add_memory() has printed message if add_memory()
> failed, so don't print message in register_memory_resource().
> 

That may be true for acpi_memory_enable_device(), but have you checked 
other callers to add_memory()?
