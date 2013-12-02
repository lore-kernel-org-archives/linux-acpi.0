From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: No power management on Bay Trail tablet (Dell Venue 8 Pro)
Date: Mon, 2 Dec 2013 13:41:55 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B909263011AEE30@SHSMSX101.ccr.corp.intel.com>
References: <1385848593.2566.35.camel@adam.happyassassin.net>
 <20131202131822.GK2281@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:51232 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752374Ab3LBNmA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Dec 2013 08:42:00 -0500
In-Reply-To: <20131202131822.GK2281@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Adam Williamson <awilliam@redhat.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>

Hi, Adam,

Can you please attach the acpidump output of this machine, and the dmesg output after boot?

Thanks,
rui

> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Mika Westerberg
> Sent: Monday, December 02, 2013 9:18 PM
> To: Adam Williamson
> Cc: linux-acpi@vger.kernel.org; Wysocki, Rafael J
> Subject: Re: No power management on Bay Trail tablet (Dell Venue 8 Pro)
> 
> +Rafael
> 
> On Sat, Nov 30, 2013 at 01:56:33PM -0800, Adam Williamson wrote:
> > Hi, folks. I recently bought a Dell Venue 8 Pro - a Bay Trail /
> Valley
> > View-based Intel tablet - to try and get Fedora running on it. Among
> > the many things I'm currently fighting :), there doesn't appear to be
> > any power management going on at all. 'upower -d'
> > is pretty much empty, doesn't acknowledge the existence of a battery.
> 
> It looks like there is an I2C operation region that the AML code uses
> to handle the battery specific things:
> 
>     Scope (_SB.I2C1)
>     {
>         Name (UMPC, ResourceTemplate ()
>         {
>             I2cSerialBus (0x0048, ControllerInitiated, 0x000186A0,
>                 AddressingMode7Bit, "\\_SB.I2C1",
>                 0x00, ResourceConsumer, ,
>                 )
>         })
>         Name (AVBL, Zero)
>         Method (_REG, 2, NotSerialized)  // _REG: Region Availability
>         {
>             If (LEqual (Arg0, 0x09))
>             {
>                 Store (Arg1, AVBL)
>             }
>         }
> 
>         OperationRegion (DVUM, GenericSerialBus, Zero, 0x0100)
> 	...
> 
> Unfortunately this is not supported in Linux yet.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
> in the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html
