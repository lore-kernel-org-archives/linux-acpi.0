From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI: don't show an error when we're not in charge of
 PCIe hotplug.
Date: Thu, 23 Jun 2016 00:47:49 +0200
Message-ID: <CAJZ5v0g5E-=ORTQEqjnv-U=7mAwqD-t1-A1nfaFTJsypuT2ueg@mail.gmail.com>
References: <1466028904-28328-1-git-send-email-pjones@redhat.com>
 <CAJZ5v0g5_M=iNLE_P4eOcwJet=jPm_EifAMdDtvG+TR=1AnU2Q@mail.gmail.com>
 <CAJZ5v0ifNFP5jzPf+zMC3rJ1HKzBmCz1AdhsAsmj75EpndoPTQ@mail.gmail.com>
 <20160621151853.GE28967@redhat.com> <cf3d90a8598241ff9b6e28b8fb037633@ausx13mpc120.AMER.DELL.COM>
 <CAJZ5v0ji0DpVsNbnKQpWTdJS-d9y+dh-BVGGfJ_o5fHGe8qeiA@mail.gmail.com>
 <c6d927d71f544432a48a38047c8bfb14@ausx13mpc124.AMER.DELL.COM> <CALCETrVy5nKGEyGD9XCR8ZJaa+9WaM_x77ipG8sLjTWm=8VoOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALCETrVy5nKGEyGD9XCR8ZJaa+9WaM_x77ipG8sLjTWm=8VoOw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>, Mario Limonciello <Mario_Limonciello@dell.com>
Cc: Rafael Wysocki <rafael@kernel.org>, Peter Jones <pjones@redhat.com>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jun 22, 2016 at 10:53 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Wed, Jun 22, 2016 at 12:43 PM,  <Mario_Limonciello@dell.com> wrote:
>>> -----Original Message-----
>>> From: rjwysocki@gmail.com [mailto:rjwysocki@gmail.com] On Behalf Of

[cut]

>> I think changing that would help communicate what's going on here and at
>> least let the user know the result will be that the firmware is still controlling
>> ASPM due to the _OSC failure.

You seem to be assuming that all systems returning "unsupported UUID"
from the PCI host bridge _OSC will always fall into the same category,
but what if they don't?  What if at least some of them are really
broken?

>> Something else that I think Andy recommended a while back was at that
>> time try to evaluate NEXP and display its value and an associated message
>> in debug logs when _OSC fails.  Would you be amenable to a change like that?
>
> That seems dangerous if NEXP is anything other than a SystemMemory
> variable.  I don't know if there's a clean way to check that before
> evaluating it.  (i.e. we don't want to hit some other thing called
> NEXP that has side effects.)

Well, that's generic code and NEXP is not generic really, so agreed.

Thanks,
Rafael
