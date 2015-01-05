From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] ACPI on arm64 TODO List
Date: Mon, 5 Jan 2015 21:52:27 +0100
Message-ID: <20150105205227.GA24657@amd>
References: <548F9668.6080900@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47276 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753811AbbAEUwb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jan 2015 15:52:31 -0500
Content-Disposition: inline
In-Reply-To: <548F9668.6080900@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <al.stone@linaro.org>
Cc: "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Olof Johansson <olof@lixom.net>, Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>, "grant.likely@linaro.org" <grant.likely@linaro.org>

Hi!

> Back in September 2014, a meeting was held at Linaro Connect where we
> discussed what issues remained before the arm64 ACPI core patches could
> be merged into the kernel, creating the TODO list below.  I should have
> published this list sooner; I got focused on trying to resolve some of
> the issues instead.
> 
> We have made some progress on all of these items.  But, I want to make
> sure we haven't missed something.  Since this list was compiled by only
> the people in the room at Connect, it is probable we have.  I, for one,
> do not yet claim omniscience.
> 
> So, I want to ask the ARM and ACPI communities:
> 
>   -- Is this list correct?
> 
>   -- Is this list complete?

I'm not sure this is how kernel development works. Expect new issues
to be raised as patches are being reviewed.

> 7. Why is ACPI required?
>    * Problem:
>      * arm64 maintainers still haven't been convinced that ACPI is
>        necessary.
>      * Why do hardware and OS vendors say ACPI is required?
>    * Status: Al & Grant collecting statements from OEMs to be posted
>      publicly early in the new year; firmware summit for broader
>      discussion planned.

This should be #1 really, right? I still hope the answer is "ACPI not
needed".

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
