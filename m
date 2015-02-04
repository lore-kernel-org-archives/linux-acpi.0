From: Al Stone <al.stone@linaro.org>
Subject: Re: [PATCH v8 21/21] arm64: ACPI: additions of ACPI documentation
 for arm64
Date: Wed, 04 Feb 2015 12:06:14 -0700
Message-ID: <54D26DA6.9000700@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org> <1422881149-8177-22-git-send-email-hanjun.guo@linaro.org> <54D16A74.3030206@linaro.org> <20150204181229.GB21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:52669 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932207AbbBDTGS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Feb 2015 14:06:18 -0500
Received: by mail-ie0-f172.google.com with SMTP id at20so4477707iec.3
        for <linux-acpi@vger.kernel.org>; Wed, 04 Feb 2015 11:06:17 -0800 (PST)
In-Reply-To: <20150204181229.GB21293@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles.Garcia-Tobin@arm.com, phoenix.liyi@huawei.com, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com

On 02/04/2015 11:12 AM, Mark Brown wrote:
> On Tue, Feb 03, 2015 at 05:40:20PM -0700, Al Stone wrote:
>> Much removed to cut down the size on this and to highlight a couple of
>> specific sections pertinent to the ACPI on ARMv8 TODO List.....
> 
> This is of course good practice when replying to anything!

Yup :).

>>> +_DSD	6.2.5		To be used with caution.  If this object is used, try +
>>> to use it within the constraints already defined by the +			Device
>>> Properties UUID.  Only in rare circumstances +			should it be necessary
>>> to create a new _DSD UUID. + +			In either case, submit the _DSD
>>> definition along with +			any driver patches for discussion, especially
>>> when +			device properties are used.  A driver will not be +
>>> considered complete without a corresponding _DSD +			description.  Once
>>> approved by kernel maintainers, +			the UUID or device properties must
>>> then be registered +			with the UEFI Forum; this may cause some
>>> iteration as +			more than one OS will be registering entries.
> 
>> [snip...]
> 
>> So, this is my attempt to encapsulate what I think people want to have
>> happen around the use of _DSD; I just want to make sure I point it out so
>> it doesn't inadvertently get lost somehow.
> 
>> Is this far too little?  Is it sufficient?  If it only addresses part of
>> the concerns, what did I miss?
> 
> This does take us back to the issue of how exactly one is supposed to 
> register/approve _DSD bindings and what format they're written in which I
> don't think we ever fully got to the bottom of it (there's some stuff on
> the UEFI website but it's definitely looking a bit placeholderish).

Right; the UEFI stuff is indeed place-holder-ish.  This is one of the places
where Linux is really driving what happens in the spec, so it's a little bit
of a chicken-and-egg problem.  I will go repair the UEFI data once I have
a better understanding of what's needed.

I guess what I'm trying to figure out is: how specific does this need to be?
Does it need to be a step-by-step description, something like
Documentation/bindings/submitting-patches.txt, or something far more detailed
than that, with templates to fill out, and circles and arrows and a paragraph
on the back explaining each one [0] :)?


[0] http://en.wikipedia.org/wiki/Alice%27s_Restaurant

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone@linaro.org
-----------------------------------
