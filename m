From: "Mattia Dongili" <malattia@linux.it>
Subject: Re: [PATCH 0/2] Deliver ACPI events upon subscription and
     implement multiple readers for /proc/acpi/event
Date: Wed, 25 Jan 2006 10:54:51 +0100 (CET)
Message-ID: <10537.83.103.117.254.1138182891.squirrel@picard.linux.it>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005D2A09E@hdsmsx401.amr.corp.intel.com>
    <200601250023.01359.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from picard.linux.it ([213.254.12.146]:22479 "EHLO picard.linux.it")
	by vger.kernel.org with ESMTP id S1751101AbWAYJyw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jan 2006 04:54:52 -0500
In-Reply-To: <200601250023.01359.dtor_core@ameritech.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Wed, January 25, 2006 6:23 am, Dmitry Torokhov said:
> On Wednesday 25 January 2006 00:09, Brown, Len wrote:
[...]
> If you remember original code (without registering multiple in-kernel
> listeners) I think it was more compact that what is in the kernel
> at the moment. Also IIRC current in kernel code may start filling memory
> if acpid stops reading events for some reason.
>
> For the record I think multiple listeners are not needed since the only
> possible user is input layer and I firmly believe that ACPI should report
> keys/buttons using input layer natively so userspace can get uniform
> notification of "Sleep" button being pressed no matter whther that button
> is controlled by ACPI or it is just another key on USB keyboard.

I have no problem changing the implementation to avoid useless stuff if
the patch is going to be considered for acceptance.

>> The other argument against is why enhance an interface when
>> perhaps we should instead consider replacing it altogether...

The same thing has been said at Dmitry's submission (08/2004) and
/proc/acpi/event is still there. :)
Also, removing /proc/acpi/event will take a very long time.
Anyway what would you suggest (if you have already some plan)? I'd like to
try implementing it.

-- 
mattia
:wq!


