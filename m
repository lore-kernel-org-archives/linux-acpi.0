From: Oleksij Rempel <bug-track@fisher-privat.net>
Subject: Re: [PATCH] ACPI / PCI: Make _SxD/_SxW check follow ACPI 4.0a spec
Date: Mon, 30 Apr 2012 23:30:27 +0200
Message-ID: <4F9F0473.9090408@fisher-privat.net>
References: <Pine.LNX.4.44L0.1204301348180.1558-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1204301348180.1558-100000@iolanthe.rowland.org>
Sender: linux-pci-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Andrey Rahmatullin <wrar@wrar.name>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-acpi@vger.kernel.org

On 30.04.2012 19:53, Alan Stern wrote:
> On Mon, 30 Apr 2012, Bjorn Helgaas wrote:
>=20
>> On Sun, Apr 29, 2012 at 2:44 PM, Rafael J. Wysocki <rjw@sisk.pl> wro=
te:
>>> From: Oleksij Rempel <bug-track@fisher-privat.net>
>>>
>>> This patch makes _SxD/_SxW check follow the ACPI 4.0a specification
>>> more closely and fixes suspend bug found on ASUS Zenbook UX31E.
>>>
>>> Some OEM use _SxD fileds do blacklist brocken Dx states.
>>> If _SxD/_SxW return values are check before suspend as appropriate,
>>> some nasty suspend/resume issues may be avoided.
>>>
>>> References: https://bugzilla.kernel.org/show_bug.cgi?id=3D42728
>>> Signed-off-by: Oleksij Rempel <bug-track@fisher-privat.net>
>>> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
>>> ---
>>>
>>> Bjorn, Len,
>>>
>>> This is -stable material and therefore v3.4 as well, IMO. =EF=BF=BD=
Please let me
>>> know if one of you can take it or whether you want me to handle it =
all the
>>> way to Linus.
>>
>> I'm OK with this from a PCI perspective.  Most of the change is in
>> ACPI, so I propose that either you or Len take care of it.
>>
>> The second paragraph of the changelog has several typos
>> (fileds/fields, do/to, brocken/broken, etc).
>=20
> It also turns out that the normal wakeup mechanism doesn't work for t=
he
> devices in question.  Can this be detected by ACPI?  We don't want to=
=20
> tell userspace that wakeup works when in fact it doesn't.

hm... how about using pci config and acpi together. PCI config provides
map of Dx states and wakeup support of them. If pci says wakeup works
only on D0 and D3 and acpi say - we can use only D2 in S3, then there i=
s
no wakeup.

--=20
Regards,
Oleksij
