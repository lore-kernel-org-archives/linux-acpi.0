From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] - Mapping ACPI tables as CACHED
Date: Tue, 14 Dec 2010 17:18:31 -0800
Message-ID: <4D081767.3050104@zytor.com>
References: <20101214220932.GA1206@sgi.com> <alpine.LFD.2.00.1012141903210.25387@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:34903 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932344Ab0LOBSk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Dec 2010 20:18:40 -0500
In-Reply-To: <alpine.LFD.2.00.1012141903210.25387@x980>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Jack Steiner <steiner@sgi.com>, hmh@hmh.eng.br, tony.luck@gmail.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, gbeshers@sgi.com

On 12/14/2010 04:04 PM, Len Brown wrote:
> hmm, my arrandale laptop fails to get into graphics mode w/ this patch 
> applied -- last thing i see is the kernel freeing memory, then black 
> screen.
> 
> thanks,
> Len Brown, Intel Open Source Technology Center
> 

Where are the ACPI tables mapped from?  I'd like to get a feel for what
the memory map looks like vs. the e820 data.

	-hpa

