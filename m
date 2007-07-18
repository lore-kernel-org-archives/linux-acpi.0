From: Richard Hughes <hughsient@gmail.com>
Subject: Re: [PATCH 5/7] Make the driver use MSC_SCAN and a setkeycode and
	getkeycode key table.
Date: Wed, 18 Jul 2007 17:44:19 +0100
Message-ID: <1184777059.2496.10.camel@work>
References: <11845208794064-git-send-email-malattia@linux.it>
	 <11845208791511-git-send-email-malattia@linux.it>
	 <20070715211128.GA6291@srcf.ucam.org> <1184605565.2228.57.camel@work>
	 <20070716180928.GA21211@srcf.ucam.org> <1184668653.2443.2.camel@work>
	 <20070718114518.GB21658@inferi.kami.home>
	 <20070718142800.GA20607@srcf.ucam.org>
	 <d120d5000707180805u31099be0i2d827b10228d2608@mail.gmail.com>
	 <1184771822.14062.2.camel@work>  <20070718162510.GA22975@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.239]:46135 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759776AbXGRQsc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jul 2007 12:48:32 -0400
Received: by qb-out-0506.google.com with SMTP id e11so594564qbe
        for <linux-acpi@vger.kernel.org>; Wed, 18 Jul 2007 09:48:30 -0700 (PDT)
In-Reply-To: <20070718162510.GA22975@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mattia Dongili <malattia@linux.it>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, Richard Hughes <richard@hughsie.com>

On Wed, 2007-07-18 at 17:25 +0100, Matthew Garrett wrote:
> This isn't an either/or situation. If you have a hal keymap then the 
> system will still work. The question is what to do in the absence of 
> hal. The kernel can either provide sane defaults (that might be wrong
> in a couple of cases) or it can provide keys that are pretty much 
> guaranteed to do nothing. I think doing our best to make things work 
> even if hal isn't there is sensible - if hal /is/ there, we've lost 
> nothing. 

The only reason we set the keys to KEY_UNKNOWN is so we still emit acpi
events (and not change the interface) if we are using an old HAL to not
break stuff like acpid and tpd.

We could just do:

* emit acpi event _and_ input event if we probably know the button
* just emit input events (for known keys) and just don't emit any acpi
events at all

Richard.


