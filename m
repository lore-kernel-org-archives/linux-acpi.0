From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 3/4] device property: constify property arrays values
Date: Thu, 02 Feb 2017 09:07:30 -0800
Message-ID: <C3BEC996-015E-4536-AE2F-DB0819631789@gmail.com>
References: <20170201173125.40354-1-dmitry.torokhov@gmail.com> <20170201173125.40354-4-dmitry.torokhov@gmail.com> <1485991803.22276.14.camel@perches.com> <1605853.brEpCT4tOG@aspire.rjw.lan> <20170202163918.GA21924@dtor-ws> <1486054110.2133.366.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34341 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751394AbdBBRHh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Feb 2017 12:07:37 -0500
In-Reply-To: <1486054110.2133.366.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Joe Perches <joe@perches.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>

On February 2, 2017 8:48:30 AM PST, Andy Shevchenko <andriy=2Eshevchenko@li=
nux=2Eintel=2Ecom> wrote:
>On Thu, 2017-02-02 at 08:39 -0800, Dmitry Torokhov wrote:
>> From: Dmitry Torokhov <dmitry=2Etorokhov@gmail=2Ecom>
>>=20
>> Data that is fed into property arrays should not be modified, so
>let's
>> mark
>> relevant pointers as const=2E This will allow us making source arrays
>as
>> const/__initconst=2E
>>=20
>
>> Also fix memory leaks on errors in property_entry_copy()=2E
>
>While the code looks okay, I'm not sure what memory leaks you are
>referring to=2E The idea as far as I remember was to run *free() function
>if *copy() fails=2E

That could have been OK for internal function, but will not work for publi=
c API, as it goes against normal pattern=2E

You will be old and grey and still correcting patches that would be gettin=
g it wrong :)


Thanks=2E

--=20
Dmitry
