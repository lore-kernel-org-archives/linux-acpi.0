From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] platform/x86: intel_cht_int33fe: Work around BIOS bug on
 some devices
Date: Sat, 2 Sep 2017 10:16:05 +0300
Message-ID: <20170902071605.GH2598@lahna.fi.intel.com>
References: <20170814201425.20991-1-hdegoede@redhat.com>
 <CAHp75Vdityzx+fzU_q0vULGpT3ww8C0_D0fYtEW77Hyh1yTX6A@mail.gmail.com>
 <06a1d48c-9f75-4aab-107d-f71ce8ebbb26@redhat.com>
 <CAHp75Vdz3S5a=Vqf=rnMV9Dy+829MGNUWPmzp+B08NadBM0wNg@mail.gmail.com>
 <20170901091904.GV2598@lahna.fi.intel.com>
 <6e064337-6105-2231-a66e-ccb6aba3440a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6e064337-6105-2231-a66e-ccb6aba3440a@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Sep 01, 2017 at 11:58:55PM +0200, Hans de Goede wrote:
> Given that on the device in question where we need this workaround there
> is only ever 1 max17047, including the instance number in the check really
> is a non-problem, but if there is a strong preference for me to change
> the check over to a _HID check then I can do a v2 doing so.

I would still prefer _HID check if possible. Otherwise someone finds
this hack later and uses it in another driver thinking it is the right
thing to do ;-)
