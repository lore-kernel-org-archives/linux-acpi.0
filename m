From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: add GPIO support for SMSC SCH311x
Date: Wed, 4 Dec 2013 13:33:58 +0100
Message-ID: <CACRpkdYvLj0WquLAFCp6dzVOFCgNZmY1V7Ti93XP1Sc8oAJArQ@mail.gmail.com>
References: <1385597895-26418-1-git-send-email-br1@einfach.org>
	<CACRpkdaXO+tYRq=uyQiAopRDPwKv1_F4yZwCWr4-JL1xnio4Wg@mail.gmail.com>
	<20131129203747.GL16823@kw.sim.vm.gnt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20131129203747.GL16823@kw.sim.vm.gnt>
Sender: linux-gpio-owner@vger.kernel.org
To: Simon Guinot <simon.guinot@sequanux.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "H. Peter Anvin" <hpa@linux.intel.com>, Grant Likely <grant.likely@linaro.org>
Cc: Bruno Randolf <br1@einfach.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, David Cohen <david.a.cohen@intel.com>, Wim Van Sebroeck <wim@iguana.be>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 29, 2013 at 9:37 PM, Simon Guinot <simon.guinot@sequanux.org> wrote:
> On Fri, Nov 29, 2013 at 03:40:01PM +0100, Linus Walleij wrote:
>> Maybe this leads to another interesting discussion on why
>> ACPI is not used for configuring the board...
>
> Hi Linus,
>
> I am currently working on the next Seagate NAS boards (x86-based) and
> again a Super-I/O will be used to provide some GPIO lines :) The device
> should be an IT8732, which may be supported by the driver gpio-it8761e.
>
> Based on our previous experience, I am currently pushing the board
> manufacturer (which also provides the BIOS) to get an get entry for
> the Super-I/O device in the ACPI tables.
>
> Let me say it is not a easy task and I am still not sure to succeed...
> Clearly the guys don't understand why they have to do that because the
> other OS are used to identify the device via the I/O registers.

OK so I report this to linux-acpi, HPA and Grant and hope that they
will get them for this "we like port I/O-probing" attitude... there is
only so much we can do.

Basically the (embedded?) x86 vendors need to get
their act together around ACPI just like the ARM vendors did with
device tree.

Only handwaving from my side, sorry... best I can do.

Yours,
Linus Walleij
