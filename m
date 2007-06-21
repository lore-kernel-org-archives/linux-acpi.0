From: Luca <kronos.it@gmail.com>
Subject: Re: [lm-sensors] [RFC] ACPI based hwmon driver for ASUS
Date: Thu, 21 Jun 2007 21:33:02 +0200
Message-ID: <68676e00706211233l7fa22ef6m891e61b831de2f02@mail.gmail.com>
References: <20070513223329.GA29207@dreamland.darkstar.lan>
	 <46520F36.4080006@assembler.cz>
	 <68676e00705211453n69de6868lc5da2cad64f65699@mail.gmail.com>
	 <46528B6F.3050701@assembler.cz>
	 <20070602222829.GA11893@dreamland.darkstar.lan>
	 <467AC84A.303@assembler.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:27358 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935AbXFUTdE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Jun 2007 15:33:04 -0400
Received: by nz-out-0506.google.com with SMTP id n1so710238nzf
        for <linux-acpi@vger.kernel.org>; Thu, 21 Jun 2007 12:33:03 -0700 (PDT)
In-Reply-To: <467AC84A.303@assembler.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rudolf Marek <r.marek@assembler.cz>
Cc: lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 6/21/07, Rudolf Marek <r.marek@assembler.cz> wrote:
> > Ok, it makes sense :)
> >
> > Name (FBUF, Package (0x06)
> > {
> >     0x03,
> >     CPUF,
> >     CHAF,
> >     PWRF,
> >     CHPF,
> >     CH2F
> > })
> >
> > Clearly the first number is not the number of available readings (though
> > it matches the count in the other DSDTs I've seen); don't know what it
> > is :|
>
> Maybe study the Pro2.dll from Asus Probe II?

Done that ;-) Disassembling is quite painful though, and most of the
work is performed by a kernel driver which I find a bit difficult to
decode.

Will fix the other issues and resend.

Luca
