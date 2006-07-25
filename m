From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2.6.17.4 1/1] ACPI,INPUT: Move atlas to input
Date: Tue, 25 Jul 2006 08:55:56 -0400
Message-ID: <d120d5000607250555w2a7ab4d2t7e046a2990105470@mail.gmail.com>
References: <200607250909.k6P991HK011003@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:12519 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751397AbWGYMz7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Jul 2006 08:55:59 -0400
Received: by ug-out-1314.google.com with SMTP id m3so2661404ugc
        for <linux-acpi@vger.kernel.org>; Tue, 25 Jul 2006 05:55:57 -0700 (PDT)
In-Reply-To: <200607250909.k6P991HK011003@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "jayakumar.acpi@gmail.com" <jayakumar.acpi@gmail.com>
Cc: linux-acpi@vger.kernel.org, len.brown@intel.com, akpm@osdl.org, akpm@kernel.org, linux-input@atrey.karlin.mff.cuni.cz

Hi Jaya,

On 7/25/06, jayakumar.acpi@gmail.com <jayakumar.acpi@gmail.com> wrote:
> +static acpi_status acpi_atlas_button_handler(u32 function,
> +                     acpi_physical_address address,
> +                     u32 bit_width, acpi_integer *value,
> +                     void *handler_context, void *region_context)
> +{
> +       acpi_status status;

Let's do:
      unsigned long addr = (unisigned long) address;

> +
> +       if (function == ACPI_WRITE)
> +               atlas_input_report((u8) address);

      input_report_key(input_dev, KEY_F1 + (addr & 0x0f), !(addr & 0x10));

> +       else {
> +               printk(KERN_WARNING "atlas: shrugged on unexpected function"
> +                       ":function=%x,address=%lx,value=%x\n",
> +                       function, (unsigned long)address, (u32)*value);
       function, addr, (u32)*value);

[hmm, shouldn't it be *((u32*)value)?]

... and kill atlas_input_report. Now that the module is a pure input
driver you can fold some functions together.

> +
> +       return status;
> +}
> +
> +static int atlas_acpi_button_add(struct acpi_device *device)
> +{
> +       int err;
> +
> +       err = atlas_setup_input();
> +       if (err)
> +               return err;
> +
> +       /* hookup button handler */
> +       return acpi_install_address_space_handler(device->handle,
> +                               0x81, &acpi_atlas_button_handler,
> +                               &acpi_atlas_button_setup, device);
> +}

This will leak input_dev if acpi_install_address_space_handler fails.
Please fold atlast_setup_input and atlast_acpi_button_add together
into one function (same goes for remove).

Thank you!

-- 
Dmitry
