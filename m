From: huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [RFC PATCH] PCIe: Add PCIe runtime D3cold support
Date: Wed, 18 Apr 2012 09:22:20 +0800
Message-ID: <CAC=cRTOTZ5Y-urtKLAbuyu8y1ttpG74u3AE0J0_eLg8_8C0PHA@mail.gmail.com>
References: <4F8790F6.5080408@intel.com>
	<4F8CD18A.5080903@intel.com>
	<CAC=cRTMk-NTvo+DJ2mAq6_ZeVLbeqiGx+ttZG6Hr_hQyyYkfLw@mail.gmail.com>
	<201204172243.39525.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <201204172243.39525.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>, bhelgaas@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, Lin Ming <ming.m.lin@intel.com>, Zhang Rui <rui.zhang@intel.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 18, 2012 at 4:43 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday, April 17, 2012, huang ying wrote:
>> On Tue, Apr 17, 2012 at 10:12 AM, Yan, Zheng <zheng.z.yan@intel.com>=
 wrote:
>> > On 04/17/2012 01:07 AM, Rafael J. Wysocki wrote:
>> >
>> >> BTW, can you please explain to me what the #WAKE signal is and ho=
w it is
>> >> different from PME#?
>> >
>> > #WAKE signal is triggered by a pin connected to the root complex o=
r other
>> > motherboard logic. PME# is triggered by PME message sent to the po=
rt.
>>
>> PME# is a PCI pin, while WAKE# is a PCI Express pin. =C2=A0In PCI Ex=
press,
>> there is no PME#, PME is delivered between end point device and root
>> port or root complex event collector via PME message, and the PME
>> message will trigger IRQ on root port or root complex event collecto=
r.
>> =C2=A0WAKE# is not used for PCI Express D1, D2 and D3hot, it is just=
 used
>> by D3cold. =C2=A0When remote wakeup detected by end point device, it=
 will
>> assert WAKE# to notify power controller (implemented via ACPI on som=
e
>> platform), then power controller will turn on power for main link,
>> after link goes back to L0, PME message will be sent to root port or
>> root complex event collector by end point device.
>
> OK
>
> So do I understand correctly that the WAKE# signal here is the one de=
scribed
> in Section 5.3.3.2 Link Wakeup of PCI Express Base spec. 2.0?
>
> So what happens is that it triggers a GPE and that GPE has a _Lxx met=
hod
> associated with it, I suppose. =C2=A0Is that correct?

Yes.

Best Regards,
Huang Ying
