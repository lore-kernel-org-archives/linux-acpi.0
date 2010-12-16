From: Huang Ying <ying.huang@intel.com>
Subject: RE: [RFC] ACPI, APEI, Generic Hardware Error Source POLL/IRQ/NMI
 notification type support
Date: Thu, 16 Dec 2010 08:45:06 +0800
Message-ID: <1292460306.12648.1207.camel@yhuang-dev>
References: <1292391242.12648.1202.camel@yhuang-dev>
	 <987664A83D2D224EAE907B061CE93D530193C9D504@orsmsx505.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:12058 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751728Ab0LPApL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Dec 2010 19:45:11 -0500
In-Reply-To: <987664A83D2D224EAE907B061CE93D530193C9D504@orsmsx505.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, 2010-12-16 at 00:40 +0800, Luck, Tony wrote:
> >Because the memory area used to transfer hardware error information
> >from BIOS to Linux can be determined only in NMI, IRQ or timer
> >handler, but general ioremap can not be used in atomic context, so a
> >special version of atomic ioremap is implemented for that.
> >
> >Known issue:
> >
> >- Error information can not be printed for recoverable errors notified
> >  via NMI, because printk is not NMI-safe. Will fix this via delay
> >  printing to IRQ context via irq_work or make printk NMI-safe.
> 
> Would it be possible to defer the "ioremap" to a work queue too? Then
> we wouldn't need the special versions of ioremap.

For recoverable error, we can defer the "ioremap" to a work queue,
because most recoverable action can take place only there in fact. But
for fatal error, I think it is too late to be processed in a work queue,
we need go panic as soon as possible to prevent data corruption.

Best Regards,
Huang Ying


