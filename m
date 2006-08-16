From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH for review] [54/145] x86_64: Remove obsolete PIC mode
Date: Wed, 16 Aug 2006 18:35:57 +0200
Message-ID: <20060816183557.f7ab6b69.ak@suse.de>
References: <20060810 935.775038000@suse.de>
	<20060810193609.2977113C0B@wotan.suse.de>
	<200608161231.49856.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:17794 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750779AbWHPQgB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Aug 2006 12:36:01 -0400
In-Reply-To: <200608161231.49856.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 16 Aug 2006 12:31:49 -0400
Len Brown <len.brown@intel.com> wrote:

> On Thursday 10 August 2006 15:36, Andi Kleen wrote:
> 
> 
> > PIC mode is an outdated way to drive the APICs that was used on 
> > some early MP boards. It is not supported in the ACPI model.
> > 
> > It is unlikely to be ever configured by any x86-64 system
> > 
> > Remove it thus.
> 
> Is there any reason we can't entirely remove MPS from x86_64?
> (asside from the routines that ACPI uses)

There are still people who like to compile with CONFIG_ACPI=n or use 
acpi=off

I wouldn't have a problem with disallowing CONFIG_ACPI=n, but acpi=off
still needs to work.

A lot of the newer systems don't have mptables anymore, but there are 
still a lot around who do.

-Andi

