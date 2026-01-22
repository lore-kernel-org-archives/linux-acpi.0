Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA7631195C;
	Thu, 22 Jan 2026 15:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769096818; cv=none; b=pQC7Gg4dQzT9D3wIRSVpKc4YfR2fChKqkH1cgW5TCVcFBE3WG0N9AFhohfyakPQxhJZK1ylLn/I+pE7gSqa+iMokWI5oFEiMPeUZfwgosTo990sF/E8gnaLyxvfiPSpCMZ6Sejrh51tjWAwIvVUvwIwH+13oQdsEAd4m8H1YH6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769096818; c=relaxed/simple;
	bh=mVxuyLt0TB96HQ/EB90vu4TooXmK4Cmo2P3DU7KUjLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2JRUEXuOonYAf688agiDiTEeucrh3M8ianlc6oQi4aIj4G9GgChnbvhOUOlsPC/+qZ11kOaX04umUjYyUdTtGvo3hl5zb6N9YBYraWhK3mhi0RKMH8K+RujEs/GqcT4b0ekDjIx3kWfev7FcIOKeJMBV6+D1AvfekSXrsthyCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=N5x+43X2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="N5x+43X2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SKLkTrLB7PdLFEVT/YYghi2H9ApuvViYCghQaH5XAS8=; b=N5x+43X2wZAGkCe2ZLbNDLdSUs
	6FdsQWOg343ZWWJgwg+WfuTBW4wWJT2KWGe0kzV30H0S2MGl54nmTGTceMZk1hbg+N2rTnufXchTH
	wRZICIBCllg194tDzBrJsiULWs3cDUwW2ucuX9VhnSK03wWj8SG3aEReLlvzHR4KX2Lk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1viwtM-003zfJ-QE; Thu, 22 Jan 2026 16:46:40 +0100
Date: Thu, 22 Jan 2026 16:46:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Mark Brown <broonie@kernel.org>,
	Jan Aleszczyk <jaleszcz@redhat.com>,
	Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>,
	linux-acpi@vger.kernel.org,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [Proposal,Question - refresh] ACPI representation of
 DPLL/Ethernet dependencies (SyncE)
Message-ID: <11ebf2de-bbd4-4aec-befa-cf0877cfa960@lunn.ch>
References: <6e4e40b8-b3cb-4892-8d37-d450a02e4c52@redhat.com>
 <a6e64236-d164-40d1-85d3-caf7d27fc952@lunn.ch>
 <c87cecdc-8ba5-4831-889f-0d903ae7b5ca@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c87cecdc-8ba5-4831-889f-0d903ae7b5ca@redhat.com>

On Thu, Jan 22, 2026 at 12:50:50PM +0100, Ivan Vecera wrote:
> Hi Andrew,
> 
> (Adding Sakari Ailus to CC, who might have insights on modeling
>  component topologies in ACPI).
> 
> On 1/22/26 1:09 AM, Andrew Lunn wrote:
> > > * While the physical signals on these wires are indeed clocks (10MHz,
> > >    etc.), from the OS driver perspective, this is not a "Clock Resource"
> > >    issue. The NIC driver does not need to gate, rate-set, or power-manage
> > >    these clocks (which is what _CRS/ClockInput implies).
> > 
> > Is this a peculiarity of the zl3073x? No gating, no rate-set, no power
> > management?
> > 
> > I had a quick look at the Renesas 8V89307
> > 
> > https://www.renesas.com/en/document/dst/8v89307-final-data-sheet?r=177681
> > 
> > Two of the three inputs have an optional inverter. CCF has
> > clk_set_phase(), which when passed 180 would be a good model for this.
> > The inputs then have dividers which can be configured. I would
> > probably model them using CCF clk-divider.c for that. There is then a
> > mux, which clk-mux.c could model. After the DPLL there are more muxes
> > to optionally route the output through an APLL. The output block then
> > has yet more muxes and dividers.
> > 
> > All that could be described using a number of CCF parts chained
> > together in a clock tree.
> > 
> > And what about the TI LMK05028
> > 
> > https://www.ti.com/product/LMK05028
> > 
> > It also has inverters and muxes, but no dividers.
> > 
> > Analog Devices ad9546 also has lots of internal components which could
> > be described using CCF
> > 
> > https://www.analog.com/media/en/technical-documentation/data-sheets/ad9546.pdf
> 
> I agree with you that the hardware itself (ZL3073x, Renesas 8V89307,
> etc.) is complex and has internal structures (dividers, muxes) that
> technically fit the CCF model.
> 
> However, I believe the distinction lies in how the inter-device topology
> is used versus how the device is managed internally.
> 
> The kernel now uses the dedicated DPLL Subsystem (drivers/dpll) for
> SyncE and similar applications. This subsystem was created because CCF
> captures "rate and parent" well, but does not capture SyncE-specific
> aspects like lock status, holdover, priority lists, and phase-slope
> limiting.
> 
> In our architecture, the complex configuration you mentioned (dividers,
> muxes) is managed via the DPLL Netlink ABI. The control logic largely
> resides in userspace daemons (e.g., synce4l), which send Netlink
> commands to the DPLL driver to configure those internal muxes/dividers
> based on network conditions.

So you are effectively doing user space drivers? You have a library of
DPLL drivers, which gets linked to synce4l? The library can then poke
registers in the device to configure all the muxes, inverters,
dividers?

But doesn't that also require that synce4l/the library knows about
every single board? It needs to know if the board requires the input
clock to be inverted? The output clock needs to be inverted? It needs
to know about the PHY, is it producing a 50Mhz clock, or 125MHz which
some devices provide, so will need the divider to reduce it to 50MHz?
Doesn't the library also need to know the clock driving the DPLL
package? Some of these products allow you to apply dividers to that as
well, and that clock is a board property.

To me, it seems like there are a collection of board properties, and
to make this scale, those need to be in DT/ACPI, not a user space
library. 

> The NIC driver's role here is passive; it effectively operates in a
> "bypass" mode regarding these signals. The NIC does not need to call
> clk_set_rate() or clk_prepare_enable() on these pins to function. It
> simply needs to report the physical wiring linkage: "My input / output
> is wired to DPLL pin with index X."

I can understand this bit, although actually using
clk_prepare_enable() would allow for runtime power management.

But i'm thinking more about these board properties. If i model the
internals of the DPLL using CCF, CCF probably has all the needed
control interfaces. The board properties then just set these controls.
It then seems odd that i have a Linux standard description of the
internals of the DPLL using CCF, i use the CCF binding to describe the
external interconnects, but don't actually use CCF to implement these
external interconnect?

> If we use standard Clock bindings (CCF), we imply a functional
> dependency where the NIC acts as a controller/consumer that actively
> manages the clock's state. In reality, the NIC is just a conduit mapping
> a local port to a remote pin index.

If you look at MAC drivers, all they really do is
clk_prepare_enable(). Few do more than that. So i don't really see
this as being a burden.

	Andrew
