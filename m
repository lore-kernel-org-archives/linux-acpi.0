From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 0/4] asus-laptop
Date: Mon, 07 May 2007 12:00:01 +0200
Message-ID: <1178532004.1231.982.camel@queen.suse.de>
References: <200705061445.03504.corentincj@iksaif.net>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:49745 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754274AbXEGKAF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 May 2007 06:00:05 -0400
In-Reply-To: <200705061445.03504.corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: corentincj@iksaif.net
Cc: linux-acpi@vger.kernel.org, Danny Kukawka <dkukawka@suse.de>

On Sun, 2007-05-06 at 14:45 +0200, Corentin CHARY wrote:
> Hi Len,
> Some asus-laptop patchs for 2.6.22 =).

I recently had a look at an ASUS and wanted to try out
the video module.
The laptop had the ACPI specific general brightness
and other video AML functions.
But also the ATKxy Asus specific device that asus_acpi
makes use of.

In AML code one could see, that the use of those was
exclusive, a variable (or method?) was used to either
return out immediately from ATKxy or general ACPI funcs
(the ones from ACPI spec. Appendix B).

On a quick try asus_acpi worked, video did not.

It looks as if asus begins to move to the spec?
Some problems might come up:
  - Interference between asus_acpi and video
  - Which model works better with what kind
    of method (there might come a break point,
    (possibly Vista?), when the ACPI spec functions
    work better than ATKxy the asus specific device
    vanishes totally at some point).

While I like the idea that vendors move on to the standard, I fear
some more very machine specific problems might hit us in future...

Just some info, if anyone finds out more, I'd be interested in
any related info...

Thanks,

   Thomas

