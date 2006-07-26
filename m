From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2.6.17.4 1/1] ACPI,INPUT: Move atlas to input v2
Date: Wed, 26 Jul 2006 09:35:01 -0400
Message-ID: <d120d5000607260635x7b46a1ah78e56cd2eec7e4d5@mail.gmail.com>
References: <200607261039.k6QAdwUS012519@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:7021 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750709AbWGZNfC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Jul 2006 09:35:02 -0400
Received: by ug-out-1314.google.com with SMTP id m3so3158470ugc
        for <linux-acpi@vger.kernel.org>; Wed, 26 Jul 2006 06:35:01 -0700 (PDT)
In-Reply-To: <200607261039.k6QAdwUS012519@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "jayakumar.acpi@gmail.com" <jayakumar.acpi@gmail.com>
Cc: linux-acpi@vger.kernel.org, len.brown@intel.com, akpm@osdl.org, akpm@kernel.org, linux-input@atrey.karlin.mff.cuni.cz

Hi,

On 7/26/06, jayakumar.acpi@gmail.com <jayakumar.acpi@gmail.com> wrote:
> +       err = input_register_device(input_dev);
> +       if (err) {
> +               printk(KERN_ERR "atlas: couldn't register input device\n");
> +               input_free_device(input_dev);
> +               return err;
> +       }
> +
> +       /* hookup button handler */
> +       status = acpi_install_address_space_handler(device->handle,
> +                               0x81, &acpi_atlas_button_handler,
> +                               &acpi_atlas_button_setup, device);
> +       if (ACPI_FAILURE(status)) {
> +               printk(KERN_ERR "Atlas: Error installing addr spc handler\n");
> +               input_unregister_device(input_dev);
> +       }
> +
> +       return status;

This is not a complaint about the driver but more a generic question -
how valid is it to mix error values from 2 different sets? I mean
input_register_device signals standard -EXXXX while
acpi_install_address_space_handler signals ACPI-specific error codes,
so result is some kind of monster error ;) ACPI' acpi_op_add defines
return value siimply as int which leads me to believe that -EXXXX is
more suitable here.

Overall it is unfortunate that ACPI has its own set of errors and that
they "seep" through to upper layers.

-- 
Dmitry
