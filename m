From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 2/4] xen/lowlevel: Implement pvop call for load_idt
 (sidt).
Date: Thu, 18 Oct 2012 10:45:41 -0400
Message-ID: <20121018144538.GA19782@localhost.localdomain>
References: <1350481786-4969-1-git-send-email-konrad.wilk@oracle.com>
 <1350481786-4969-3-git-send-email-konrad.wilk@oracle.com>
 <507F4475.80705@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:23818 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756615Ab2JROqB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Oct 2012 10:46:01 -0400
Content-Disposition: inline
In-Reply-To: <507F4475.80705@zytor.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com, lenb@kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org

On Wed, Oct 17, 2012 at 04:51:17PM -0700, H. Peter Anvin wrote:
> On 10/17/2012 06:49 AM, Konrad Rzeszutek Wilk wrote:
> >In the past it used to point to 'sidt' (native_store_idt) operation
> >which is a non-privileged operation. This resulted in the
> >'struct desc_ptr' value containing the address of Xen's IDT table,
> >instead of the IDT table that Linux thinks its using. The end result
> >is that doing:
> >
> >   store_idt(&desc);
> >   load_idt(&desc);
> >
> >would blow up b/c xen_load_idt would try to parse the IDT contents
> >(desc) and de-reference a virtual address that is outside Linux's
> >__va (it is in Xen's virtual address).
> >
> >With this patch we are providing the last written IDT address.
> >
> 
> OK... this seems like another excellent set of pvops calls that
> should be nukable to Kingdom Come.  There is no reason, ever, to
> read the IDT and GDT from the kernel... the kernel already knows
> what they should be!

Even during suspend and resume cycle? There are the sequence of
sidt/lidt calls being done there. And we do need to filter at
least the sidt call - and in the case of ACPI suspend path,
the lidt.
> 
> 	-hpa
> 
> 
> -- 
> H. Peter Anvin, Intel Open Source Technology Center
> I work for Intel.  I don't speak on their behalf.
> 
