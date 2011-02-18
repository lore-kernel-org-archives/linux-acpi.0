From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/5] ACPI: Minimize X2APIC initial messages
Date: Fri, 18 Feb 2011 08:28:24 +0100
Message-ID: <20110218072824.GC11404@elte.hu>
References: <20110217185131.960038922@gulag1.americas.sgi.com>
 <20110217185132.137154887@gulag1.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:36981 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753279Ab1BRH2h (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Feb 2011 02:28:37 -0500
Content-Disposition: inline
In-Reply-To: <20110217185132.137154887@gulag1.americas.sgi.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mike Travis <travis@sgi.com>, Len Brown <lenb@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>, Yinghai Lu <yhlu.kernel@gmail.com>, linux-acpi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org


* Mike Travis <travis@sgi.com> wrote:

> Minimize X2APIC messages by printing 8 per line and dropping
> the "enabled" flag since that's assumed.  It will still print
> "disabled" if necessary.
> 
> v2: updated to apply to x86-tip
> 
> Signed-off-by: Mike Travis <travis@sgi.com>
> Reviewed-by: Jack Steiner <steiner@sgi.com>
> Reviewed-by: Robin Holt <holt@sgi.com>

If Len acks this then i can queue it up with the other patches. Or if Len wants to 
apply it to the ACPI tree directly that's fine as well.

Len, which is your preference?

Thanks,

	Ingo
