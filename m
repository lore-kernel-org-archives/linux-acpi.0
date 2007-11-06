From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [patch 2.6.24-rc1-git] properly hookup acpi buttons to driver model tree
Date: Tue, 6 Nov 2007 15:45:10 -0500
Message-ID: <d120d5000711061245h9e69d6ck744a5ba19c02d322@mail.gmail.com>
References: <200711061207.46939.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:37534 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbXKFUpO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Nov 2007 15:45:14 -0500
Received: by ug-out-1314.google.com with SMTP id z38so14693ugc
        for <linux-acpi@vger.kernel.org>; Tue, 06 Nov 2007 12:45:10 -0800 (PST)
In-Reply-To: <200711061207.46939.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org

Hi David,

On Nov 6, 2007 3:07 PM, David Brownell <david-b@pacbell.net> wrote:
> --- g26.orig/drivers/acpi/button.c      2007-11-04 11:47:40.000000000 -0800
> +++ g26/drivers/acpi/button.c   2007-11-04 11:48:50.000000000 -0800
> @@ -395,6 +395,7 @@ static int acpi_button_add(struct acpi_d
>                error = -ENOMEM;
>                goto err_free_button;
>        }
> +       input->cdev.dev = &device->dev;
>

Don't use cdev, I will be gone as of 2.6.25. Use input_dev->dev.parent
please. Actually I sent a bunch of patches to ACPI/video to Len/ACPI
list a couple of days ago.

-- 
Dmitry
