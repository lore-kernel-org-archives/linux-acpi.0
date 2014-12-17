From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [Linaro-acpi] [RFC] ACPI on arm64 TODO List
Date: Wed, 17 Dec 2014 18:14:07 +0000
Message-ID: <20141217181407.GA18416@red-moon>
References: <548F9668.6080900@linaro.org>
 <9355623.14GfrLxEB0@wuerfel>
 <20141216154842.GI19412@leverpostej>
 <5490D042.3060901@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:51435 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990AbaLQSOE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Dec 2014 13:14:04 -0500
Content-Disposition: inline
In-Reply-To: <5490D042.3060901@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <al.stone@linaro.org>
Cc: Mark Rutland <Mark.Rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Olof Johansson <olof@lixom.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Dec 17, 2014 at 12:37:22AM +0000, Al Stone wrote:

[...]

> > I am rather concerned about the relationship between items described
> > with _DSD and ACPI's existing device model. Describing the relationship
> > between devices and their input clocks, regulators, and so on defeats
> > much of the benefit ACPI is marketed as providing w.r.t. abstraction of
> > the underlying platform (and as Arnd mentioned above, that's not the
> > kind of platform we want to support with ACPI).
> 
> My belief is that all those things should be set up into a known good
> state by UEFI on initial boot.  If they need to change, say as the
> result of going into a deeper sleep state or something, that's what
> the ACPI power management objects are for; Linux would execute one of
> the ACPI methods already defined by the spec to control transition to
> the desired state, and that method would have within it the ability
> to change whatever clocks or regulators it deems necessary.  The
> kernel should not have to track these things.
> 
> If someone is describing all those relationships in _DSD, I agree that
> is not the kind of ARM platform I think we want to deal with.  This is
> touched on, iirc, in arm-acpi.txt, but apparently too briefly.

I would rather rule out using _DSD to describe clocks, regulators and
their relationships in ACPI, period. There are established ACPI methods to
control power for devices and processors and if we adopt ACPI those must be
used, as you say (I am not saying they are perfect, given that x86 guys
moved away from them when they could, eg CPU idle).

They can certainly be enhanced, as it is happening for idle states
description, for instance.

I understand one reason for ACPI adoption is its established way
of handling power management for processors and devices, if for
any reason people who want ACPI on ARM require _DSD to describe
clocks and regulators relationships then they have to explain to us
why they require ACPI in the first place, given that at the moment
those clocks and regulators descriptions are non-existent in ACPI
world.

Lorenzo
