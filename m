From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH 2.6.29] fujitsu-laptop: Add BL power, LED control and
Date: Mon, 5 Jan 2009 12:26:58 +1030 (CST)
Message-ID: <200901050156.n051uwxA022848@mercury.physics.adelaide.edu.au>
References: <495FFF48.7050709@linx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:40346 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751768AbZAEB51 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Jan 2009 20:57:27 -0500
In-Reply-To: <495FFF48.7050709@linx.net> from "Tony Vroon" at Jan 04, 2009 12:14:00 AM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony@linx.net
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, nokos@gmx.net, Stephen Gildea <stepheng+linux@gildea.com>, Julian Brown <jules@panic.cs-bristol.org.uk>, linux-acpi@vger.kernel.org

Hi Tony

> Jonathan Woithe wrote:
> > I assume you're talking about the textual driver name as opposed to the
> > module name ("fujitsu-laptop").  I have no immediate thoughts regarding
> > this.  Personally I quite like the extended information the above output
> > gives since you're left in no doubt where the driver comes from.
> 
> I would recommend fujitsu_brightness & fujitsu_hotkeys.
> Short, to the point and it fits in with how pci_root in the same
> directory is named.

Yeah, they work for me.

> I can combine that patch with the removal of the use_alt framework,
> provided Peter gets back with a positive result.

Please keep the two patches separate since they really do deal with
different things.  In any case, the use_alt framework probably has to say
for a while yet (see other emails).

> I would request that the existing patch be applied to 2.6.29 as is so that
> the merge window is not missed though.

Agreed - the existing patch should go through as is and anything else from
here on should be relative to that.

Regards
  jonathan
