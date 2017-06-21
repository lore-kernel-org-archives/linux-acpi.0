From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH 1/7] platform/x86: fujitsu-laptop: do not use kfifo for
 storing hotkey scancodes
Date: Wed, 21 Jun 2017 11:15:43 -0700
Message-ID: <20170621181543.GB25900@fury>
References: <20170616044058.30443-1-kernel@kempniu.pl>
 <20170616044058.30443-2-kernel@kempniu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:40473 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbdFUSPu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Jun 2017 14:15:50 -0400
Content-Disposition: inline
In-Reply-To: <20170616044058.30443-2-kernel@kempniu.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, Rafael Wysocki <rjw@rjwysocki.net>
Cc: Jonathan Woithe <jwoithe@just42.net>, Andy Shevchenko <andy@infradead.org>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jun 16, 2017 at 06:40:52AM +0200, Michał Kępień wrote:
> All ACPI device notify callbacks are invoked using acpi_os_execute(),
> which causes the supplied callback to be queued to a static workqueue
> which always executes on CPU 0.  This means that there is no possibility
> for any ACPI device notify callback to be concurrently executed on
> multiple CPUs, which in the case of fujitsu-laptop means that using a
> locked kfifo for handling hotkeys is redundant: as hotkey scancodes are
> only pushed and popped from within acpi_fujitsu_laptop_notify(), no risk
> of concurrent pushing and popping exists.

Was the kfifo causing a problem currently or for the migration to separate
modules? Is this purely a simplification?

Rafael, the above rationale appears sound to me. Do you have any concerns?

...

> -#define RINGBUFFERSIZE 40
>  
>  /* Debugging */
>  #define FUJLAPTOP_DBG_ERROR	  0x0001
> @@ -146,8 +144,8 @@ struct fujitsu_laptop {
>  	struct input_dev *input;
>  	char phys[32];
>  	struct platform_device *pf_device;
> -	struct kfifo fifo;
> -	spinlock_t fifo_lock;
> +	int scancode_buf[40];

Do we know why 40 was used here? A single use magic number is fine, but it would
be good to document why it is what it is if we know.

-- 
Darren Hart
VMware Open Source Technology Center
