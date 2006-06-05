From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: back to discussion of VIA quirk fixup
Date: Mon, 5 Jun 2006 10:41:06 -0600
Message-ID: <200606051041.06738.bjorn.helgaas@hp.com>
References: <1148433146.2885.41.camel@localhost.portugal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel7.hp.com ([156.153.255.213]:659 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1750742AbWFEQlN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jun 2006 12:41:13 -0400
In-Reply-To: <1148433146.2885.41.camel@localhost.portugal>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: sergio@sergiomb.no-ip.org
Cc: linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

On Tuesday 23 May 2006 19:12, Sergio Monteiro Basto wrote:
> 1=C2=BA This quirk_via_irq function has been created originally by Bj=
orn
> Helgaas, so maybe he can tell better what patch does.

I didn't really create the function, I merely renamed it and
tweaked it a bit based on some bug reports.  And I've never been
able to match up this quirk with any VIA chipset documentation,
so I vowed never to get involved with it again :-)

Bjorn

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
