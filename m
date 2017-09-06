From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 1/3] mfd: Add support for Cherry Trail Dollar Cove TI PMIC
Date: Thu, 07 Sep 2017 00:19:01 +0200
Message-ID: <3358010.FqzdD3Emuf@aspire.rjw.lan>
References: <20170904144340.27693-1-tiwai@suse.de> <20170906104723.qs3b7p6p6x2ixmvb@dell> <20170906105209.uoutqilops3plna2@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:56208 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932756AbdIFW1w (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Sep 2017 18:27:52 -0400
In-Reply-To: <20170906105209.uoutqilops3plna2@dell>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Takashi Iwai <tiwai@suse.de>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Johannes Stezenbach <js@sig21.net>, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Platform Driver <platform-driver-x86@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wednesday, September 6, 2017 12:52:09 PM CEST Lee Jones wrote:
> > > In any case, I wouldn't mind it if you took the [3/3] from this series, because
> > > if there are any conflicts with it, they will be trivial to resolve.  And I
> > > don't need an immutable branch with it or anything like that.
> > 
> > No problem.
> 
> Although you don't appear to have reviewed it?

I have reviewed it, although I haven't sent a tag.

Generally speaking, for drivers/acpi/pmic/ Reviewed-bys from Mika and Andy are
sufficient (they likely are more familiar with the code in there than I am),
but please feel free to add an ACK from me to it too. :-)

