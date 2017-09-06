From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] gpio: acpi: work around false-positive
 -Wstring-overflow warning
Date: Wed, 06 Sep 2017 16:42:10 -0700
Message-ID: <1504741330.7546.6.camel@perches.com>
References: <20170906154756.2133726-1-arnd@arndb.de>
         <1504713173.7546.3.camel@perches.com>
         <CAK8P3a2RGZFc3_XpgyfuxwYy-vOoYkkamxQzma8JKwLjCCJasQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a2RGZFc3_XpgyfuxwYy-vOoYkkamxQzma8JKwLjCCJasQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Wei Yongjun <weiyongjun1@huawei.com>, linux-gpio@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2017-09-06 at 21:53 +0200, Arnd Bergmann wrote:
> On Wed, Sep 6, 2017 at 5:52 PM, Joe Perches <joe@perches.com> wrote:
> > On Wed, 2017-09-06 at 17:47 +0200, Arnd Bergmann wrote:
> > > As suggested by Andy, this changes the format string to have a fixed length.
> > > Since modifying the range check did not help, I also opened a bug against
> > > gcc, see link below.
> > 
> > The code has
> > 
> >         int pin
> > 
> > does changing pin to unsigned int matter?
> 
> No difference, see also the gcc bugzilla report.

Perhaps the bug report does not apply here as the
function is casting a unsigned int to an int through
a pointer when the int could now be negative, the int
is tested for < 256 and is then printed.
