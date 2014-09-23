From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] gpio / ACPI: Use pin index and bit length
Date: Tue, 23 Sep 2014 17:52:58 +0200
Message-ID: <1443862.Jnxdc6ttcC@vostro.rjw.lan>
References: <715ed7865378d29b78003c710d50dba77b2cb9bb.1411439631.git.lv.zheng@intel.com> <6093416.FMcGNUEiEQ@vostro.rjw.lan> <20140923152917.GS1786@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61803 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751783AbaIWPdP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Sep 2014 11:33:15 -0400
In-Reply-To: <20140923152917.GS1786@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

On Tuesday, September 23, 2014 06:29:17 PM Mika Westerberg wrote:
> On Tue, Sep 23, 2014 at 05:32:02PM +0200, Rafael J. Wysocki wrote:
> > On Tuesday, September 23, 2014 01:27:28 PM Mika Westerberg wrote:
> > > On Tue, Sep 23, 2014 at 10:35:54AM +0800, Lv Zheng wrote:
> > > > From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > > 
> > > > Fix code when the operation region callback is for an gpio, which
> > > > is not at index 0 and for partial pins in a GPIO definition.
> > > > For example:
> > > > Name (GMOD, ResourceTemplate ()
> > > > {
> > > > 	//3 Outputs that define the Power mode of the device
> > > > 	GpioIo (Exclusive, PullDown, , , , "\\_SB.GPI2") {10, 11, 12}
> > > > 	})
> > > > }
> > > > 
> > > > If opregion callback calls is for:
> > > > - Set pin 10, then address = 0 and bit length = 1
> > > > - Set pin 11, then address = 1 and bit length = 1
> > > > - Set for both pin 11 and pin 12, then address = 1, bit length = 2
> > > > 
> > > > This change requires updated ACPICA gpio operation handler code to
> > > > send the pin index and bit length.
> > > > 
> > > > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > 
> > > Adding the GPIO maintainers since we need their ACK to get this merged
> > > through ACPI tree.
> > 
> > Actually, it would be good to say that the ACPICA change mentioned in the
> > changelog above is made by patch [1/2] in this series.
> > 
> > Linus, Alexandre, please let us know if you need the whole series to be
> > resent for context. This is quite urgent, as we need that fixed in 3.18,
> > because there are systems out there where it doesn't work already.
> > 
> > Mika, Srinivas, I suppose that we need this in -stable?  Which one if so?
> 
> The GPIO operation region support was introduced with commit
> 473ed7be0da04 (gpio / ACPI: Add support for ACPI GPIO operation
> regions):
> 
>  % git describe 473ed7be0da041275d57ab0bde1c21a6f23e637f
>  v3.14-rc6-61-g473ed7be0da0
> 
> So if I understand the above correctly it is needed starting from v3.14.
> Please correct me if I'm wrong.

Sounds correct.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
