From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC] - Mapping ACPI tables as CACHED
Date: Sat, 24 Jul 2010 01:45:32 +0100
Message-ID: <20100724004532.GA9240@srcf.ucam.org>
References: <20100722152220.GA18290@sgi.com> <20100724001449.GA9618@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:48803 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718Ab0GXApv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Jul 2010 20:45:51 -0400
Content-Disposition: inline
In-Reply-To: <20100724001449.GA9618@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Jack Steiner <steiner@sgi.com>, mingo@elte.hu, tglx@linutronix.de, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jul 23, 2010 at 09:14:50PM -0300, Henrique de Moraes Holschuh wrote:
> Well, as it was raised in this thread, ACPI tables are likely to be near RAM
> regions used for IPC with the firmware or SMBIOS, and we have no idea of the
> kind of crap that could happen if we enable caching on those areas.
> 
> OTOH, we *know* of systems that force us to copy the ACPI tables to regular
> RAM, otherwise, the utterly broken BIOS corrupts the ACPI tables after the
> kernel has loaded.
>
> Couldn't we simply always copy all tables to regular RAM and mark THAT as
> cacheable (since there will be no IPC regions in it)?  For the tables that
> are only used once, we can free the RAM later.

I think this is reasonable. There's an argument that we shouldn't cache 
operation regions that may be sitting next to the ACPI tables, but I 
can't see any problems being caused by copying the tables to RAM.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
