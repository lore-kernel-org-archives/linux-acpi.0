From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [BUG] ACPI resource validation not working [Was: Re: ITE 8728F]
Date: Mon, 12 Dec 2011 21:12:45 +0100
Message-ID: <20111212211245.67baf2b1@endymion.delvare>
References: <CAKPcRGofYw_DcVL1QDorSp8Gr1ZL6-ur=oZnDs0w_e91ZuwKbQ@mail.gmail.com>
	<94F2FBAB4432B54E8AACC7DFDE6C92E316EE2575@ORSMSX101.amr.corp.intel.com>
	<1322531323.1467.10.camel@minggr>
	<CAKPcRGpXP=A-WHVLyvf_ZazY8br5d4-CxrDpnCbpJbcsnMVpiQ@mail.gmail.com>
	<1323396109.27764.44.camel@minggr>
	<20111212103726.56422cbb@endymion.delvare>
	<CAF1ivSaN6V5tz6ttUL9_1htFjVX8qEVv-eCq04s=_nPAaDMH6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:31730 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753998Ab1LLUNB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Dec 2011 15:13:01 -0500
In-Reply-To: <CAF1ivSaN6V5tz6ttUL9_1htFjVX8qEVv-eCq04s=_nPAaDMH6g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Luca Tettamanti <kronos.it@gmail.com>, "Moore, Robert" <robert.moore@intel.com>, Nikolay Mikov <nik.mikov@gmail.com>, Thomas <trenn@suse.de>, linux-acpi@vger.kernel.org, lenb <lenb@kernel.org>

On Mon, 12 Dec 2011 20:42:50 +0800, Lin Ming wrote:
> On Mon, Dec 12, 2011 at 5:37 PM, Jean Delvare <khali@linux-fr.org> wrote:
> > I have no objection for an upstream patch, but the main problem we have
> > at the moment is with already released kernels. Versions 2.6.39, 3.0
> > and 3.1 currently have a regression as the ACPI resource conflict
> > checks are inefficient, and this allows conflicting drivers to be
> > loaded together. So you are free to reimplement things differently in
> > version 3.2 and later, but for these 3 older versions we need the
> > smallest possible patch, so that it is accepted in stable branches.
> >
> > In other words, I would like two patches, one just adding back the code
> > that was accidentally dropped, and a second one moving things around if
> > you think it makes sense (and I tend to agree.) That way we can easily
> > backport only the first patch to kernel versions 2.6.39 to 3.1.
> 
> Sure.
> 
> I have send out the patch.
> 
> [PATCH] ACPICA: Put back the call to acpi_os_validate_address
> http://marc.info/?l=linux-acpi&m=132257617527119&w=2

Perfect, thank you!

-- 
Jean Delvare
