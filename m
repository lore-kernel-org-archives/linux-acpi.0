From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH v2 0/3] Add ACPI support for pinctrl configuration
Date: Thu, 14 Apr 2016 13:58:17 +0200
Message-ID: <CACRpkdbj==q5wp2Z5-ZXkbfeXa4y+beLF_3YN-vS3CtyAKGwkg@mail.gmail.com>
References: <1459870406-15219-1-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1459870406-15219-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>, Graeme Gregory <gg@slimlogic.co.uk>, Octavian Purdila <octavian.purdila@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Cristina Ciocan <cristina.ciocan@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 5, 2016 at 5:33 PM, Irina Tirdea <irina.tirdea@intel.com> wrote:

> This is a proposal for adding ACPI support for pin controller
> configuration.

The patch set is tagged RFC and I see that comments you
got a lot of, so I'm looking forward to see what is happening.

I have identified the following stakeholders:

- Irina, Octavian, Mika: want to use ACPI for pin control,
  their draft idea is expressed in this RFC

- Mark R, Mark B, Graeme + more: want to avoid clashes
  with existing or upcoming ACPI standardization attempts

- Rafael as ACPI maintainer for Linux, he seems to be
  in the same diplomatic middle-ground as I am

Clearly this is too high level of conflicting interests for me
to proceed with this proposal as it stands today.

If however we see products deployed using this method as
put forward in the proposal, there is not much to do: we will
just have to support it. I am just hoping that this is not happening
as we speak.

I am somewhat waiting for the ACPI crowd to bring a
counter-proposal to the table. Or some statement of when
they would be able to present one: I certainly understand that
standardization takes time. DT and ACPI both suffer from the
fact that they sometimes need big upfront design.

Yours,
Linus Walleij
