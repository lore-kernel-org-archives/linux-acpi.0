From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] acpi: remove function tracing macros
Date: Thu, 19 Jan 2006 14:36:55 +0100
Message-ID: <20060119133655.GA1558@elf.ucw.cz>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005B835E4@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29417 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161209AbWASOF7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jan 2006 09:05:59 -0500
Content-Disposition: inline
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005B835E4@hdsmsx401.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi!

> I'm sorry, I can't apply this source clean-up patch.
> 
> We need tracing to debug interpreter failures on hardware
> in the field.

Well, it seems very few people actually need that. Perhaps those
people could use separate version of instrumented interpretter?

On Linux, same can probably be done by linker magic etc. Is there
anyone needing instrumentation on *BSD?

							Pavel
-- 
Thanks, Sharp!
