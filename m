From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Regression in thinkpad-acpi events
Date: Thu, 24 Nov 2011 22:25:43 -0200
Message-ID: <20111125002543.GC28516@khazad-dum.debian.net>
References: <4EBAC3B5.5060405@gmail.com>
 <201111142031.06663.maciej.rutecki@gmail.com>
 <4EC16F8E.7060601@gmail.com>
 <201111142118.47256.maciej.rutecki@gmail.com>
 <CAG-2HqVnsmSyHVCvEVf+sZw5NxhR8qSDDB0AtR+igwCCFiwfgQ@mail.gmail.com>
 <20111115230305.GA23325@khazad-dum.debian.net>
 <CAG-2HqUgHAa=H6RBS2-Z3FG6OgmaWSJpdBWHn=n7Lm5O6G7ZWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:35430 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752517Ab1KYAZq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Nov 2011 19:25:46 -0500
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 3C2A620C0F
	for <linux-acpi@vger.kernel.org>; Thu, 24 Nov 2011 19:25:46 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAG-2HqUgHAa=H6RBS2-Z3FG6OgmaWSJpdBWHn=n7Lm5O6G7ZWA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tom Gundersen <teg@jklm.no>
Cc: maciej.rutecki@gmail.com, Natanji <natanji@gmail.com>, linux-acpi@vger.kernel.org, lenb@kernel.org, ibm-acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Thu, 24 Nov 2011, Tom Gundersen wrote:
> It looks like my problem was something else. We don't do anything to
> synthesize the ACPI HKEY events (AFAIK), so I believe that KDE (which
> I am using) should be using the input events and that the HKEY stuff
> does not matter.

I have no idea if KDE can do it or not.

> As to the original report about the change in HKEY events, this is
> (probably) due to PROCFS_ACPI being disabled in the Arch kernel as of
> 3.1.

Well, maybe Arch needs to update its userspace to cope with its kernel...
but still, we will only really know whether this is the problem or not if
someone checks the input devices and the acpi events over netlink in that
Arch kernel.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
