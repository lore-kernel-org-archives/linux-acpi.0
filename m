From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 0/3] ACPI 5 support for GPIO, SPI and I2C
Date: Thu, 22 Nov 2012 10:43:28 +0100
Message-ID: <CACRpkdZ_GT_k13wfihRp2=nSdf8bkJGt6SSQETBG7AouBzYXgg@mail.gmail.com>
References: <1353407384-26880-1-git-send-email-mika.westerberg@linux.intel.com>
	<1353435212-15325-1-git-send-email-mika.westerberg@linux.intel.com>
	<79636467.nuLQX2FqW5@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <79636467.nuLQX2FqW5@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Grant Likely <grant.likely@secretlab.ca>
Cc: w.sang@pengutronix.de, Mika Westerberg <mika.westerberg@linux.intel.com>, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, lenb@kernel.org, broonie@opensource.wolfsonmicro.com, khali@linux-fr.org, ben-linux@fluff.org, bhelgaas@google.com, mathias.nyman@linux.intel.com, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Nov 21, 2012 at 10:31 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:

> This patchset has been around for quite a while and went through a few
> iterations, so I think it's as good as it gets at this point.
>
> I wonder if the GPIO / SPI / I2C maintainers have any objections against it or
> would like the patches to be modified somehow?
>
> If not, then I'd like to take it for v3.8 into the linux-pm.git tree, because
> the patches depend on some changes already in that tree.  Hopefully, that's OK.

For GPIO I want Grant to ACK this.

He has experience with both Device Tree and GPIO, knows what ACPI and
UEFI is and is way better suited than me to give feedback on this kind of
stuff.

So from my stance it's "neutral, whatever Grant says goes".

Yours,
Linus Walleij
