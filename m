From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RFC] - Mapping ACPI tables as CACHED
Date: Sat, 24 Jul 2010 09:26:52 -0300
Message-ID: <20100724122652.GE7868@khazad-dum.debian.net>
References: <20100722152220.GA18290@sgi.com>
 <20100724001449.GA9618@khazad-dum.debian.net>
 <20100724004532.GA9240@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:56274 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755435Ab0GXM0z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 24 Jul 2010 08:26:55 -0400
Content-Disposition: inline
In-Reply-To: <20100724004532.GA9240@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Jack Steiner <steiner@sgi.com>, mingo@elte.hu, tglx@linutronix.de, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 24 Jul 2010, Matthew Garrett wrote:
> On Fri, Jul 23, 2010 at 09:14:50PM -0300, Henrique de Moraes Holschuh wrote:
> > Well, as it was raised in this thread, ACPI tables are likely to be near RAM
> > regions used for IPC with the firmware or SMBIOS, and we have no idea of the
> > kind of crap that could happen if we enable caching on those areas.
> > 
> > OTOH, we *know* of systems that force us to copy the ACPI tables to regular
> > RAM, otherwise, the utterly broken BIOS corrupts the ACPI tables after the
> > kernel has loaded.
> >
> > Couldn't we simply always copy all tables to regular RAM and mark THAT as
> > cacheable (since there will be no IPC regions in it)?  For the tables that
> > are only used once, we can free the RAM later.
> 
> I think this is reasonable. There's an argument that we shouldn't cache 
> operation regions that may be sitting next to the ACPI tables, but I 
> can't see any problems being caused by copying the tables to RAM.

Yes.  And well-engineered platforms that are known to be safe (such as UV)
could just opt-out of that and mark the ACPI tables directly as cachable if
they want, if the penalty for an unecessary copy-to-RAM [on these systems]
is high enough to merit it.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
