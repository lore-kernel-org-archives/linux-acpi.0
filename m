From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH v2 0/3] Add ACPI support for pinctrl configuration
Date: Thu, 7 Apr 2016 19:48:57 +0200
Message-ID: <CACRpkdZu1MFZ+0m7VUq8hArpjiESzjqaLvFDZHOK-JUidFtwvg@mail.gmail.com>
References: <1459870406-15219-1-git-send-email-irina.tirdea@intel.com>
	<20160407125634.GO1727@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20160407125634.GO1727@lahna.fi.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Irina Tirdea <irina.tirdea@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Octavian Purdila <octavian.purdila@intel.com>, Cristina Ciocan <cristina.ciocan@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Apr 7, 2016 at 2:56 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Tue, Apr 05, 2016 at 06:33:23PM +0300, Irina Tirdea wrote:

>> Changes from v1:
>>  - address code review comments regarding coding style, documentation
>> and fixes
>>  - rewrote patch 3 ("pinctrl: Parse GpioInt/GpioIo resources") to
>> avoid using triple pointers
>>  - define pinconf_generic_dt_node_to_map since it is used by pinctrl
>> sirf driver
>>  - add dependency on PINCONF_GENERIC to the entire ACPI parsing code
>>  - dropped first patch from the series since it got merged
>> ("pinctrl: Rename pinctrl_utils_dt_free_map to pinctrl_utils_free_map")
>>
>> Irina Tirdea (3):
>>   pinctrl: pinconf-generic: Add ACPI support
>>   pinctrl: Add ACPI support
>>   pinctrl: Parse GpioInt/GpioIo resources
>
> The series looks good to me now,
>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> Of course this all depends on the decision whether this is the preferred
> way of controlling and muxing pins in ACPI.

I think the discussion is very interesting and intense right now so
let us see. We need to form some rough consensus before we
know how to proceed.

Yours,
Linus Walleij
