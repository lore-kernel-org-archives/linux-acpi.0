From: "Jaya Kumar" <jayakumar.acpi@gmail.com>
Subject: Re: [PATCH 2.6.17.4 1/1] ACPI,INPUT: Move atlas to input
Date: Wed, 26 Jul 2006 18:13:05 +0800
Message-ID: <756b48450607260313h7cf7168dg764d1e14d5d2ab72@mail.gmail.com>
References: <200607250909.k6P991HK011003@localhost.localdomain>
	 <d120d5000607250555w2a7ab4d2t7e046a2990105470@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:15303 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932086AbWGZKNG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Jul 2006 06:13:06 -0400
Received: by ug-out-1314.google.com with SMTP id m3so3089093ugc
        for <linux-acpi@vger.kernel.org>; Wed, 26 Jul 2006 03:13:05 -0700 (PDT)
In-Reply-To: <d120d5000607250555w2a7ab4d2t7e046a2990105470@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-acpi@vger.kernel.org, len.brown@intel.com, akpm@osdl.org, akpm@kernel.org, linux-input@atrey.karlin.mff.cuni.cz

On 7/25/06, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> Hi Jaya,
>
> On 7/25/06, jayakumar.acpi@gmail.com <jayakumar.acpi@gmail.com> wrote:
> > +static acpi_status acpi_atlas_button_handler(u32 function,
> > +                     acpi_physical_address address,
> > +                     u32 bit_width, acpi_integer *value,
> > +                     void *handler_context, void *region_context)
> > +{
> > +       acpi_status status;
>
> Let's do:
>      unsigned long addr = (unisigned long) address;

Ok. I'll take out the casting. It's not needed except for the printk.

>
> > +
> > +       if (function == ACPI_WRITE)
> > +               atlas_input_report((u8) address);
>
>      input_report_key(input_dev, KEY_F1 + (addr & 0x0f), !(addr & 0x10));

Ok. Will do.

>
> > +       else {
> > +               printk(KERN_WARNING "atlas: shrugged on unexpected function"
> > +                       ":function=%x,address=%lx,value=%x\n",
> > +                       function, (unsigned long)address, (u32)*value);
>       function, addr, (u32)*value);
>
> [hmm, shouldn't it be *((u32*)value)?]

The original looks ok to me because I just want to cast the value to a u32.

>
> ... and kill atlas_input_report. Now that the module is a pure input
> driver you can fold some functions together.

Yup, you are right. I'll clean it up.

>
> This will leak input_dev if acpi_install_address_space_handler fails.
> Please fold atlast_setup_input and atlast_acpi_button_add together
> into one function (same goes for remove).

Oops, I see that now. Will do. Thanks for the feedback.

jaya
