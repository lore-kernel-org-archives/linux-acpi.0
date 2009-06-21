From: Mahmood Naderan <mahmood.nt@gmail.com>
Subject: Re: BIOS and CPU C_states are strange
Date: Sun, 21 Jun 2009 14:56:07 +0430
Message-ID: <1acba2fa0906210326l40f6fc44h7e928036b57a0160@mail.gmail.com>
References: <1acba2fa0906191006i3cd5a035pf18e096fdb92e27e@mail.gmail.com>
	 <1acba2fa0906191007l4b8d5c17id068d868e6178fb8@mail.gmail.com>
	 <ff05f3d00906191956m48655da5wc28a5553220ffdd0@mail.gmail.com>
	 <1acba2fa0906192354i3cb0f2dbp2c8abed6704db3f@mail.gmail.com>
	 <ff05f3d00906210249j6286e6cfw5fff9535e02839e0@mail.gmail.com>
	 <1acba2fa0906210302x19c31974md75c72b7a171c852@mail.gmail.com>
	 <ff05f3d00906210313g6a4c5fbarebcdfd4ab35921d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:44814 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbZFUK0H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 21 Jun 2009 06:26:07 -0400
Received: by bwz9 with SMTP id 9so2550763bwz.37
        for <linux-acpi@vger.kernel.org>; Sun, 21 Jun 2009 03:26:08 -0700 (PDT)
In-Reply-To: <ff05f3d00906210313g6a4c5fbarebcdfd4ab35921d2@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,
Thanks. Can I expect future versions of powertop will consider my
problem or it is a specific bug related to my BIOS (my laptop is HP
Pavilion DV2000)? I mean, this misreading is a bug in powertop or not?

--------------------------
*Mahmood Naderan*




On Sun, Jun 21, 2009 at 2:43 PM, Edward Shao<laface.tw@gmail.com> wrote=
:
> Hi~
> powertop can download from
> http://www.lesswatts.org/projects/powertop/download/powertop-1.11.tar=
=2Egz
>
> Sorry~I forgot the name of Intel utility.
>
> Best Regards,
> Edward
>
> On Sun, Jun 21, 2009 at 6:02 PM, Mahmood Naderan<mahmood.nt@gmail.com=
> wrote:
>> Hi,
>> 1- where can I find powertop source code?
>> 2- what is the name of intel utility in windows as you said?
>> --------------------------
>> *Mahmood Naderan*
>>
>>
>>
>>
>> On Sun, Jun 21, 2009 at 2:19 PM, Edward Shao<laface.tw@gmail.com> wr=
ote:
>>> Hi~
>>> It's all depended on how utility to interpret raw information (both
>>> information reported by CPU or BIOS).
>>> You can check source code of powertop for detail information.
>>> For BIOS part, powertop checks value of mwait hint register reporte=
d
>>> by ACPI _CST method.
>>>
>>> As my experience, powertop will cause a misleading sometimes,
>>> especially for new Intel CPU.
>>> For example:
>>> BIOS engineer said they followed Intel BIOS porting guide to report=
 an
>>> accuracy C-state (C6) information via ACPI _CST method.
>>> However powertop said BIOS only reports C3. (but Intel utility unde=
r
>>> Windows said CPU can enter C6).
>>>
>>> Best Regards,
>>> Edward
>>>
>>> On Sat, Jun 20, 2009 at 2:54 PM, Mahmood Naderan<mahmood.nt@gmail.c=
om> wrote:
>>>> Hi,
>>>>> Only simple check value of edx.
>>>>> Well, unless CPU uses CPUID.5.EDX[31:20], the reserved area.
>>>>
>>>> You mean that powertop is not correctly reading the states? Do you
>>>> mean that the BIOS reports better that the CPU ?
>>>>
>>>> --------------------------
>>>> *Mahmood Naderan*
>>>>
>>>>
>>>>
>>>> On Sat, Jun 20, 2009 at 7:26 AM, Edward Shao <laface.tw@gmail.com>=
 wrote:
>>>>>
>>>>> Hi Mahmood,
>>>>>
>>>>> So far as I know, if your CPU is Intel, powertop maybe cause a mi=
sleading.
>>>>> Powertop uses CPUID.5.EDX to check CPU supported C states.
>>>>> According Intel's spec (Intel Processor Identification and the CP=
UID
>>>>> Instruction (Application Note 485), a CPU only has
>>>>>
>>>>> C0, C1, C2, C3, C4 (prior Core i7)
>>>>> C0, C1, C2, C6, C7 (Core i7 and subsequent)
>>>>>
>>>>> Check with source code of powertop
>>>>> while (edx) {
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (edx&7)
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf("C%i ", i);
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0edx =3D edx >> 4;
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i++;
>>>>> =A0 =A0 =A0 =A0}
>>>>> Only simple check value of edx.
>>>>> Well, unless CPU uses CPUID.5.EDX[31:20], the reserved area.
>>>>>
>>>>> Ps: I does not check AMD's spec.
>>>>>
>>>>> Best Regards,
>>>>> Edward
>>>>>
>>>>>
>>>>> On Sat, Jun 20, 2009 at 1:07 AM, Mahmood Naderan<mahmood.nt@gmail=
=2Ecom> wrote:
>>>>> > Hi,
>>>>> > I have run powertop with root permission with both AC and batte=
r powers. The
>>>>> > reported C_States are the same and strange:
>>>>> >
>>>>> > mahmood@magma:~$ sudo powertop
>>>>> > PowerTOP 1.11 =A0 (C) 2007, 2008 Intel Corporation
>>>>> >
>>>>> > Collecting data for 5 seconds
>>>>> >
>>>>> > Your CPU supports the following C-states : C1 C2 C3 C4 C5 C6
>>>>> > Your BIOS reports the following C-states : C1 C2 C6
>>>>> >
>>>>> > Where are C4 and C5?
>>>>> >
>>>>> > --------------------------
>>>>> > *Mahmood Naderan*
>>>>> > --
>>>>> > To unsubscribe from this list: send the line "unsubscribe linux=
-acpi" in
>>>>> > the body of a message to majordomo@vger.kernel.org
>>>>> > More majordomo info at =A0http://vger.kernel.org/majordomo-info=
=2Ehtml
>>>>> >
>>>>>
>>>>>
>>>>>
>>>>> --
>>>>> Best Regards,
>>>>> Edward
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-ac=
pi" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>>>>
>>>
>>>
>>>
>>> --
>>> Best Regards,
>>> Edward
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
