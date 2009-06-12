From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH] wmi: Fix kernel panic when stack protection enabled.
Date: Fri, 12 Jun 2009 06:44:18 +0100
Message-ID: <200906120644.19252.carlos@strangeworlds.co.uk>
References: <alpine.DEB.2.00.0906091707380.8360@debian> <200906092046.24983.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:58654 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbZFLFpc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Jun 2009 01:45:32 -0400
In-Reply-To: <200906092046.24983.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "lcostantino@gmail.com" <lcostantino@gmail.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Tuesday 09 Jun 2009 20:46:24 Carlos Corbacho wrote:
> [Adding Len to CC]
>
> On Tuesday 09 Jun 2009 22:09:23 lcostantino@gmail.com wrote:
> > From: Costantino Leandro <lcostantino@gmail.com>
> >
> > Summary:
> > Kernel panic arise when stack protection is enabled, since strncat will
> > add a null terminating byte '\0'; So in functions
> > like this one (wmi_query_block):
> >         char wc[4]="WC";
> > 	....
> > 	strncat(method, block->object_id, 2);
> >         ...
> > the length of wc should be n+1 (wc[5]) or stack protection
> > fault will arise. This is not noticeable when stack protection is
> > disabled,but , isn't good either.
> > Config used: [CONFIG_CC_STACKPROTECTOR_ALL=y,
> > 	      CONFIG_CC_STACKPROTECTOR=y]
> >
> > Panic Trace
> > ------------
> >        .... stack-protector: kernel stack corrupted in : fa7b182c
> >        2.6.30-rc8-obelisco-generic
> >        call_trace:
> >            [<c04a6c40>] ? panic+0x45/0xd9
> > 	   [<c012925d>] ? __stack_chk_fail+0x1c/0x40
> > 	   [<fa7b182c>] ? wmi_query_block+0x15a/0x162 [wmi]
> > 	   [<fa7b182c>] ? wmi_query_block+0x15a/0x162 [wmi]
> > 	   [<fa7e7000>] ? acer_wmi_init+0x00/0x61a [acer_wmi]
> > 	   [<fa7e7135>] ? acer_wmi_init+0x135/0x61a [acer_wmi]
> > 	   [<c0101159>] ? do_one_initcall+0x50+0x126
> >
> > Signed-off-by: Costantino Leandro <lcostantino@gmail.com>
>
> Acked-by: Carlos Corbacho <carlos@strangeworlds.co.uk>

Cc: stable@kernel.org

Since I'm starting to get quite a few bug reports from people about 2.6.30 
when distributions are turning on stack protector.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
