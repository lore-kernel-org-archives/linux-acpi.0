From: "Jaya Kumar" <jayakumar.acpi@gmail.com>
Subject: Re: [patch 2/6] ACPI: Atlas ACPI driver
Date: Sun, 2 Jul 2006 19:43:53 +0800
Message-ID: <756b48450607020443i3e2c6c16m2b3f8666b53fd5c@mail.gmail.com>
References: <CFF307C98FEABE47A452B27C06B85BB6E16BE4@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:31074 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964877AbWGBLny (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 2 Jul 2006 07:43:54 -0400
Received: by ug-out-1314.google.com with SMTP id a2so1246664ugf
        for <linux-acpi@vger.kernel.org>; Sun, 02 Jul 2006 04:43:53 -0700 (PDT)
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6E16BE4@hdsmsx411.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: akpm@osdl.org, linux-acpi@vger.kernel.org, dtor_core@ameritech.net, "Yu, Luming" <luming.yu@intel.com>

Hi Len,

On 7/1/06, Brown, Len <len.brown@intel.com> wrote:
> > +     if (function == ACPI_WRITE) {
> > +             status = acpi_bus_generate_event(dev, 0x80, address);
> > +             atlas_input_report((u8) address);
>
> What is the reasoning to simultaneously report the same event
> via both ACPI and input?

The event is reported to ACPI because there are legacy apps that read
/proc/acpi/event for this ASIM event. Newer apps can use the F1...
events that they can get via evdev. btw, if CONFIG_INPUT is disabled,
atlas_input_report gets dummied out and it's reported only to ACPI.

I can remove the acpi_bus_generate_event if that's the consensus.

Thanks,
jaya
