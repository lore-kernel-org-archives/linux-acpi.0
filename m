From: Adam M Belay <abelay@MIT.EDU>
Subject: Re: [PATCH] PNPACPI: Enable Power Support
Date: Mon, 08 Dec 2008 22:25:48 -0500
Message-ID: <20081208222548.hfac8otubupwkc84@webmail.mit.edu>
References: <493D8A1F.2090907@gmx.net>
	<20081208214910.6l58csoke98gw48w@webmail.mit.edu>
	<200812082000.05472.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from SOUTH-STATION-ANNEX.MIT.EDU ([18.72.1.2]:41416 "EHLO
	south-station-annex.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750768AbYLIDdp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Dec 2008 22:33:45 -0500
In-Reply-To: <200812082000.05472.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Witold Szczeponik <Witold.Szczeponik@gmx.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@sisk.pl

Quoting Bjorn Helgaas <bjorn.helgaas@hp.com>:
> Hi Adam,
>
> Do you have any proposals for how pnpacpi_set_resources() should
> handle failure?  Witold started out with code to call acpi_bus_set_power()
> only if the device is power-manageable, and he then passed the
> return code up.  I suggested letting acpi_bus_set_power() do
> the "is-power-manageable" check.  But then the caller would have
> to distinguish the "device isn't power-manageable" error from
> others, which is kind of ugly.
>
> Bjorn

Hi Bjorn,

How about one of these options:

1.) Modify acpi_bus_set_power() to return success if the device is not power
manageable but the request is for D0.  After all, any device that doesn't
support PM can be assumed to be in D0. (Or maybe more correctly the state
of its parent?)

2.) Call acpi_bus_get_power() and check if the state is not already D0 before
asking acpi_bus_set_power() for the transition.  If it is any other 
state, then
of the device is power manageable.

Thanks,
Adam

