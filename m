From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] gpio / ACPI: Use pin index and bit length
Date: Wed, 24 Sep 2014 15:29:58 +0200
Message-ID: <4782234.lB9SpkJVXe@vostro.rjw.lan>
References: <715ed7865378d29b78003c710d50dba77b2cb9bb.1411439631.git.lv.zheng@intel.com> <20140923102728.GK1786@lahna.fi.intel.com> <CACRpkdbdY2JFDbYWaqZ2KepKUv8fQnNAR4bH0KVjVS8zcMbFoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51979 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750828AbaIXNKL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Sep 2014 09:10:11 -0400
In-Reply-To: <CACRpkdbdY2JFDbYWaqZ2KepKUv8fQnNAR4bH0KVjVS8zcMbFoA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Alexandre Courbot <acourbot@nvidia.com>

On Wednesday, September 24, 2014 01:25:03 PM Linus Walleij wrote:
> On Tue, Sep 23, 2014 at 12:27 PM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > On Tue, Sep 23, 2014 at 10:35:54AM +0800, Lv Zheng wrote:
> >> From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> >>
> >> Fix code when the operation region callback is for an gpio, which
> >> is not at index 0 and for partial pins in a GPIO definition.
> >> For example:
> >> Name (GMOD, ResourceTemplate ()
> >> {
> >>       //3 Outputs that define the Power mode of the device
> >>       GpioIo (Exclusive, PullDown, , , , "\\_SB.GPI2") {10, 11, 12}
> >>       })
> >> }
> >>
> >> If opregion callback calls is for:
> >> - Set pin 10, then address = 0 and bit length = 1
> >> - Set pin 11, then address = 1 and bit length = 1
> >> - Set for both pin 11 and pin 12, then address = 1, bit length = 2
> >>
> >> This change requires updated ACPICA gpio operation handler code to
> >> send the pin index and bit length.
> >>
> >> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> >> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> >
> > Adding the GPIO maintainers since we need their ACK to get this merged
> > through ACPI tree.
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> When it comes to ACPI GPIO stuff I basically trust Rafael, Mika
> and Darren to do the right thing. I'm trying to learn a bit as we go.

Thanks!  We're doing our best. :-)

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
