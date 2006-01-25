From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [PATCH 0/2] Deliver ACPI events upon subscription and implement multiple readers for /proc/acpi/event
Date: Wed, 25 Jan 2006 00:23:01 -0500
Message-ID: <200601250023.01359.dtor_core@ameritech.net>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005D2A09E@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp107.sbc.mail.re2.yahoo.com ([68.142.229.98]:39540 "HELO
	smtp107.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750735AbWAYFXK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jan 2006 00:23:10 -0500
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005D2A09E@hdsmsx401.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Mattia Dongili <malattia@linux.it>, linux-acpi@vger.kernel.org

On Wednesday 25 January 2006 00:09, Brown, Len wrote:
> 
> >On Tuesday 24 January 2006 20:17, Brown, Len wrote:
> >> What's the problem with opening a socket to the user-space acpid --
> >> the way multiple readers work today?
> >>
> >
> >- one does not want to use current implementation of acpid?
> 
> What is better?
> 

Probably nothing at the moment. It does not mean that every program
out there must mimic "legacy" acpid to provice concurrent access
to ACPI events.

> >- one does not want to depend on having acpid running before
> >  starting snooping acpi events?
> 
> For example?

You must ensure that nothing gets to /proc/acpi/events before acpid,
otherwise it won't be able to access it screwing up your system
state.

> 
> >- because allowing multiple readers is a "right thing to do"?
> 
> This is not self-evident, can you give some examples?

"I am trying to read from /proc/acpi/events and there is nothing there"
types of questions on various mailing lists come to my mind.

> 
> The argument against, I suppose, is simply why to add code
> to the kernel when the same feature is already working
> in user-space?
> 

If you remember original code (without registering multiple in-kernel
listeners) I think it was more compact that what is in the kernel
at the moment. Also IIRC current in kernel code may start filling memory
if acpid stops reading events for some reason.

For the record I think multiple listeners are not needed since the only
possible user is input layer and I firmly believe that ACPI should report
keys/buttons using input layer natively so userspace can get uniform
notification of "Sleep" button being pressed no matter whther that button
is controlled by ACPI or it is just another key on USB keyboard.

> The other argument against is why enhance an interface when
> perhaps we should instead consider replacing it altogether...
> 
> >> Dmitry, I don't know how to apply the signed-off thing correctly here,
> 
> If Dmitry is the original author, then the proper format is to put
> 
> From: Dmitry Torokhov <dtor_core@ameritech.net>
> 
> at start of the body of the message where it can over-ride the e-mail author.
> This is documented in Documentation/SubmittingPatches.
>

I'd say it is only valid if original patch is mostly intact. If it was
heavily reworked/enhanced I think mentioning the original author in
description is fine but authorship belongs the person who reworked the
code. Just IMHO.

-- 
Dmitry
