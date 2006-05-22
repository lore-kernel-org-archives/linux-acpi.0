From: "Jaya Kumar" <jayakumar.acpi@gmail.com>
Subject: Re: [PATCH/RFC 2.6.17-rc4 1/1] ACPI: Atlas ACPI driver v3
Date: Mon, 22 May 2006 07:10:46 -0400
Message-ID: <756b48450605220410w4623fda3p23ddc4b38e64516b@mail.gmail.com>
References: <200605220333.k4M3Xkg6020638@localhost.localdomain>
	 <20060522093301.GB25624@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.238]:6193 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750746AbWEVLKr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 May 2006 07:10:47 -0400
Received: by wr-out-0506.google.com with SMTP id 68so1751485wra
        for <linux-acpi@vger.kernel.org>; Mon, 22 May 2006 04:10:46 -0700 (PDT)
In-Reply-To: <20060522093301.GB25624@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On 5/22/06, Pavel Machek <pavel@ucw.cz> wrote:
> ACK, but I guess you should cc Dmitry (input maintainer) and possibly
> Andrew Morton to get it in... Ok, few more nits.

Will do.

>
> > +#else
> > +#define atlas_free_input(...)
> > +#define atlas_setup_input(...) 0
> > +#define atlas_input_report(...)
> > +#endif
>
> Does the driver actually do anything useful in this case?

Depends on the application I guess. If CONFIG_INPUT is disabled, then
only applications that read /proc/acpi/event will see the ASIM events.

>
> > +     }
> > +
> > +     return status ;
>
> Extra " " before ;.

Sorry. Corrected.

>
> > +static struct acpi_driver atlas_acpi_driver = {
> > +     .name = ACPI_ATLAS_NAME,
> > +     .class = ACPI_ATLAS_CLASS,
> > +     .ids = ACPI_ATLAS_BUTTON_HID,
> > +     .ops = {
> > +             .add = atlas_acpi_button_add,
> > +             .remove = atlas_acpi_button_remove,
> > +             },
>
> Extra tab before }.

I hope I understood you correctly, the } on .ops after .remove should
align with the . ops right?. I tried to conform with button.c and
others. I will make the change I think you are suggesting anyway since
it seems more natural.

 74 static struct acpi_driver acpi_button_driver = {
 75         .name = ACPI_BUTTON_DRIVER_NAME,
 76         .class = ACPI_BUTTON_CLASS,
 77         .ids = "ACPI_FPB,ACPI_FSB,PNP0C0D,PNP0C0C,PNP0C0E",
 78         .ops = {
 79                 .add = acpi_button_add,
 80                 .remove = acpi_button_remove,
 81                 },
 82 };

 71 static struct acpi_driver acpi_video_bus = {
 72         .name = ACPI_VIDEO_DRIVER_NAME,
 73         .class = ACPI_VIDEO_CLASS,
 74         .ops = {
 75                 .add = acpi_video_bus_add,
 76                 .remove = acpi_video_bus_remove,
 77                 .match = acpi_video_bus_match,
 78                 },
 79 };

>
> > +MODULE_SUPPORTED_DEVICE("Atlas ACPI");
>
> Are you sure this si good idea?

You are right. It's a bad idea, none of the other drivers do it. I'll
take it out.

Thanks,
jayakumar
