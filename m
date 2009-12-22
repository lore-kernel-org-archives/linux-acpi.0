From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [git pull request] ACPI and driver patches for 2.6.33.merge
Date: Tue, 22 Dec 2009 02:31:08 -0800
Message-ID: <4B309FEC.8030406@kernel.org>
References: <alpine.LFD.2.00.0912161453480.10371@localhost.localdomain> <86802c440912171728s27dd7108k85a0f1563660c95b@mail.gmail.com> <20091218022112.GA30333@sli10-desk.sh.intel.com> <20091218051457.GB417@elte.hu> <4B309AB9.7030208@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <4B309AB9.7030208@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Shaohua Li <shaohua.li@intel.com>, Len Brown <lenb@kernel.org>
Cc: "Barnes, Jesse" <jesse.barnes@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Yinghai Lu wrote:
> Ingo Molnar wrote:
>> * Shaohua Li <shaohua.li@intel.com> wrote:
>>
>>> On Fri, Dec 18, 2009 at 09:28:50AM +0800, Yinghai Lu wrote:
>>>> On Wed, Dec 16, 2009 at 12:06 PM, Len Brown <lenb@kernel.org> wrote:
>>>>> Hi Linus,
>>>>>
>>>>> please pull from:
>>>>>
>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release
>>>>>
>>>> ;..
>>>>> Shaohua Li (3):
>>>>> ? ? ?ACPI: Add a generic API for _OSC -v2
>>>>> ? ? ?ACPI: cleanup pci_root _OSC code.
>>>>> ? ? ?ACPI: Add platform-wide _OSC support.
>>>> it seems these three patches broke the _OSC on my intel new systems.
>>>>
>>>> revert them fix the problem with AER and pciehp and etc
>>> can you give more details? I just cleaned up the _OSC code for AER and 
>>> pciehp, no function changes.
>> Famous last words ;-)
>>
>> Yinghai, i suspect Shaohua needs the kind of info you'd need if you tried to 
>> fix it: acpidump, before/after debug boot log, a description of what goes bad, 
>> etc.
> 
> the so called clean up, change the ret length checking.
> 
> -       if (!output.length)
> -               return AE_NULL_OBJECT;
> -
> 
> +       /* return buffer should have the same length as cap buffer */
> +       if (context->ret.length != context->cap.length)
> +               return AE_NULL_OBJECT;
> 
printk said:

[   54.709165] calling  aer_service_init+0x0/0x2b @ 1
[   56.121190] run_acpi_osc: ret length 40 cap length 12
[   56.124996] aer 0000:00:01.0:pcie02: AER service couldn't init device: _OSC failed

YH
