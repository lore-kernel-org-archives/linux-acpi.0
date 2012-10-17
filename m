From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/4] xen/lowlevel: Implement pvop call for load_idt (sidt).
Date: Wed, 17 Oct 2012 16:51:17 -0700
Message-ID: <507F4475.80705@zytor.com>
References: <1350481786-4969-1-git-send-email-konrad.wilk@oracle.com> <1350481786-4969-3-git-send-email-konrad.wilk@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:39395 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752708Ab2JQXvf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Oct 2012 19:51:35 -0400
In-Reply-To: <1350481786-4969-3-git-send-email-konrad.wilk@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com, lenb@kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org

On 10/17/2012 06:49 AM, Konrad Rzeszutek Wilk wrote:
> In the past it used to point to 'sidt' (native_store_idt) operation
> which is a non-privileged operation. This resulted in the
> 'struct desc_ptr' value containing the address of Xen's IDT table,
> instead of the IDT table that Linux thinks its using. The end result
> is that doing:
>
>    store_idt(&desc);
>    load_idt(&desc);
>
> would blow up b/c xen_load_idt would try to parse the IDT contents
> (desc) and de-reference a virtual address that is outside Linux's
> __va (it is in Xen's virtual address).
>
> With this patch we are providing the last written IDT address.
>

OK... this seems like another excellent set of pvops calls that should 
be nukable to Kingdom Come.  There is no reason, ever, to read the IDT 
and GDT from the kernel... the kernel already knows what they should be!

	-hpa


-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.

