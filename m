From: Mahmood Naderan <mahmood.nt@gmail.com>
Subject: Re: BIOS and CPU C_states are strange
Date: Sun, 21 Jun 2009 14:44:16 +0430
Message-ID: <1acba2fa0906210314w528e9a1fie186486b40cd109d@mail.gmail.com>
References: <1acba2fa0906191006i3cd5a035pf18e096fdb92e27e@mail.gmail.com>
	 <1acba2fa0906191007l4b8d5c17id068d868e6178fb8@mail.gmail.com>
	 <a8ca10150906200826l37a7ee2fs283ecfa955697c49@mail.gmail.com>
	 <1acba2fa0906200846r751cf235q9e155e5445090d40@mail.gmail.com>
	 <a8ca10150906201504p2186b3fbg5ac7761946f48697@mail.gmail.com>
	 <1acba2fa0906210218o59a6c92fi86e30891c0816b5d@mail.gmail.com>
	 <1acba2fa0906210220p27b9e902xd640029fa0122b24@mail.gmail.com>
	 <ff05f3d00906210306p6a25687bqfa99b0ae6e0c322a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:45959 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862AbZFUKOP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 21 Jun 2009 06:14:15 -0400
Received: by bwz9 with SMTP id 9so2547558bwz.37
        for <linux-acpi@vger.kernel.org>; Sun, 21 Jun 2009 03:14:16 -0700 (PDT)
In-Reply-To: <ff05f3d00906210306p6a25687bqfa99b0ae6e0c322a@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

hi,
Maybe.... as I asked where is the source code of powertop and what is
the intel utility that you said in windows? Thanks.

--------------------------
*Mahmood Naderan*




On Sun, Jun 21, 2009 at 2:36 PM, Edward Shao<laface.tw@gmail.com> wrote=
:
> Hi~
> In your case, typically C3 should map to CPU C6.
>
> Best Regards,
> Edward
>
> On Sun, Jun 21, 2009 at 5:20 PM, Mahmood Naderan<mahmood.nt@gmail.com=
> wrote:
>> I got more confused... In my first post if you see, BIOS reports C1,
>> C2 and C6. Even it does not support C3 (!), =A0but here is the outpu=
t of
>> "cat /proc/acpi/processor/CPU0/power":
>>
>> active state: =A0 =A0 =A0 =A0 =A0 =A0C0
>> max_cstate: =A0 =A0 =A0 =A0 =A0 =A0 =A0C8
>> bus master activity: =A0 =A0 00000000
>> maximum allowed latency: 2000000000 usec
>> states:
>> =A0 =A0C1: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0type[C1] promotion[--]=
 demotion[--]
>> latency[001] usage[00000063] duration[00000000000000000000]
>> =A0 =A0C2: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0type[C2] promotion[--]=
 demotion[--]
>> latency[001] usage[00017466] duration[00000000000014422985]
>> =A0 =A0C3: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0type[C3] promotion[--]=
 demotion[--]
>> latency[162] usage[00096196] duration[00000000000650582389]
>>
>> So I think something (BIOS or CPU or OS) is malfunctioning and does
>> not report correctly.
>> Now the big question is, will my system (a combination of CPU, BIOS
>> and OS) enter C3 (or even deeper states)?
>>
>> --------------------------
>> *Mahmood Naderan*
>>
>>
>>
>>
>> On Sun, Jun 21, 2009 at 2:34 AM, Ananth Narayan
>> S<ananth.narayan@gmail.com> wrote:
>>> You could see it that way. The OS will use the C states exported by
>>> the BIOS. If C4/C5 are not exported, the OS will not even know that
>>> such states exist. If you query /proc/acpi/CPU*/power, you'll proba=
bly
>>> see just three C states listed (C1, C2, C3). Typically the last
>>> C-state (C3) in that will map to the lowest C-state supported by th=
e
>>> processor.
>>>
>>> -- Ananth
>>>
>>>
>>>
>>>
>>> On Sat, Jun 20, 2009 at 8:46 AM, Mahmood Naderan<mahmood.nt@gmail.c=
om> wrote:
>>>> Hi,
>>>> So if my understanding is correct, the BIOS does not allow the CPU=
 to
>>>> enter C4 and C5 states. Right?
>>>>
>>>> --------------------------
>>>> *Mahmood Naderan*
>>>>
>>>>
>>>>
>>>>
>>>> On Sat, Jun 20, 2009 at 7:56 PM, Ananth Narayan
>>>> S<ananth.narayan@gmail.com> wrote:
>>>>> Intel processors export a max supported c state value. But when i=
t
>>>>> comes to c states, typically the one that provides max power savi=
ngs
>>>>> is exported by the BIOS. The intermediate ones aren't.
>>>>>
>>>>> -- Ananth Narayan S.
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> On Fri, Jun 19, 2009 at 10:07 AM, Mahmood Naderan<mahmood.nt@gmai=
l.com> wrote:
>>>>>> Hi,
>>>>>> I have run powertop with root permission with both AC and batter=
 powers. The
>>>>>> reported C_States are the same and strange:
>>>>>>
>>>>>> mahmood@magma:~$ sudo powertop
>>>>>> PowerTOP 1.11 =A0 (C) 2007, 2008 Intel Corporation
>>>>>>
>>>>>> Collecting data for 5 seconds
>>>>>>
>>>>>> Your CPU supports the following C-states : C1 C2 C3 C4 C5 C6
>>>>>> Your BIOS reports the following C-states : C1 C2 C6
>>>>>>
>>>>>> Where are C4 and C5?
>>>>>>
>>>>>> --------------------------
>>>>>> *Mahmood Naderan*
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe linux-=
acpi" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.=
html
>>>>>>
>>>>>
>>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
>
>
> --
> Best Regards,
> Edward
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
