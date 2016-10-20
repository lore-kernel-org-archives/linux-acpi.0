From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] watchdog: wdat_wdt: Ping the watchdog on resume
Date: Fri, 21 Oct 2016 00:47:24 +0200
Message-ID: <CAJZ5v0jRdmskuLsL17UZtS8P6=kCpjNj=qwm-ciEKnQ7VAjXcg@mail.gmail.com>
References: <20161020150336.97791-1-mika.westerberg@linux.intel.com> <20161020221931.GA929@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33271 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755754AbcJTWrZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Oct 2016 18:47:25 -0400
In-Reply-To: <20161020221931.GA929@roeck-us.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Fri, Oct 21, 2016 at 12:19 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Thu, Oct 20, 2016 at 06:03:36PM +0300, Mika Westerberg wrote:
>> It turns out we need to ping the watchdog hardware on resume when we
>> re-program it. Otherwise this results inadvertent reset to trigger right
>> after the resume is completed.
>>
>> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
>
> [ assuming Rafael is going to pick it up ]

I am, thanks!

Rafael
