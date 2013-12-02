From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: No power management on Bay Trail tablet (Dell Venue 8 Pro)
Date: Mon, 02 Dec 2013 14:18:31 +0100
Message-ID: <529C88A7.3090103@intel.com>
References: <1385848593.2566.35.camel@adam.happyassassin.net> <20131202131822.GK2281@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:25530 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751515Ab3LBNSf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 2 Dec 2013 08:18:35 -0500
In-Reply-To: <20131202131822.GK2281@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Adam Williamson <awilliam@redhat.com>
Cc: linux-acpi@vger.kernel.org, "Zhang, Rui" <rui.zhang@intel.com>

+Rui

On 12/2/2013 2:18 PM, Mika Westerberg wrote:
> +Rafael
>
> On Sat, Nov 30, 2013 at 01:56:33PM -0800, Adam Williamson wrote:
>> Hi, folks. I recently bought a Dell Venue 8 Pro -
>> a Bay Trail / Valley View-based Intel tablet - to try and get Fedora
>> running on it. Among the many things I'm currently fighting :), there
>> doesn't appear to be any power management going on at all. 'upower -d'
>> is pretty much empty, doesn't acknowledge the existence of a battery.
> It looks like there is an I2C operation region that the AML code uses to
> handle the battery specific things:
>
>      Scope (_SB.I2C1)
>      {
>          Name (UMPC, ResourceTemplate ()
>          {
>              I2cSerialBus (0x0048, ControllerInitiated, 0x000186A0,
>                  AddressingMode7Bit, "\\_SB.I2C1",
>                  0x00, ResourceConsumer, ,
>                  )
>          })
>          Name (AVBL, Zero)
>          Method (_REG, 2, NotSerialized)  // _REG: Region Availability
>          {
>              If (LEqual (Arg0, 0x09))
>              {
>                  Store (Arg1, AVBL)
>              }
>          }
>
>          OperationRegion (DVUM, GenericSerialBus, Zero, 0x0100)
> 	...
>
> Unfortunately this is not supported in Linux yet.

