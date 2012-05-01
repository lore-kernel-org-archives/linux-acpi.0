From: "Oleksij Rempel (fishor)" <bug-track@fisher-privat.net>
Subject: Re: [PATCH] ACPI / PCI: Make _SxD/_SxW check follow ACPI 4.0a spec
Date: Tue, 01 May 2012 08:38:46 +0200
Message-ID: <4F9F84F6.7000509@fisher-privat.net>
References: <Pine.LNX.4.44L0.1204301348180.1558-100000@iolanthe.rowland.org> <4F9F0473.9090408@fisher-privat.net> <201204302343.35215.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <201204302343.35215.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Andrey Rahmatullin <wrar@wrar.name>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-acpi@vger.kernel.org

On 30.04.2012 23:43, Rafael J. Wysocki wrote:
> On Monday, April 30, 2012, Oleksij Rempel wrote:
>> On 30.04.2012 19:53, Alan Stern wrote:
>>> On Mon, 30 Apr 2012, Bjorn Helgaas wrote:
>>>
>>>> On Sun, Apr 29, 2012 at 2:44 PM, Rafael J. Wysocki<rjw@sisk.pl>  w=
rote:
>>>>> From: Oleksij Rempel<bug-track@fisher-privat.net>
>>>>>
>>>>> This patch makes _SxD/_SxW check follow the ACPI 4.0a specificati=
on
>>>>> more closely and fixes suspend bug found on ASUS Zenbook UX31E.
>>>>>
>>>>> Some OEM use _SxD fileds do blacklist brocken Dx states.
>>>>> If _SxD/_SxW return values are check before suspend as appropriat=
e,
>>>>> some nasty suspend/resume issues may be avoided.
>>>>>
>>>>> References: https://bugzilla.kernel.org/show_bug.cgi?id=3D42728
>>>>> Signed-off-by: Oleksij Rempel<bug-track@fisher-privat.net>
>>>>> Signed-off-by: Rafael J. Wysocki<rjw@sisk.pl>
>>>>> ---
>>>>>
>>>>> Bjorn, Len,
>>>>>
>>>>> This is -stable material and therefore v3.4 as well, IMO. =EF=BF=BD=
Please let me
>>>>> know if one of you can take it or whether you want me to handle i=
t all the
>>>>> way to Linus.
>>>>
>>>> I'm OK with this from a PCI perspective.  Most of the change is in
>>>> ACPI, so I propose that either you or Len take care of it.
>>>>
>>>> The second paragraph of the changelog has several typos
>>>> (fileds/fields, do/to, brocken/broken, etc).
>>>
>>> It also turns out that the normal wakeup mechanism doesn't work for=
 the
>>> devices in question.  Can this be detected by ACPI?  We don't want =
to
>>> tell userspace that wakeup works when in fact it doesn't.
>>
>> hm... how about using pci config and acpi together. PCI config provi=
des
>> map of Dx states and wakeup support of them. If pci says wakeup work=
s
>> only on D0 and D3 and acpi say - we can use only D2 in S3, then ther=
e is
>> no wakeup.
>
> Not really.  ACPI trumps PCI here, so if ACPI says we can use D2 in S=
3,
> then we can.
>
> ACPI device states are not the same as PCI device states.  They usual=
ly map
> to each other directly, but they don't have to.

I mean not just the mapping.
I mean PCI:PME_SUP field.  If it PME(D0+,D1-,D2-,D3hot+,D3cold+), and=20
acpi trying to avoid D3 states for this device. then is is same like=20
PME(D0+,D1-,D2-)? Or not?

According to spec.:
7.2 Device Power Management Objects (page 287)
_S3D - Highest D-state supported by the device in the S3 state
_S3W - Lowest D-state supported by the device in the S3 state which can=
=20
wake the system.
by definition if _S3W is specified then we can assume, the device can=20
wake? But _SxW is not defined.

Are there any other method to forbid the system use broken state, after=
=20
device was actually produced? Usual BIOS flash utility will probably no=
=20
rewrite the PCIs EEPROM. Only hope is ACPI, what is correct method to d=
o=20
define it by ACPI?
