From: Andi Kleen <ak@suse.de>
Subject: Re: [ACPI] acpi problem with nforce motherboards and ethernet
Date: Sat, 7 Feb 2004 03:50:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040207035018.33ce01dc.ak@suse.de>
References: <402298C7.5050405@wanadoo.es>
	<40229D2C.20701@blue-labs.org>
	<4022B55B.1090309@wanadoo.es>
	<20040205154059.6649dd74.akpm@osdl.org>
	<Pine.LNX.4.55.0402070021210.12260@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55.0402070021210.12260@jurand.ds.pg.gda.pl>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: akpm@osdl.org, ktech@wanadoo.es, david+challenge-response@blue-labs.org, acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, a.verweij@student.tudelft.nl
List-Id: linux-acpi@vger.kernel.org

On Sat, 7 Feb 2004 00:33:04 +0100 (CET)
"Maciej W. Rozycki" <macro@ds2.pg.gda.pl> wrote:


>  That's not the right fix.  There's a bug in Linux's ACPI IRQ setup as
> I've discovered by comparing the code to the spec.  Here's a patch I sent
> in December both to the LKML and the ACPI maintainer.  The feedback from
> the list was positive, but the maintainer didn't bother to comment.

Thanks. I added the patch to the x86-64 sources and it indeed seems to fix
the Nforce3.

-Andi
