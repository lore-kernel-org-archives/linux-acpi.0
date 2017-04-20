From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 2/2] ACPI / PMIC: Stop xpower OPRegion handler relying
 on IIO
Date: Thu, 20 Apr 2017 12:38:02 +0200
Message-ID: <CAJZ5v0gmi8e0tLSiK28=5=rCKp2EdhFxZG9Exr98siRB6Rt-ag@mail.gmail.com>
References: <20170419130700.31277-1-hdegoede@redhat.com> <20170419130700.31277-3-hdegoede@redhat.com>
 <CAJZ5v0i6SztwFrkGA3cw9Y+qCGuJ_mH_gMBXbXx9SgGMRQjHfA@mail.gmail.com> <1492676373.24567.91.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34358 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942996AbdDTKiD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Apr 2017 06:38:03 -0400
Received: by mail-oi0-f67.google.com with SMTP id y11so5892846oie.1
        for <linux-acpi@vger.kernel.org>; Thu, 20 Apr 2017 03:38:03 -0700 (PDT)
In-Reply-To: <1492676373.24567.91.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thu, Apr 20, 2017 at 10:19 AM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Wed, 2017-04-19 at 22:18 +0200, Rafael J. Wysocki wrote:
>> On Wed, Apr 19, 2017 at 3:07 PM, Hans de Goede <hdegoede@redhat.com>
>> wrote:
>> > The intel_pmic_xpower code provides an OPRegion handler, which must
>> > be
>> > available before other drivers using it are loaded, which can only
>> > be
>> > ensured if both the mfd and opregion drivers are built in, which is
>> > why
>> > the Kconfig option for intel_pmic_xpower is a bool.
>> >
>> > The use of IIO is causing trouble for generic distro configs here as
>> > distros will typically want to build IIO drivers as modules and
>> > there
>> > really is no reason to use IIO here. The reading of the ADC value is
>> > a
>> > single regmap_bulk_read, which is already protected against races by
>> > the regmap-lock.
>> >
>> > This commit removes the use of IIO, allowing distros to enable the
>> > driver without needing to built IIO in and also actually simplifies
>> > the code.
>> >
>> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>
>> Andy, Srinivas, any concerns?
>
> I would prefer to have this magic shifts in a common header between
> drivers, but I'm not insisting (I admit it might take much more work for
> no clear benefit, except keeping ADC bits in one place).
>
> So, I'm fine with this change.

OK

I'm going to apply the series then.

Thanks,
Rafael
