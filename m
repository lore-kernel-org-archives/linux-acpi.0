From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: Re-add ibft tree to linux-next please
Date: Tue, 17 Jan 2012 11:49:20 -0500
Message-ID: <20120117164920.GA5111@phenom.dumpdata.com>
References: <20111212145330.GA16278@andromeda.dapyr.net>
 <4EE68D57.7030603@zytor.com>
 <20111213021536.GC2730@konrad-lan>
 <4F1580DE.1060002@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:50701 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754841Ab2AQQw1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2012 11:52:27 -0500
Content-Disposition: inline
In-Reply-To: <4F1580DE.1060002@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Konrad Rzeszutek Wilk <konrad@darnok.org>, "H. Peter Anvin" <hpa@zytor.com>, Konrad Rzeszutek Wilk <konrad@kernel.org>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, sfr@canb.auug.org.au, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, pjones@redhat.com

On Tue, Jan 17, 2012 at 09:08:30AM -0500, Len Brown wrote:
> 
> > The trick is that we also have to retain the code functionality if
> > "# CONFIG_ACPI is not set" to scan the memory for the iBFT. That part
> > should definitly _not_ be moved to drivers/acpi. It could be moved to
> > arch/x86/ .. but it could also stay in drivers/firmware. <shrugs>
> 
> 
> Are there really hardware/firmware configurations that support IBFT
> and do not support ACPI?

gPXE can be used in legacy environments. And it (gPXE) does not update
the ACPI tables.

> 
> If yes, do they require an OS that has CONFIG_ACPI=n?

I can't think of anybody nowadays doing CONFIG_ACPI=n for x86.
Is there anybody doing it?


> Or would finding the table with CONFIG_ACPI=y and acpi_disabled=1
> be sufficient?

I think that would work. And also if 'acpi_disabled=0' as you might
have an IBFT table in memory that is _not_ hooked up to the ACPI tables.
