From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] ACPI: Support for platform initiated graceful shutdown
Date: Wed, 22 Jun 2016 01:50:33 +0200
Message-ID: <1690297.d25mR60BpH@vostro.rjw.lan>
References: <1463430112-8843-1-git-send-email-pprakash@codeaurora.org> <58e509ba-383d-1f9c-9595-d225e8af32a8@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:51030 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750890AbcFUXra (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Jun 2016 19:47:30 -0400
In-Reply-To: <58e509ba-383d-1f9c-9595-d225e8af32a8@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Prakash, Prashanth" <pprakash@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, harba@codeaurora.org, ahs3@redhat.com, cov@codeaurora.org

On Wednesday, June 15, 2016 02:05:05 PM Prakash, Prashanth wrote:
> Hi Rafael,
> 
> Any inputs on this patch?

Does it actually work?

It looks like sybus_evaluate_ost() schedules itself with a delay in an
endless loop and the poweroff will happen anyway without waiting.

I guess the idea is that acpi_sybus_notify() will schedule a delayed work
doing the sybus_evaluate_ost() and that will do the orderly_poweroff() thing,
but that's not what the patch is doing.

That "sybus" naming looks sort of lame BTW.  What's wrong with using "sb"
instead?

Besides actypes.h is an ACPICA file and patches updating it have to go via
upstream ACPICA.

And one more thing, if you checked acpi_get_handle() for "\\_SB" once,
it will succeed every time going forward.  No need to check again.

Thanks,
Rafael

