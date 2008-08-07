From: John Keller <jpk@sgi.com>
Subject: Re: [RESEND] [PATCH] x86: Allow MMCONFIG above 4GB on x86_64
Date: Thu, 7 Aug 2008 08:39:55 -0500 (CDT)
Message-ID: <200808071339.m77DduCA517552@fcbayern.americas.sgi.com>
References: <20080731104510.GI488@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:55175 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752262AbYHGNkB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Aug 2008 09:40:01 -0400
In-Reply-To: <20080731104510.GI488@elte.hu> from "Ingo Molnar" at Jul 31, 2008 12:45:11 PM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: John Keller <jpk@sgi.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Yinghai Lu <yhlu.kernel@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

> 
> 
> * John Keller <jpk@sgi.com> wrote:
> 
> > Just checking on the status of this patch.
> > If there are no issues, please apply.
> 
> > SGI UV will have MMCFG base addresses that are greater than 4GB (32 bits).
> 
> applied to tip/x86/uv, thanks John.
> 
> 	Ingo


Thanks.

Will this patch be pushed into 2.6.27?

If not, how do I make this happen?

Thanks again,
John
