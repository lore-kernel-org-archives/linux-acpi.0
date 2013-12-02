From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: No power management on Bay Trail tablet (Dell Venue 8 Pro)
Date: Mon, 2 Dec 2013 15:18:22 +0200
Message-ID: <20131202131822.GK2281@intel.com>
References: <1385848593.2566.35.camel@adam.happyassassin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:15523 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751478Ab3LBNLr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 2 Dec 2013 08:11:47 -0500
Content-Disposition: inline
In-Reply-To: <1385848593.2566.35.camel@adam.happyassassin.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adam Williamson <awilliam@redhat.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

+Rafael

On Sat, Nov 30, 2013 at 01:56:33PM -0800, Adam Williamson wrote:
> Hi, folks. I recently bought a Dell Venue 8 Pro -
> a Bay Trail / Valley View-based Intel tablet - to try and get Fedora
> running on it. Among the many things I'm currently fighting :), there
> doesn't appear to be any power management going on at all. 'upower -d'
> is pretty much empty, doesn't acknowledge the existence of a battery.

It looks like there is an I2C operation region that the AML code uses to
handle the battery specific things:

    Scope (_SB.I2C1)
    {
        Name (UMPC, ResourceTemplate ()
        {
            I2cSerialBus (0x0048, ControllerInitiated, 0x000186A0,
                AddressingMode7Bit, "\\_SB.I2C1",
                0x00, ResourceConsumer, ,
                )
        })
        Name (AVBL, Zero)
        Method (_REG, 2, NotSerialized)  // _REG: Region Availability
        {
            If (LEqual (Arg0, 0x09))
            {
                Store (Arg1, AVBL)
            }
        }

        OperationRegion (DVUM, GenericSerialBus, Zero, 0x0100)
	...

Unfortunately this is not supported in Linux yet.
