From: Thomas Renninger <trenn@suse.de>
Subject: Re: 3.4/3.5 kernels not booting in intel 945/950 chipset
Date: Thu, 12 Jul 2012 11:29:10 +0200
Message-ID: <201207121129.10923.trenn@suse.de>
References: <CAL3-7MoQVLyKBxdfDFK5OT5nNR6Djmtm4S4OkJBhUZszxmH-GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50882 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752808Ab2GLJ3O (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Jul 2012 05:29:14 -0400
In-Reply-To: <CAL3-7MoQVLyKBxdfDFK5OT5nNR6Djmtm4S4OkJBhUZszxmH-GQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ian Malone <ibmalone@gmail.com>
Cc: linux-acpi@vger.kernel.org

Hi,

On Wednesday, July 11, 2012 06:26:24 PM Ian Malone wrote:
> Hi,
> 
> I'm using Fedora 17 and have the following bug:
> https://bugzilla.redhat.com/show_bug.cgi?id=834318 where 3.4 and 3.5
> series kernels run into a kernel panic during boot which appears to be
> related to ACPI, on a Sony VGN-C2M/W Vaio
> http://www.sony.co.uk/support/en/product/VGN-C2M_W/specifications
> (Intel 945/950 chipset, core 2 duo).
> 
> acpidump is attached to the Fedora bug:
> https://bugzilla.redhat.com/attachment.cgi?id=593488
> 
> As are screenshots of the startup messages:
> https://bugzilla.redhat.com/attachment.cgi?id=593486

This one gets fixed by:
ACPICA: Fix possible fault in return package object repair code
which was sent on this list by Lin Ming recently.

https://bugzilla.kernel.org/show_bug.cgi?id=44171

The fix hopefully still shows up in 3.5 pretty soon.
I just re-sent it with stable@ in CC, so the fix should show
up in 3.4 as well sooner or later.

      Thomas
