From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [patch 09/13] ACPI: Atlas ACPI driver
Date: Fri, 2 Jun 2006 08:33:49 -0400
Message-ID: <d120d5000606020533g431043a5r94e0ca7cce1799cc@mail.gmail.com>
References: <200606020314.k523EVi4028331@shell0.pdx.osdl.net>
Reply-To: dtor_core@ameritech.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.231]:7239 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750700AbWFBMdt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 2 Jun 2006 08:33:49 -0400
Received: by wr-out-0506.google.com with SMTP id 50so492685wri
        for <linux-acpi@vger.kernel.org>; Fri, 02 Jun 2006 05:33:49 -0700 (PDT)
In-Reply-To: <200606020314.k523EVi4028331@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "akpm@osdl.org" <akpm@osdl.org>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org, jayakumar.acpi@gmail.com, luming.yu@intel.com

On 6/1/06, akpm@osdl.org <akpm@osdl.org> wrote:
> +
> +static int atlas_acpi_button_remove(struct acpi_device *device, int type)
> +{
> +       acpi_status status;
> +
> +       atlas_free_input();
> +       status = acpi_remove_address_space_handler(device->handle,
> +                               0x81, &acpi_atlas_button_handler);
> +       if (ACPI_FAILURE(status))
> +               printk(KERN_ERR "Atlas: Error removing addr spc handler\n");
> +

I think that you should free (unregister) input device only after
button handler was unregistered, otherwise there is a risk that it
will try to access already freed device. Other than that input part
looks good.

-- 
Dmitry
