From: Daniel Drake <drake@endlessm.com>
Subject: Re: Intel GemniLake xHCI connected devices can never wake up the
 system from suspend
Date: Fri, 16 Mar 2018 15:47:14 +0800
Message-ID: <CAD8Lp45tvQP0aA=6zg+1j-_0jTxyyNxnrL=Gt0+0WrzeT6XS0Q@mail.gmail.com>
References: <CAB4CAwf_k-WsF3zL4epm9TKAOu0h=Bv1XhXV_gY3bziOo_NPKA@mail.gmail.com>
 <6c8df688-b456-6f07-9325-6f4dfd8f0883@linux.intel.com> <CAB4CAwf39wW2LmuY-TZNdfgL=SBiDZuXvRNu7MD7j5Nc8O-bkg@mail.gmail.com>
 <278fe5fa-7b33-02e5-12e3-b7760952b297@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <278fe5fa-7b33-02e5-12e3-b7760952b297@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Chris Chiu <chiu@endlessm.com>, mathias.nyman@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Upstreaming Team <linux@endlessm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

I'm working alongside Chris on this issue.

On Fri, Mar 16, 2018 at 12:11 AM, Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
> Scope (_SB.PCI0.XHC) has _PS0 method, so Linux will look for a _S3W to get
> the
> lowest possible D state in S3, but_S3W is missing, so Linux pci-acpi code
> will
> probably default to D0

Yes, _S3W is missing, and in this case, acpi_dev_pm_get_state() is
setting the maximum number permitted device power state to the minimum
value of D0.

So the XHCI controller is in D0 when you go into suspend.

I tried your hack to force it into D3hot. Now the system can wake up
from resume via the USB port. Thanks for finding that.

>> ASUS said the BIOS has no problem on USB wakeup under Windows so I don't
>> think
>> there's any update. Anything else could be cause for this?
>
> Linux and Windows probably check different DSDT values

I've studied the ACPI spec trying to understand better, but I'm
struggling with the question:
What is the maximum number (lowest power) permitted device power state
for a device that is configured as able to wake the system from S3,
**that does not implement the _S3W method**?

As far as I can see, the ACPI spec doesn't give an answer. It's clear
what the behaviour is when _S3W is present, but not unclear what
should happen when it is not there.

As noted above, Linux's interpretation is that in such case, the
device must remain fully on (D0) when going into S3. I am wondering if
Windows just has made an alternative assumption that all available
device power states can wake the system from suspend in such case.

This is working in Windows so hopefully we can find a way to match the
behaviour?

Thanks
Daniel
