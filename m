From: "Carlos Corbacho" <carlos@strangeworlds.co.uk>
Subject: Re: suspend order - again
Date: Thu, 27 Mar 2008 17:36:32 -0000 (UTC)
Message-ID: <48099.194.201.210.214.1206639392.squirrel@phoenix.slamd64.com>
References: <1205482960.23855.4.camel@sli10-desk.sh.intel.com>
    <200803271143.28972.lenb@kernel.org> <200803271742.17714.rjw@sisk.pl>
    <200803271306.57184.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:34875 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755283AbYC0RhJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Mar 2008 13:37:09 -0400
In-Reply-To: <200803271306.57184.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Shaohua Li <shaohua.li@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

> Unfortunately logic doesn't rule here -- compatibility
> with the installed base is the only thing that matters.
>
> Of course when we've got examples and counter-examples,
> it can be quite a puzzle figuring out what
> hoops that installed base is asking us to jump through:-)

As one of the 'installed base', I say keep the 1.0 order for .25, because
it fixes a real regression that has been around for three releases.

We currently have more examples of nVidia boards that were broken by the
2.0 ordering, than we have concrete examples of boards broken by the 1.0
ordering (3 to 1).

We had the 1.0 ordering before, and we have a DMI quirk for the one system
shown so far to actually be broken with the 1.0 ordering, and, IIUC, we
also have the infrastructure now to be able to test either order on
systems to gather more information. If we find more systems that break
with the 1.0 ordering than 2.0, then yes, we can review this decision in
.26.

IMHO, we need more concrete data to decide which way we default to (i.e.
are nVidia boards just an abberation here, or is this
1.0-ordering-required problem more wide spread? We may be lucky, and we
only need to switch to the 1.0 order if we detect an nVidia chipset, or
start blacklisting the bad boards/ BIOS's, since I suspect Windows has
some sort of nVidia chipset blacklist as well, although I don't know how
fine grained).

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
