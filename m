From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/6] gpiolib: Allow GPIO chips to request their own GPIOs
Date: Thu, 27 Feb 2014 11:48:02 +0200
Message-ID: <20140227094802.GI5018@intel.com>
References: <1393257611-18031-1-git-send-email-mika.westerberg@linux.intel.com>
 <1491992.y6nTRlJ009@vostro.rjw.lan>
 <20140226090542.GT5018@intel.com>
 <1566118.4zS0BNjL3A@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1566118.4zS0BNjL3A@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Lan Tianyu <tianyu.lan@intel.com>, Lv Zheng <lv.zheng@intel.com>, Alan Cox <alan.cox@intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 26, 2014 at 02:47:58PM +0100, Rafael J. Wysocki wrote:
> > Sounds good. Only thing I'm not sure about is the fact that
> > __gpiod_request() releases the lock when it calls chip driver callbacks
> > (and takes it back of course). Is that acceptable practice to take the lock
> > outside of a function and release it inside for a while?
> 
> Yes, you can do that.
> 
> There even are sparse annotations for that: __releases() and __acquires()
> (__rpm_callback() in drivers/base/power/runtime.c uses them among other things).

Ah, good to know. Thanks!
