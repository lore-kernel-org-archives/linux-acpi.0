From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 8/8] ACPI / PM: Use existing ACPI iomaps for NVS
 save/restore (v2)
Date: Sat, 5 Feb 2011 10:51:10 -0800
Message-ID: <AANLkTin1gHSS1Hu_ia4RFimNeYXWGtY9XBqfRH28D1ZL@mail.gmail.com>
References: <201101201226.41021.rjw@sisk.pl> <201101250025.10817.rjw@sisk.pl>
 <201101250032.07423.rjw@sisk.pl> <AANLkTi=nAhadVy6y6f4uOy0-pvTQrdwYgQ0y_4ukui2z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45376 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752870Ab1BESwD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Feb 2011 13:52:03 -0500
In-Reply-To: <AANLkTi=nAhadVy6y6f4uOy0-pvTQrdwYgQ0y_4ukui2z@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Sat, Feb 5, 2011 at 7:31 AM, Jeff Chua <jeff.chua.linux@gmail.com> wrote:
>
> The suspend monster is back! The suspend-to-ram is fine, but upon
> resume, screen is blank. Haven't bisected in case someone has also
> done so.
>
> It's very recent. ... between commit
> 831d52bc153971b70e64eccfbed2b232394f22f8 and
> 44f2c5c841da1b1e0864d768197ab1497b5c2cc1.

Hmm. It's almost certainly one of the DRI patches, but which one? I
think bisection is the only way to figure it out. It shouldn't be too
bad, since there's only 120 commits in that range.

In fact, you can almost certainly just bisect from 89840966c579 to
bb5b583b5279, which is just 31 commits and should get you bisected in
just five tries or so.

                       Linus
