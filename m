From: Daniel Drake <drake@endlessm.com>
Subject: Re: Intel GemniLake xHCI connected devices can never wake up the
 system from suspend
Date: Mon, 19 Mar 2018 12:00:37 +0800
Message-ID: <CAD8Lp45iuZDVu++RB9ao8E9t6dBsehneXSSNebSwZdG=o02Zgg@mail.gmail.com>
References: <CAD8Lp45tvQP0aA=6zg+1j-_0jTxyyNxnrL=Gt0+0WrzeT6XS0Q@mail.gmail.com>
 <20180316082320.12636-1-drake@endlessm.com> <71f9b3cb-a66b-937a-8cfc-7b9127f6f5b9@linux.intel.com>
 <CAJZ5v0g0DH03WYO3+7CZ2_mR+t3pJ6N9xnKL2OCOjGGRT9HiAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0g0DH03WYO3+7CZ2_mR+t3pJ6N9xnKL2OCOjGGRT9HiAw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>, Chris Chiu <chiu@endlessm.com>, "Nyman, Mathias" <mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" <linux-usb@vger.kernel.org>, Linux Upstreaming Team <linux@endlessm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-acpi@vger.kernel.org

On Mon, Mar 19, 2018 at 6:36 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, Mar 16, 2018 at 10:06 AM, Mathias Nyman
> <mathias.nyman@linux.intel.com> wrote:
>> Adding Rafael directly to CC
>>
>> In short, if _S3D and _S3W are missing in DSDT then a PCI device
>> stays in D0 during suspend in Linux, but goes to D3 in Windows.
>>
>> USB wake doesn't work in Geminilake because of this.
>>
>> Should this be changed? reasoning below.
>
> It can be changed if that doesn't cause problems to happen.

I double checked that Windows 10 is going into S3 suspend and that USB
wakeup works fine on this platform - it works fine there.
Device manager for the XHCI controller clearly shows D3 being used for
S3 suspend: https://imgur.com/lF9U3V0

Current power state:
D0

Power capabilities:
00000089
PDCAP_D0_SUPPORTED
PDCAP_D3_SUPPORTED
PDCAP_WAKE_FROM_D3_SUPPORTED

Power state mappings:
S0 -> D0
S1 -> Unspecified
S2 -> Unspecified
S3 -> D3
S4 -> D3
S5 -> D3

The biggest risk of my proposed change is that we would now end up
putting a wakeup-enabled device into a too low power state where it
can no longer wake up the system. On the other hand, it solves this
issue affecting 2 different vendors, and may even result in some power
savings in general.

Perhaps we can consider the change for inclusion in Linux-4.17, giving
2-3 months of testing time.

I'll submit the patch shortly.

Thanks
Daniel
