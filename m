From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] - Mapping ACPI tables as CACHED
Date: Wed, 15 Dec 2010 14:18:43 -0800
Message-ID: <4D093EC3.7000308@zytor.com>
References: <20101214220932.GA1206@sgi.com> <alpine.LFD.2.00.1012141903210.25387@x980> <20101215024136.GB19601@sgi.com> <alpine.LFD.2.00.1012142302110.4878@x980> <20101215164635.GA27373@sgi.com> <alpine.LFD.2.00.1012151536510.21167@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:54940 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752155Ab0LOWSy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Dec 2010 17:18:54 -0500
In-Reply-To: <alpine.LFD.2.00.1012151536510.21167@x980>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Jack Steiner <steiner@sgi.com>, hmh@hmh.eng.br, tony.luck@gmail.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, gbeshers@sgi.com

On 12/15/2010 01:16 PM, Len Brown wrote:
> 
> I'll bet we can improve the boot sequence so that
> some of the stuff we do before we have cached mappings
> we can do with cached mappings...
> We checksum all the tables, enumerate the CPUs and the APICs
> all using non-cached mappings....
> 

I don't think we have any reason to use uncached mappings, ever...

	-hpa
