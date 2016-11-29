From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 1/1] ACPI: Document _OSI and _REV for Linux BIOS writers
Date: Tue, 29 Nov 2016 19:27:14 +0100
Message-ID: <20161129182714.GA4848@wunner.de>
References: <d122d41c1cc7230ae5283caf2a4c18fd4d0cd93e.1479792558.git.len.brown@intel.com>
 <20161122100258.GA1552@wunner.de>
 <CAJvTdK=P6BHoDgtuF1co7iT-f23Edm7C00aZT3QF=tgQ3fM3ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:43743 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932508AbcK2SZj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Nov 2016 13:25:39 -0500
Content-Disposition: inline
In-Reply-To: <CAJvTdK=P6BHoDgtuF1co7iT-f23Edm7C00aZT3QF=tgQ3fM3ng@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Tue, Nov 29, 2016 at 01:07:55PM -0500, Len Brown wrote:
> On Tue, Nov 22, 2016 at 5:02 AM, Lukas Wunner <lukas@wunner.de> wrote:
> > On Tue, Nov 22, 2016 at 12:29:46AM -0500, Len Brown wrote:
> >> +On a platform tasked with running multiple versions of Windows,
> >> +the BIOS could use _OS to enable/disable devices that and OS
> >                                                            ^
> >                                                            delete
> 
> Here I was trying to describe that the BIOS may enable or disable
> devices and quirks based on the OS.  Yes, there are examples
> of disabling in addition to enabling -- as sometimes there is a device
> that may appear as different specific flavors of device based on the OS.
> Are you  pointing out that I should use the word "or" instead of a '/'?

I meant s/and/an/, so "devices that an OS", it looked like a typo to me.
Sorry for not making this clear enough.


> Great feedback!
> Yes, I did a somewhat superficial job on the Darwin section.
> I'll re-write it, incorporating your feedback, and send out an updated patch.

Great, thanks!

Lukas
