From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] x86: make sure wakeup code is below 1M -v2
Date: Thu, 12 Nov 2009 20:32:46 +0100
Message-ID: <200911122032.46872.rjw@sisk.pl>
References: <4AF7D820.5040503@kernel.org> <4AFA210B.3020207@kernel.org> <20091112073616.GA11365@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43482 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754312AbZKLTbm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Nov 2009 14:31:42 -0500
In-Reply-To: <20091112073616.GA11365@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Yinghai Lu <yinghai@kernel.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Thursday 12 November 2009, Pavel Machek wrote:
> On Tue 2009-11-10 18:27:23, Yinghai Lu wrote:
> > 
> > try to find_e820_area/reserve_early, and call acpi_reserve_memory early
> > 
> > to get area is below 1M
> 
> Does it fix anything? I can't tell from the changelog...

Yes, it does.  If the area is above 1M, we can't run real mode code from it.

This matters for NUMA machines supporting S3 (yes, there are a few models
out there).

Thanks,
Rafael
