From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v1 2/3] gpio: Add support for TPS68470 GPIOs
Date: Mon, 12 Jun 2017 12:29:32 +0300
Message-ID: <CAHp75Vd==vnSo7P2kozDrPdu+1WB8O3fck3ELbK4aAqW9tvppQ@mail.gmail.com>
References: <1496750118-5570-1-git-send-email-rajmohan.mani@intel.com>
 <1496750118-5570-3-git-send-email-rajmohan.mani@intel.com>
 <CAHp75Vc6PSDqc=Vxj2z-d49p+E-7tciunhki=8a7HPjQGuSwXQ@mail.gmail.com>
 <6F87890CF0F5204F892DEA1EF0D77A59725BF110@FMSMSX114.amr.corp.intel.com>
 <20170611113007.GV1019@valkosipuli.retiisi.org.uk> <CAHp75VeJaQjWb1834Nt7178GL72rcym=d3zV8tPpvJ5qKDuM_Q@mail.gmail.com>
 <20170611165028.GA12407@valkosipuli.retiisi.org.uk> <CAHp75VcyPy5kO+Ra-fPqaXZOp66sTe=L6W4UF00JWA6LP_KGeQ@mail.gmail.com>
 <6F87890CF0F5204F892DEA1EF0D77A59725BF45D@FMSMSX114.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35882 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751955AbdFLJ3d (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Jun 2017 05:29:33 -0400
In-Reply-To: <6F87890CF0F5204F892DEA1EF0D77A59725BF45D@FMSMSX114.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Mani, Rajmohan" <rajmohan.mani@intel.com>
Cc: Sakari Ailus <sakari.ailus@iki.fi>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

On Mon, Jun 12, 2017 at 12:17 PM, Mani, Rajmohan
<rajmohan.mani@intel.com> wrote:
>> Subject: Re: [PATCH v1 2/3] gpio: Add support for TPS68470 GPIOs
>> On Sun, Jun 11, 2017 at 7:50 PM, Sakari Ailus <sakari.ailus@iki.fi> wrote:
>> > On Sun, Jun 11, 2017 at 04:40:16PM +0300, Andy Shevchenko wrote:
>> >> On Sun, Jun 11, 2017 at 2:30 PM, Sakari Ailus <sakari.ailus@iki.fi> wrote:

>> >> > Again, I'm not really worried about this driver, but the ACPI
>> >> > tables. How does the difference show there?
>> >>
>> >> Same way. You will have common numbering over the chip [0, 9]. It
>> >> will be just an abstraction inside the driver.

>> > Sounds fine to me, taken that this does not add complications to ACPI
>> > tables.
>>
>> They just need to share the same ACPI_HANDLE (it might require to do this in
>> generic way in gpiolib) and have a continuous numbering (easy to achieve with
>> carefully chosen bases).

> Few clarifications...
>
> Are you implying new kernel changes are needed in gpiolib to accommodate 2 GPIO chips?

Might be needed. It should be investigated first.
In any case it would be somelike oneliner.

> Does it need changes in platform firmware or is it expected to work just with the gpiolib changes that you described above?

No firmware changes are implied.

-- 
With Best Regards,
Andy Shevchenko
