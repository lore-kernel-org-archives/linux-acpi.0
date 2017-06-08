From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v6] platform/x86: Add driver for ACPI INT0002 Virtual GPIO device
Date: Thu, 8 Jun 2017 20:40:32 +0300
Message-ID: <CAHp75Vc-Vz-QRAkrq2z3B9MaAPFEVX06ePAJuxjwqcLULjRbFw@mail.gmail.com>
References: <20170602151507.22391-1-hdegoede@redhat.com> <20170602151507.22391-2-hdegoede@redhat.com>
 <CAHp75Vcdznj2mB+msNvysrvRi3L-0j4c6vthOS8oAv1S9iYWKA@mail.gmail.com>
 <20170608154541.GH32509@fury> <d41ff55b-e28f-85bf-d088-392e363fb41f@redhat.com>
 <CAJZ5v0jw3Rzjkb3J2_XE7TPBjT+7FUW90B7kg15z6_WpdNGjzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:34680 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750788AbdFHRkd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Jun 2017 13:40:33 -0400
In-Reply-To: <CAJZ5v0jw3Rzjkb3J2_XE7TPBjT+7FUW90B7kg15z6_WpdNGjzA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, joeyli <jlee@suse.com>, Takashi Iwai <tiwai@suse.de>

On Thu, Jun 8, 2017 at 8:15 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Thu, Jun 8, 2017 at 6:45 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> On 06/08/2017 05:45 PM, Darren Hart wrote:
>>> On Wed, Jun 07, 2017 at 05:53:38PM +0300, Andy Shevchenko wrote:
>>>> On Fri, Jun 2, 2017 at 6:15 PM, Hans de Goede <hdegoede@redhat.com>
>>>> wrote:

>>> Will you be taking this through fixes Andy? For a 4.12-rc* target per
>>> Hans'
>>> response to the cover letter?

>> Note that Rafael is planning to drop (revert) the commit which makes
>> it (extra) desirable for this driver to get into 4.12, so we should
>> perhaps reconsider that. I'm fine either way, but the primary reason
>> to push this as a fix for 4.12 is no longer valid AFAICT.
>
> Maybe I will just queue it up along with this series:
> http://marc.info/?l=linux-kernel&m=149688087904433&w=2
> if Andy and Darren agree?

Looks like it has ties to your series, so, I see no obstacles to go via PM tree.
Darren?


-- 
With Best Regards,
Andy Shevchenko
