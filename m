From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Date: Mon, 24 Apr 2006 22:20:06 +0200
Message-ID: <20060424202006.GD3386@elf.ucw.cz>
References: <20060419195356.GA24122@srcf.ucam.org> <20060419200447.GA2459@isilmar.linta.de> <20060419202421.GA24318@srcf.ucam.org> <d120d5000604240745i71bd56b8n99b97130388d36f6@mail.gmail.com> <1145894731.7155.120.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:37770 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751224AbWDXUUu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Apr 2006 16:20:50 -0400
Content-Disposition: inline
In-Reply-To: <1145894731.7155.120.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Purdie <rpurdie@rpsys.net>
Cc: dtor_core@ameritech.net, Matthew Garrett <mjg59@srcf.ucam.org>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi!

> Whilst sort of on the subject (AC power switches and AC power events)
> I'd like to see some standard way of exporting power/battery information
> to userspace. Currently, the ARM handhelds use kernel emulation of an
> APM bios and export the battery info as part of that. Making ARM emulate
> ACPI interfaces doesn't appeal. The answer could be a battery sysfs
> class and the above system events interface but I'm open to other
> suggestions.

Battery sysfs class would be _very_ welcome. Both existing interfaces
(APM and ACPI) are crap :-(.
								Pavel
-- 
Thanks for all the (sleeping) penguins.
