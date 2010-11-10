From: Mattia Dongili <malattia@linux.it>
Subject: Re: regression since 2.6.36: backlight in sony-laptop not working
Date: Wed, 10 Nov 2010 12:58:33 +0900
Message-ID: <20101110035833.GB3029@kamineko.org>
References: <20101104142915.GC7650@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20101104142915.GC7650@gamma.logic.tuwien.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Nov 04, 2010 at 11:29:15PM +0900, Norbert Preining wrote:
> Hi Mattia, hi all,
> 
> (please keep me in Cc)
> 
> when switching from 2.6.36 to 2.6.37-rc1(+git) I realize that I cannot
> adjust the backlight anymore. Before this was possible with the
> Fn-F5 and Fn-F6 keys, but now nothing happens.

It's ages sony_laptop doesn't change, it may be some other change in the
acpi layer that causes this.

> acpi_listen does not issue anything when these keys are pressed.

How about the input layer? /proc/acpi/event is deprecated and you should
not rely on that.
But anyway, it's a Fn key issue, not backlight control itself, right?
Can you change brightness echoing to the sysfs files directly?

> Is there any obvious oversight from my side?

don't know, can you bisect it?

> config is attached.

can you attach dmesg output after loading sony_laptop with debug=1 and
pressing the brightness keys?
-- 
mattia
:wq!
