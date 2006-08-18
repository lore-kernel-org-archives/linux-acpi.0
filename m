From: Ben B <kernel@bb.cactii.net>
Subject: Re: DSDT/ASL compiler error
Date: Fri, 18 Aug 2006 14:10:48 +0200
Message-ID: <20060818121048.GA1579@cactii.net>
References: <20060817170303.GA3592@cactii.net> <1155897211.4302.1318.camel@queen.suse.de> <20060818112517.GB4945@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from us.cactii.net ([66.160.141.151]:27914 "EHLO us.cactii.net")
	by vger.kernel.org with ESMTP id S1030318AbWHRMLU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Aug 2006 08:11:20 -0400
Content-Disposition: inline
In-Reply-To: <20060818112517.GB4945@poupinou.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bruno Ducrot <ducrot@poupinou.org>
Cc: Thomas Renninger <trenn@suse.de>, linux-acpi@vger.kernel.org

Bruno Ducrot <ducrot@poupinou.org> uttered the following thing:
> On Fri, Aug 18, 2006 at 12:33:30PM +0200, Thomas Renninger wrote:
> > > 
> > > dsdt.dsl  3275:                                         And (Local1, 0xFFFF)
> > > Warning  1104 -        Result is not used, operator has no effect ^ 
> > > 
> I'm not sure if that's one is harmless:
> > > dsdt.dsl  3275:                                         And (Local1, 0xFFFF)
> It's as if the asl writter wanted to clear the upper bits of Local1, but forgot to
> assign it back to Local1.  It might be something like this:
> 	And(Local1, 0xFFFF, Local1)
> 
> It's only a rough guess though, and wihtout knowing what was the
> original intention, and without the source of the ASL, it's hard
> to tell for sure.

This is the context around there. I can send the whole asl if you'd like
also:

                                Store (C15B, Local1)
                                If (Local1)
                                {
                                    If (And (C165, 0x40))
                                    {
                                        Add (Not (Local1), 0x01, Local1)
                                        And (Local1, 0xFFFF)
                                    }
                                }

                                Store (Local1, Index (DerefOf (Index (Local0, 0x02)), 0x0E))

Of particular interest that I'd like to get going also is the built in
accelerometer, which I only discovered browsing the ASL:

            Device (ACEL)
            {
                Name (_HID, EisaId ("HPQ0004"))

"HP Mobile Data Protection Sensor"....but that's for another project. :)

Ben

