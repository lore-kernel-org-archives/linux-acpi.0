From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] fujitsu-laptop: driver [un]registration fixes
Date: Mon, 21 Dec 2009 10:03:21 -0800
Message-ID: <200912211003.22227.dmitry.torokhov@gmail.com>
References: <200907292215.33182.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-outbound-1.vmware.com ([65.115.85.69]:36826 "EHLO
	smtp-outbound-1.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751549AbZLUSDX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Dec 2009 13:03:23 -0500
In-Reply-To: <200907292215.33182.bzolnier@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Bartlomiej,

On Wed, Jul 29, 2009 at 10:15:33PM +0200, Bartlomiej Zolnierkiewicz wrote:
> @@ -722,22 +722,22 @@ static int acpi_fujitsu_add(struct acpi_
>  
>  	return result;
>  
> -end:
> +err_unregister_input_dev:
> +	input_unregister_device(input);
>  err_free_input_dev:
>  	input_free_device(input);
>  err_stop:

Just noticed it scanning ACPI list. You must not use input_free_device()
after calling input_unregister_device() since unregister likely drops the
last reference to the device and it will get freed by input core.

For polled input devices you need to use both unregister and free though 
because polled device structure is not refcounted (but underlying input device 
is).

Thanks.

-- 
Dmitry
