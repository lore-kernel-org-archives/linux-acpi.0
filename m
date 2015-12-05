From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 1/9] device core: add BUS_NOTIFY_DRIVER_NOT_BOUND notification
Date: Sat, 5 Dec 2015 18:24:05 +0200
Message-ID: <CAHp75VfaqaXVx+Y4zvLXHJ9KR0zmZo+fzU36-CToioHYKYReyg@mail.gmail.com>
References: <1449265765-9393-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<1449265765-9393-2-git-send-email-andriy.shevchenko@linux.intel.com>
	<20151205161416.GA1215@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151205161416.GA1215@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>, dmaengine <dmaengine@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Sat, Dec 5, 2015 at 6:14 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Fri, Dec 04, 2015 at 11:49:17PM +0200, Andy Shevchenko wrote:
>> The users of BUS_NOTIFY_BIND_DRIVER have no chance to do any cleanup in case of
>> a probe failure. In the result there might be problems, such as some resources
>> that had been allocated will continue to be allocated and therefore lead to a
>> resource leak.
>>
>> Introduce a new notification to inform the subscriber that ->probe() failed. Do
>> the same in case of failed device_bind_driver() call.
>
> Ugh, I hate all these notifiers, but this one does make sense...

Yeah, I'm not a fan of them either.

> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

You meant Acked-by, didn't you?

-- 
With Best Regards,
Andy Shevchenko
