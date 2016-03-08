From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2-UPDATE2 3/4] resource: Add device-managed insert/remove_resource()
Date: Tue, 8 Mar 2016 15:31:09 -0800
Message-ID: <CA+55aFxJqjvsSz7eeobViGShoJV=FSx9gDbxK_L0WvSnh3xa3w@mail.gmail.com>
References: <1457460530-17959-1-git-send-email-toshi.kani@hpe.com>
	<CA+55aFy=V-esUXZa2AogS685k+r9PyyNStkZrrUUkWSKvLFUGQ@mail.gmail.com>
	<CAPcyv4gT1RvnEquYXVo7sZscdUrkiWpG-Yvr_EX4=L25397X0g@mail.gmail.com>
	<CA+55aFxPn3J68MsqQd7OVv7jetZjPduP53MFmw2f_-z7=ebpXQ@mail.gmail.com>
	<CAPcyv4i2GwujqK=MDJpSKhvufJprmCV4vmQRpS_UP-n1kau+mg@mail.gmail.com>
	<1457481844.15454.510.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ig0-f194.google.com ([209.85.213.194]:36852 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbcCHXbK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Mar 2016 18:31:10 -0500
In-Reply-To: <1457481844.15454.510.camel@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hpe.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andrew Morton <akpm@linux-foundation.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Mar 8, 2016 at 4:04 PM, Toshi Kani <toshi.kani@hpe.com> wrote:
>
> Yes, I prefer the devm semantics.  insert_resource() and remove_resource()
> are not exported interfaces.  So, with devm_add_action(), we still need to
> introduce built-in exported wrappers for insert/remove_resource(), unless
> we change to export them directly.  Since we need to export "something", I
> think it is better to export their devm interfaces.

So I'm coming from the background that

 (a) less code is better

 (b) the "devm_" interface may be convenient, but it has also
traditionally also been a cause of problems and limitations.

Now, the main problems with the devm interface has been either
ordering (which just isn't an issue with resource allocation - it's
been an issue with irqs) or the fact that it can't always be used if
you're not in the right context. So it's "convenient but potentially
inflexible".

And the thing is, I think convenience functions mainly make sense for
places where there are multiple users. If there really is just one or
two (number completely pulled out of my ass), I don't see the point of
a "convenience" function, when we've had the main actual _code_
functionality for over a decade.

So unless there are more users, I'd suggest just exporting the
insert_resource function.

We already export allocate_resource and adjust_resource.

Now, the _one_ argument for devm_insert_resource() is that we do have
"devm_request_resource()".

But quite frankly, just counting the number of devm_request_resource()
calls weakens that argument. There's 7 callers in the whole kernel.
The regular "request_resource()" has 200+ callers.

That may be due to historical reasons, but it may also be at least
partially due to (b) above - there are a number of cases where the
"devm_xyz()" model doesn't work well.

So I think we should see the "devm_xyz()" forms as being a "let's make
things easy for driver writers". I do _not_ think it makes sense for
one-off users.

Now, if it turns out that there are lots of other potential users of
devm_insert_resource(), that would maks all of my arguments go away.

             Linus
