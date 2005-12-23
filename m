From: Karol Kozimor <sziwan@hell.org.pl>
Subject: Re: [PATCH] Work around asus_acpi driver oopses on Samsung P30s and the like due to the ACPI implicit return
Date: Fri, 23 Dec 2005 13:19:23 +0100
Message-ID: <20051223121923.GA12918@hell.org.pl>
References: <F7DC2337C7631D4386A2DF6E8FB22B300580F140@hdsmsx401.amr.corp.intel.com> <20051222174226.GB20051@hell.org.pl> <20051223113347.GA20475@orest.greek0.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030512AbVLWMTa@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20051223113347.GA20475@orest.greek0.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Aichinger <Greek0@gmx.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Hanno B??ck <mail@hboeck.de>, Andrew Morton <akpm@osdl.org>, acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>
List-Id: linux-acpi@vger.kernel.org

Thus wrote Christian Aichinger:
> > Here it goes. Rediffed, also plugs a leak my previous patch introduced. I
> > believe it addresses Linus' comments. It's still not a proper fix (see
> > below), but I believe it's better than none.
> > Best regards,
> This will break other hardware as the P30/P35 as well, since there
> are some buggy DSDT's out there that return an ACPI_TYPE_BUFFER.

I've never seen one, I'd like to look at those if you've got them. Are you
sure it's the actual machine code that returns buffers, and not an implicit
return of the interpreter?

> That's the whole reason why I was testing exactly for
> ACPI_TYPE_INTEGER in my patch.

I don't really seem to follow: my logic checks for ACPI_TYPE_STRING, and if
not found, looks at DSDT signatures. If something different than a string
is returned by INIT _and_ the machine isn't a P30/P35 (DSDT sigs) then the
defaults are set as in every other case a machine is not recognized by the
driver.

> My first version was pretty simmilar to yours, until I was told on
> acpi-devel that this breaks someone elses hardware (causing it to be
> considered as P30/P35, while it isn't). I can dig up the mails if
> you want.

The original driver behaviour was: ( if INIT returns NULL && DSDT sigs
match ) machine is a P30. My patch changes that to ( if INIT returns
!ACPI_TYPE_STRING && DSDT sigs match ) machine is a P30. I'd like to see
those reports please.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
