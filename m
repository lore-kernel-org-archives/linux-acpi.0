From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [patch 2/6] ACPI: Atlas ACPI driver
Date: Fri, 7 Jul 2006 11:44:18 -0400
Message-ID: <d120d5000607070844n41bdd00fkad5bd3c996b699f@mail.gmail.com>
References: <CFF307C98FEABE47A452B27C06B85BB6E16BE4@hdsmsx411.amr.corp.intel.com>
	 <756b48450607020443i3e2c6c16m2b3f8666b53fd5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:38623 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751201AbWGGPoV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Jul 2006 11:44:21 -0400
Received: by ug-out-1314.google.com with SMTP id m3so3030224ugc
        for <linux-acpi@vger.kernel.org>; Fri, 07 Jul 2006 08:44:19 -0700 (PDT)
In-Reply-To: <756b48450607020443i3e2c6c16m2b3f8666b53fd5c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jaya Kumar <jayakumar.acpi@gmail.com>
Cc: "Brown, Len" <len.brown@intel.com>, akpm@osdl.org, linux-acpi@vger.kernel.org, "Yu, Luming" <luming.yu@intel.com>

On 7/2/06, Jaya Kumar <jayakumar.acpi@gmail.com> wrote:
> Hi Len,
>
> On 7/1/06, Brown, Len <len.brown@intel.com> wrote:
> > > +     if (function == ACPI_WRITE) {
> > > +             status = acpi_bus_generate_event(dev, 0x80, address);
> > > +             atlas_input_report((u8) address);
> >
> > What is the reasoning to simultaneously report the same event
> > via both ACPI and input?
>
> The event is reported to ACPI because there are legacy apps that read
> /proc/acpi/event for this ASIM event. Newer apps can use the F1...
> events that they can get via evdev. btw, if CONFIG_INPUT is disabled,
> atlas_input_report gets dummied out and it's reported only to ACPI.
>
> I can remove the acpi_bus_generate_event if that's the consensus.
>

I think because the driver would be new for the mainline we should
remove the old way of  reporting events and rely on input layer (and
make the driver depend on CONFIG_INPUT).

Also, could you please change phys from "acpi/input0" to something
like "ASIM0000/atlas/input0" to make it more unique?

-- 
Dmitry
