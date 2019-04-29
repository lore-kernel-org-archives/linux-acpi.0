From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH 2/2] gpio: sch: Add interrupt support
Date: Mon, 29 Apr 2019 13:09:20 +0200
Message-ID: <ea29ee73-705b-7d13-0084-11274db02394@metux.net>
References: <20190424081802.GV2654@lahna.fi.intel.com>
 <5a28f22c-22f7-760a-d076-68ff19800d44@siemens.com>
 <20190424084259.GW2654@lahna.fi.intel.com>
 <7e328b7e-f4f0-851a-4152-a9ffd058201c@siemens.com>
 <20190424094506.GA2654@lahna.fi.intel.com>
 <292e6eff-82cc-6e4d-925b-77a60399e2e0@siemens.com>
 <20190424100130.GB2654@lahna.fi.intel.com>
 <1200464b-f969-ebc2-ae82-1f8ca98aaca1@siemens.com>
 <20190424103306.GC2654@lahna.fi.intel.com>
 <9377620b-d74a-04d9-a51e-8590400b1c0f@siemens.com>
 <20190426130615.GT9224@smile.fi.intel.com>
 <bd5453e1-0279-02ab-3304-edc6ebf509dc@siemens.com>
 <bc856e19-470d-7655-5680-a031831ab513@metux.net>
 <2f3da791-4a10-c2c4-dc5a-22ad16ed7be6@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2f3da791-4a10-c2c4-dc5a-22ad16ed7be6@siemens.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-acpi@vger.kernel.org

On 26.04.19 18:03, Jan Kiszka wrote:

> Leaving that blunt hack aside:
> 
> import mraa
> 
> pin = mraa.Gpio(13)
> pin.dir(mraa.DIR_OUT)
> pin.write(1)
> 
> And the same goes for nodejs, java and c++.

Such trivial wrappers are easy write in the coffe break.
For those usecases the good old sysfs interface is really sufficient.

(I'm frequently replacing those kind of "abstraction layers" of sevaral
10kLoC in various client projects by just a few lines of really tiny
shim ...)

And relying on numeric gpio ids is generally a bad idea.
(exactly one of the kind of problems why certain clients call me in
great despair, when it broke again :p)

> Moreover, this allows you to abstract away where "Pin 13" actually came
> from on that board if the kernel changes (BSP -> upstream...) or the
> extension board or ... 

As said: numeric pin IDs are a *bad* idea.
If it's a *name* (=string), then that seems to be a usecase for labels.
For convenience, you could just pupulate the fs w/ proper symlinks that
are named by the pin names from the schematics.

> We will exploit that when moving to a completely
> different base hardware with the next revision or our IOT2000.

When doing that, you could also kick out Intel and move to ARM, as quite
everybody else does ;-)

<snip>

> You also have to keep the class of "cool, I've just created my first
> Node.RED node!" IoT newbies in mind.

As said above: writing a small js wrapper for that is just a coffee
break job.

> These higher abstraction help to
> keep them away from the wrong lower APIs - or enable them to do
> something at all ("Cool, I've just connected my first two nodes!"). 

gpio's are already very low-level. Highlevel would be things like keys,
leds, etc.

That's one of the things I frequently have to teach my clients: first
make yourself clear about what you're *actually* doing with these pins
and then pick the right drivers.

Okay, we could talk about creating some nice oftree-overlay generators,
to make it easier for newbies. Or create some small DSL, perhaps w/ some
tiny GUI editor. But don't let them play w/ raw gpio's - this quickly
goes horribly wrong (I've seen that in the field, many times).

It's nice, that you folks (Siemens) are now doing your own controller,
so you can finally throw out the ugly AMX+co crap. But please don't
repeat their mistakes. We don't need yet another raspi for building
automation - we need a different programming model than the old PLC-
style spaghetti configuration :p

(oh, and if you add ATEX and railways certification, I might have a new
customer for you ;-))

Okay, that's getting far OT, so maybe we should continue off-list ;-)

> By far not all of them have consultants at hand.

They better should :p

> And while we only ship our IOT2000 image with mraa and all the fun as
> reference image, it's way more for quite a few users. Even if you do not
> want to look behind the curtains of certain software components (that we
> primarily inherited and then started to clean up), they are working, or
> we would have heard.

Maybe because some field techs rather grab some beers and go to some
friend who happens to be a linux hacker, instead of burning their time
on the official channels those big corporate structures ;-)


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
