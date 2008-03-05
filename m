From: "Luca Tettamanti" <kronos.it@gmail.com>
Subject: Re: [patch (for 2.6.25?) 2/3] drivers/acpi/asus_acpi.c: correct use of ! and &
Date: Wed, 5 Mar 2008 11:11:46 +0100
Message-ID: <68676e00803050211m7cd24c95n8df974fcca3404f6@mail.gmail.com>
References: <200803042300.m24N0DBP001546@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.188]:32635 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761284AbYCEKLt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Mar 2008 05:11:49 -0500
Received: by rn-out-0910.google.com with SMTP id e11so6588rng.17
        for <linux-acpi@vger.kernel.org>; Wed, 05 Mar 2008 02:11:47 -0800 (PST)
In-Reply-To: <200803042300.m24N0DBP001546@imap1.linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, julia@diku.dk, len.brown@intel.com, maxime@tralhalla.org, trenn@suse.de

On Wed, Mar 5, 2008 at 12:00 AM,  <akpm@linux-foundation.org> wrote:
> From: Julia Lawall <julia@diku.dk>
>
>  In commit e6bafba5b4765a5a252f1b8d31cbf6d2459da337, a bug was fixed that
>  involved converting !x & y to !(x & y).  The code below shows the same
>  pattern, and thus should perhaps be fixed in the same way.
[...]
>  diff -puN drivers/acpi/asus_acpi.c~drivers-acpi-asus_acpic-correct-use-of-and drivers/acpi/asus_acpi.c
>  --- a/drivers/acpi/asus_acpi.c~drivers-acpi-asus_acpic-correct-use-of-and
>  +++ a/drivers/acpi/asus_acpi.c
>  @@ -610,7 +610,7 @@ write_led(const char __user * buffer, un
>             (led_out) ? (hotk->status | ledmask) : (hotk->status & ~ledmask);
>
>         if (invert)             /* invert target value */
>  -               led_out = !led_out & 0x1;
>  +               led_out = !led_out;

led_out is actually a boolean, so the mask is superfluous.

{Tested,Acked}-by: Luca Tettamanti <kronos.it@gmail.com>

Luca
