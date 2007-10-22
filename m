From: Frans Pop <elendil@planet.nl>
Subject: Re: latest 2.6.23 git missing ACPI POWER_SUPPLY
Date: Mon, 22 Oct 2007 16:33:41 +0200
Message-ID: <200710221633.42619.elendil@planet.nl>
References: <b6a2187b0710220045q2920c0dat9ebe4850b02d1bbf@mail.gmail.com> <E1IjvB3-0005oG-N9@faramir.fjphome.nl> <471CA0AA.4000904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hpsmtp-eml16.kpnxchange.com ([213.75.38.116]:2844 "EHLO
	hpsmtp-eml16.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752221AbXJVOdq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Oct 2007 10:33:46 -0400
In-Reply-To: <471CA0AA.4000904@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 22 October 2007, Alexey Starikovskiy wrote:
> Frans Pop wrote:
> > I must say that having these relatively top-level ACPI settings
> > depending on something that is relatively buried away is not very
> > intuitive! Especially not since at first glance you don't really seem
> > to need that option except for some weird hardware.
> >
> > CC'ing ACPI mailing list for other opinions.
>
> I was thinking that 'select' might be more appropriate here...
> Please take a look on attached patch.

Perfect! The power supply option can now no longer be unselected while 
battery or ac options are selected and will automatically get correct 
modular or compiled in status. Thanks.

Tested-by: Frans Pop <elendil@planet.nl>
