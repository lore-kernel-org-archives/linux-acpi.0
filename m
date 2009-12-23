From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [git pull request] ACPI and driver patches for 2.6.33.merge
Date: Tue, 22 Dec 2009 18:09:04 -0800
Message-ID: <86802c440912221809w35dbb1eegcf6133ed1f190069@mail.gmail.com>
References: <alpine.LFD.2.00.0912161453480.10371@localhost.localdomain>
	 <86802c440912171728s27dd7108k85a0f1563660c95b@mail.gmail.com>
	 <20091218022112.GA30333@sli10-desk.sh.intel.com>
	 <20091218051457.GB417@elte.hu> <4B309AB9.7030208@kernel.org>
	 <20091223005637.GA16783@sli10-desk.sh.intel.com>
	 <4B317491.5050303@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:53454 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbZLWCJH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Dec 2009 21:09:07 -0500
In-Reply-To: <4B317491.5050303@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>, "Barnes, Jesse" <jesse.barnes@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>

On Tue, Dec 22, 2009 at 5:38 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> Shaohua Li wrote:
>> On Tue, Dec 22, 2009 at 06:08:57PM +0800, Yinghai Lu wrote:
>>> Ingo Molnar wrote:
>>>> * Shaohua Li <shaohua.li@intel.com> wrote:
>>>>
>>>>> On Fri, Dec 18, 2009 at 09:28:50AM +0800, Yinghai Lu wrote:
>>>>>> On Wed, Dec 16, 2009 at 12:06 PM, Len Brown <lenb@kernel.org> wr=
ote:
>>>>>>> Hi Linus,
>>>>>>>
>>>>>>> please pull from:
>>>>>>>
>>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2=
=2E6.git release
>>>>>>>
>>>>>> ;..
>>>>>>> Shaohua Li (3):
>>>>>>> ? ? ?ACPI: Add a generic API for _OSC -v2
>>>>>>> ? ? ?ACPI: cleanup pci_root _OSC code.
>>>>>>> ? ? ?ACPI: Add platform-wide _OSC support.
>>>>>> it seems these three patches broke the _OSC on my intel new syst=
ems.
>>>>>>
>>>>>> revert them fix the problem with AER and pciehp and etc
>>>>> can you give more details? I just cleaned up the _OSC code for AE=
R and
>>>>> pciehp, no function changes.
>>>> Famous last words ;-)
>>>>
>>>> Yinghai, i suspect Shaohua needs the kind of info you'd need if yo=
u tried to
>>>> fix it: acpidump, before/after debug boot log, a description of wh=
at goes bad,
>>>> etc.
>>> the so called clean up, change the ret length checking.
>>>
>>> - =A0 =A0 =A0 if (!output.length)
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return AE_NULL_OBJECT;
>>> -
>>>
>>> + =A0 =A0 =A0 /* return buffer should have the same length as cap b=
uffer */
>>> + =A0 =A0 =A0 if (context->ret.length !=3D context->cap.length)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return AE_NULL_OBJECT;
>> Wield BIOS. ACPI spec does mention the return buffer have the same l=
ength.
>> Does changing the check back make the issue go away?
>
> change to
> if (context->ret.length < context->cap.length)
>
> make AER work, but pciehp still fail.

[   54.190606] calling  aer_service_init+0x0/0x2b @ 1
[   55.200862] run_acpi_osc: ret length 40 cap length 12
[   55.203924] aer 0000:00:01.0:pcie02: service driver aer loaded
[   55.208520] aer 0000:00:03.0:pcie02: service driver aer loaded
[   55.222730] aer 0000:00:05.0:pcie02: service driver aer loaded
[   55.238340] aer 0000:00:07.0:pcie02: service driver aer loaded
[   55.242030] aer 0000:00:09.0:pcie02: service driver aer loaded
[   56.270866] run_acpi_osc: ret length 40 cap length 12
[   56.275370] aer 0000:80:00.0:pcie02: service driver aer loaded
[   56.279645] aer 0000:80:01.0:pcie02: service driver aer loaded
[   56.289378] aer 0000:80:03.0:pcie02: service driver aer loaded
[   56.306406] aer 0000:80:05.0:pcie02: service driver aer loaded
[   56.309489] aer 0000:80:07.0:pcie02: service driver aer loaded
[   56.326848] aer 0000:80:09.0:pcie02: service driver aer loaded
[   56.330392] initcall aer_service_init+0x0/0x2b returned 0 after 2089=
791 usecs
[   56.347263] calling  aer_inject_init+0x0/0x12 @ 1
[   56.349822] initcall aer_inject_init+0x0/0x12 returned 0 after 290 u=
secs
[   56.367496] calling  ioapic_init+0x0/0x1b @ 1
[   56.370813] initcall ioapic_init+0x0/0x1b returned 0 after 718 usecs
[   56.387751] calling  pci_hotplug_init+0x0/0x4e @ 1
[   56.391225] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   56.407362] initcall pci_hotplug_init+0x0/0x4e returned 0 after 1578=
5 usecs
[   56.411486] calling  pcied_init+0x0/0x9c @ 1
[   56.427349] acpi_pcihp: acpi_get_hp_hw_control_from_firmware:
Trying to get hotplug control for \_SB_.PCI0
[   56.446705] Firmware did not grant requested _OSC control
[   56.450227] acpi_pcihp: acpi_get_hp_hw_control_from_firmware:
Cannot get control of hotplug hardware for pci 0000:00:03.0
[   56.469325] acpi_pcihp: acpi_get_hp_hw_control_from_firmware:
Trying to get hotplug control for \_SB_.PCI0
[   56.488221] Firmware did not grant requested _OSC control
[   56.491440] acpi_pcihp: acpi_get_hp_hw_control_from_firmware:
Cannot get control of hotplug hardware for pci 0000:00:05.0
[   56.511164] acpi_pcihp: acpi_get_hp_hw_control_from_firmware:
Trying to get hotplug control for \_SB_.PCI0
[   56.530074] Firmware did not grant requested _OSC control
[   56.546595] acpi_pcihp: acpi_get_hp_hw_control_from_firmware:
Cannot get control of hotplug hardware for pci 0000:00:1c.0
[   56.567448] acpi_pcihp: acpi_get_hp_hw_control_from_firmware:
Trying to get hotplug control for \_SB_.PCIB
[   56.586091] Firmware did not grant requested _OSC control
[   56.589624] acpi_pcihp: acpi_get_hp_hw_control_from_firmware:
Cannot get control of hotplug hardware for pci 0000:80:03.0
[   56.611700] acpi_pcihp: acpi_get_hp_hw_control_from_firmware:
Trying to get hotplug control for \_SB_.PCIB
[   56.627768] Firmware did not grant requested _OSC control
[   56.630734] acpi_pcihp: acpi_get_hp_hw_control_from_firmware:
Cannot get control of hotplug hardware for pci 0000:80:05.0
[   56.655403] acpi_pcihp: acpi_get_hp_hw_control_from_firmware:
Trying to get hotplug control for \_SB_.PCI0
[   56.671933] Firmware did not grant requested _OSC control
[   56.687138] acpi_pcihp: acpi_get_hp_hw_control_from_firmware:
Cannot get control of hotplug hardware for pci 0000:00:03.0
[   56.708671] acpi_pcihp: acpi_get_hp_hw_control_from_firmware:
Trying to get hotplug control for \_SB_.PCI0
[   56.726175] Firmware did not grant requested _OSC control
[   56.728791] acpi_pcihp: acpi_get_hp_hw_control_from_firmware:
Cannot get control of hotplug hardware for pci 0000:00:05.0
[   56.749652] acpi_pcihp: acpi_get_hp_hw_control_from_firmware:
Trying to get hotplug control for \_SB_.PCI0
[   56.768909] Firmware did not grant requested _OSC control
[   56.785642] acpi_pcihp: acpi_get_hp_hw_control_from_firmware:
Cannot get control of hotplug hardware for pci 0000:00:1c.0
[   56.805022] acpi_pcihp: acpi_get_hp_hw_control_from_firmware:
Trying to get hotplug control for \_SB_.PCIB
[   56.810012] Firmware did not grant requested _OSC control
[   56.827406] acpi_pcihp: acpi_get_hp_hw_control_from_firmware:
Cannot get control of hotplug hardware for pci 0000:80:03.0
[   56.848214] acpi_pcihp: acpi_get_hp_hw_control_from_firmware:
Trying to get hotplug control for \_SB_.PCIB
[   56.867509] Firmware did not grant requested _OSC control
[   56.872287] acpi_pcihp: acpi_get_hp_hw_control_from_firmware:
Cannot get control of hotplug hardware for pci 0000:80:05.0
[   56.890273] pciehp: pcie_port_service_register =3D 0
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
