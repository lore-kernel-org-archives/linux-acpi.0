From: "Mattia Dongili" <malattia@linux.it>
Subject: Re: [PATCH 0/2] Deliver ACPI events upon subscription and
     implement multiple readers for /proc/acpi/event
Date: Wed, 25 Jan 2006 09:16:41 +0100 (CET)
Message-ID: <13504.83.103.117.254.1138177001.squirrel@picard.linux.it>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005D29F8D@hdsmsx401.amr.corp.intel.com>
    <200601242046.27670.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from picard.linux.it ([213.254.12.146]:3537 "EHLO picard.linux.it")
	by vger.kernel.org with ESMTP id S1750703AbWAYIQm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jan 2006 03:16:42 -0500
In-Reply-To: <200601242046.27670.dtor_core@ameritech.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Wed, January 25, 2006 2:46 am, Dmitry Torokhov said:
> On Tuesday 24 January 2006 20:17, Brown, Len wrote:
>> What's the problem with opening a socket to the user-space acpid --
>> the way multiple readers work today?
>>
>
> - one does not want to use current implementation of acpid?
> - one does not want to depend on having acpid running before
>   starting snooping acpi events?
> - because allowing multiple readers is a "right thing to do"?

One more:
- because acpid disappearing and reappearing at random times causes
useless complexity and troubles to its socket readers?

-- 
mattia
:wq!


