From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH v2] acpi: Fix regression where _PPC is not read at boot
	even when ignore_ppc=0
Date: Thu, 30 Apr 2009 13:10:42 +0200
Message-ID: <20090430111042.GA12809@elte.hu>
References: <20090416002712.GX8311@plum> <200904161201.13409.trenn@suse.de> <20090416174217.GY8311@plum> <20090416224507.GA31984@srcf.ucam.org> <20090428193303.GC6968@plum> <20090428195348.GA8376@srcf.ucam.org> <20090429213930.GE6968@plum> <20090429220037.GA8604@srcf.ucam.org> <20090430072556.GD16737@elte.hu> <20090430095414.GA19462@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:58878 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335AbZD3LKy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Apr 2009 07:10:54 -0400
Content-Disposition: inline
In-Reply-To: <20090430095414.GA19462@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>, Thomas Renninger <trenn@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, cpufreq@vger.kernel.org, linux-acpi@vger.kernel.org


* Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> On Thu, Apr 30, 2009 at 09:25:56AM +0200, Ingo Molnar wrote:
> 
> > OTOH, if you rely on me figuring out which patch to revert and what 
> > to do, it will take an indeterminate amount of time - together with 
> > all the other items in my 'would be nice to hack on, given a bit of 
> > free time' queue :)
> 
> Here's Darrick's patch:

thanks - i've applied this and started testing it. I suspect 1-2 
days of test-time should be enough to see if it breaks this box in 
any way.

	Ingo
