From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH 0/2] gpio / ACPI: Two minor cleanups related to ACPI_HANDLE()
Date: Wed, 18 Mar 2015 10:47:30 +0900
Message-ID: <CAAVeFu+a6HVKaB7-4CHqgK50uAtzE6tt_bTWYaNUP55o8xA0Qg@mail.gmail.com>
References: <4032246.STUT1iRmIk@vostro.rjw.lan> <3557241.dRi1Xkn3WC@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3557241.dRi1Xkn3WC@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Mar 18, 2015 at 10:37 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, March 10, 2015 11:07:36 PM Rafael J. Wysocki wrote:
>> Hi,
>>
>> As per the subject, avoid evaluating ACPI_HANDLE() if we can as that one is
>> rather costly.
>
> Linus, Alexandre, any objections to this series?
>
> If not, would there be any problem if I took these to my tree?  I'll probably
> have material on top of them.

Sorry for the delay. Looks like Linus just took the patches in his
tree, I hope that's ok?
