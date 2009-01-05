From: =?UTF-8?B?TsOpbWV0aCBNw6FydG9u?= <nm127@freemail.hu>
Subject: Re: AE_ERROR, ACPI thermal trip point state changed
Date: Mon, 05 Jan 2009 07:22:33 +0100
Message-ID: <4961A729.8060406@freemail.hu>
References: <47CF96E2.9020302@freemail.hu>	 <1204757373.10256.179.camel@acpi-hp-zz.sh.intel.com>	 <823A93EED437D048963A3697DB0E35DE0129BB78@pdsmsx414.ccr.corp.intel.com>	 <47D0E694.5050102@freemail.hu>	 <1204874686.10256.185.camel@acpi-hp-zz.sh.intel.com>	 <47D24341.5070908@freemail.hu>	 <1205113940.10256.191.camel@acpi-hp-zz.sh.intel.com>	 <48ABDF1E.3010101@freemail.hu> <8763pwypf5.fsf@basil.nowhere.org>	 <49249121.6050304@freemail.hu> <20081119232224.GR6703@one.firstfloor.org>	 <493CB8DB.8070105@freemail.hu> <1228718909.7929.133.camel@rzhang-dt> <493CC5CC.70309@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753454AbZAEGWw@vger.kernel.org>
In-Reply-To: <493CC5CC.70309@freemail.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Andi Kleen <andi@firstfloor.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

N=C3=A9meth M=C3=A1rton =C3=ADrta:
> Zhang Rui wrote:
>> On Mon, 2008-12-08 at 14:04 +0800, N=C3=A9meth M=C3=A1rton wrote:
>>> Andi Kleen wrote:
>>>> On Wed, Nov 19, 2008 at 11:20:17PM +0100, N=C3=A9meth M=C3=A1rton =
wrote:
>>>>> Hi,
>>>>>
>>>>> Andi Kleen wrote:
>>>>>> N=C3=A9meth M=C3=A1rton <nm127@freemail.hu> writes:
>>>>>>> As of 2.6.27-rc3 the patch is still not included in the mainstr=
eam. I
>>>>>>> hope that this patch was not forgotten completely.
>>>>>> It's already in Linus' tree, will be in rc4.
>>>>> I compiled and tried 2.6.28-rc5. In the dmesg I get the following=
 message:
>>>>>
>>>>> [   63.589603] ACPI Exception (thermal-0538): AE_ERROR, ACPI ther=
mal trip point state changed
>>>>> [   63.589669] Please send acpidump to linux-acpi@vger.kernel.org
>>>>> [   63.589805]  [20080926]
>>>>>
>>>>> The original patch still applies for 2.6.28-rc5 (with some offset=
s). This patch
>>>>> is not included in 2.6.28-rc5, yet. The "AE_ERROR..." message doe=
s not appear
>>>>> any more if I apply the patch. I attached this original patch for=
 easier reference.
>>>> Hmm sorry I must have confused it with some other patch back then.
>>>> Anyways Len Brown is handling ACPI again now, so he'll have to sor=
t
>>>> it out. cc'ed (the original patch is on linux-acpi)
>>> This is just a status report about 2.6.28-rc7, nothing more. The AE=
_ERROR
>>> message is still in the dmesg. The patch still solves the problem.
>>>
>> do you mean this patch:
>> http://marc.info/?l=3Dlinux-acpi&m=3D120522267418715&w=3D2
>=20
> Yes, exactly.

Status report: the mentioned patch is not yet included in 2.6.28.

Regards,

	M=C3=A1rton N=C3=A9meth
