From: "Jaya Kumar" <jayakumar.acpi@gmail.com>
Subject: Re: [PATCH 2.6.17.4 1/1] ACPI,INPUT: Move atlas to input v2
Date: Thu, 27 Jul 2006 18:37:21 +0800
Message-ID: <756b48450607270337ibaa4fe8t443be1734127d8b@mail.gmail.com>
References: <200607261039.k6QAdwUS012519@localhost.localdomain>
	 <d120d5000607260635x7b46a1ah78e56cd2eec7e4d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:46474 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751129AbWG0KhX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Jul 2006 06:37:23 -0400
Received: by ug-out-1314.google.com with SMTP id m3so188142ugc
        for <linux-acpi@vger.kernel.org>; Thu, 27 Jul 2006 03:37:22 -0700 (PDT)
In-Reply-To: <d120d5000607260635x7b46a1ah78e56cd2eec7e4d5@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-acpi@vger.kernel.org, len.brown@intel.com, akpm@osdl.org, akpm@kernel.org, linux-input@atrey.karlin.mff.cuni.cz

On 7/26/06, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
> This is not a complaint about the driver but more a generic question -
> how valid is it to mix error values from 2 different sets? I mean
> input_register_device signals standard -EXXXX while
> acpi_install_address_space_handler signals ACPI-specific error codes,
> so result is some kind of monster error ;) ACPI' acpi_op_add defines
> return value siimply as int which leads me to believe that -EXXXX is
> more suitable here.

You are right. There is an issue to be fixed there.

>
> Overall it is unfortunate that ACPI has its own set of errors and that
> they "seep" through to upper layers.
>

Agreed.

Here's what I see for example:
in atlas_acpi_button_remove, I have to call
acpi_remove_address_space_handler which could return at least:
AE_BAD_PARAMETER
AE_NOT_EXIST

I guess I could at least convert those into -EINVAL, -ENODEV. But
maybe it's better if there was a best effort convert_acpi_to_errno
function? Is that appropriate?

Thanks,
jaya
