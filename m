From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 1/3] mfd: Add support for Cherry Trail Dollar Cove TI PMIC
Date: Thu, 07 Sep 2017 12:52:53 +0200
Message-ID: <2362452.XVjrAATvXK@aspire.rjw.lan>
References: <20170904144340.27693-1-tiwai@suse.de> <3358010.FqzdD3Emuf@aspire.rjw.lan> <20170907073903.rz6d3jd4c6yc75hf@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170907073903.rz6d3jd4c6yc75hf@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Andy Shevchenko <andy@infradead.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Takashi Iwai <tiwai@suse.de>, Darren Hart <dvhart@infradead.org>, Johannes Stezenbach <js@sig21.net>, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Platform Driver <platform-driver-x86@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thursday, September 7, 2017 9:39:03 AM CEST Lee Jones wrote:
> On Thu, 07 Sep 2017, Rafael J. Wysocki wrote:
> 
> > On Wednesday, September 6, 2017 12:52:09 PM CEST Lee Jones wrote:
> > > > > In any case, I wouldn't mind it if you took the [3/3] from this series, because
> > > > > if there are any conflicts with it, they will be trivial to resolve.  And I
> > > > > don't need an immutable branch with it or anything like that.
> > > > 
> > > > No problem.
> > > 
> > > Although you don't appear to have reviewed it?
> > 
> > I have reviewed it, although I haven't sent a tag.
> > 
> > Generally speaking, for drivers/acpi/pmic/ Reviewed-bys from Mika and Andy are
> > sufficient (they likely are more familiar with the code in there than I am),
> 
> I don't see them in MAINTAINERS.  I thought it was Len and yourself.

I do need help with code review at least in some areas, though.

Some of this information is missing from MAINTAINERS, but I guess that can be
addressed in this particular case.

Mika, Andy, would it be OK to add you as reviewers for drivers/acpi/pmic/
to MAINTAINERS?

Thanks,
Rafael
