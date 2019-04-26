From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 2/2] gpio: sch: Add interrupt support
Date: Fri, 26 Apr 2019 21:01:50 +0530
Message-ID: <20190426153150.GA28444@Mani-XPS-13-9360>
References: <7e328b7e-f4f0-851a-4152-a9ffd058201c@siemens.com>
 <20190424094506.GA2654@lahna.fi.intel.com>
 <292e6eff-82cc-6e4d-925b-77a60399e2e0@siemens.com>
 <20190424100130.GB2654@lahna.fi.intel.com>
 <1200464b-f969-ebc2-ae82-1f8ca98aaca1@siemens.com>
 <20190424103306.GC2654@lahna.fi.intel.com>
 <9377620b-d74a-04d9-a51e-8590400b1c0f@siemens.com>
 <20190426130615.GT9224@smile.fi.intel.com>
 <bd5453e1-0279-02ab-3304-edc6ebf509dc@siemens.com>
 <bc856e19-470d-7655-5680-a031831ab513@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bc856e19-470d-7655-5680-a031831ab513@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, Apr 26, 2019 at 04:42:35PM +0200, Enrico Weigelt, metux IT consult wrote:
> On 26.04.19 15:36, Jan Kiszka wrote:
> 
> > At the same time, there are no real alternatives - to my> knowledge - for the value it brings (various bindings) to simply
> switch> the engine.
> Which value exactly does that collection of crude wrappers and broken
> attempts to buypass the kernel (driving gpios via /dev/mem *facepalm*)
> provide ?
> 

/dev/mem access to gpio's were done during the sysfs days (yes to bypass
the kernel interface) but now mraa will use chardev if the kernel is
chardev supported. Still, it just behaves the way you want (/dev/mem was
also optional back then) and I couldn't find a better alternative for playing
in the userspace with multiple languages.

-Mani

> mraa belongs to the category of software, I would never put onto any
> production system. (yes, I already had a client who asked me to repair
> his mraa-based software. finally, I've replaced mraa w/ a few LoC ...)
> 
> 
> --mtx
> 
> -- 
> Enrico Weigelt, metux IT consult
> Free software and Linux embedded engineering
> info@metux.net -- +49-151-27565287
