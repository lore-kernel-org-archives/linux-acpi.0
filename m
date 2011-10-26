From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: kernel panic
Date: Wed, 26 Oct 2011 12:10:07 -0600
Message-ID: <CAErSpo4_epbHEAH3Ah=07NZFjqQedUcMXh+cxTSJ4Mp9KhvfPw@mail.gmail.com>
References: <4EA549C3.4080206@ntlworld.com> <CAErSpo4EtfhnhWGpahk-NfMUVEizZSk3igZ+Vy7x=+hY5b0bcw@mail.gmail.com>
 <CAJvTdKmeEGVz8fXhaoFUOCtMM4bufTraTvztrf93880a1sVqKw@mail.gmail.com>
 <CAErSpo79nWTdqvmLACMfJp3WW00k7cD_zkGtkE1BunOxkNowxw@mail.gmail.com>
 <4EA82832.2070201@ntlworld.com> <CAErSpo6-KdbaaF1ZX8yL+aKO9ERr9xv7Dquvwo5_7yH_e7mSyw@mail.gmail.com>
 <4EA83F5D.20001@ntlworld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:2331 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755038Ab1JZSKa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Oct 2011 14:10:30 -0400
Received: from wpaz5.hot.corp.google.com (wpaz5.hot.corp.google.com [172.24.198.69])
	by smtp-out.google.com with ESMTP id p9QIATsQ027535
	for <linux-acpi@vger.kernel.org>; Wed, 26 Oct 2011 11:10:29 -0700
Received: from qyk7 (qyk7.prod.google.com [10.241.83.135])
	by wpaz5.hot.corp.google.com with ESMTP id p9QIAR3M021902
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 26 Oct 2011 11:10:28 -0700
Received: by qyk7 with SMTP id 7so2890836qyk.11
        for <linux-acpi@vger.kernel.org>; Wed, 26 Oct 2011 11:10:27 -0700 (PDT)
In-Reply-To: <4EA83F5D.20001@ntlworld.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: nick bray <nick.bray1@ntlworld.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org, Zhao Yakui <yakui.zhao@intel.com>, Zhang Rui <rui.zhang@intel.com>, Thomas Renninger <trenn@suse.de>

On Wed, Oct 26, 2011 at 11:11 AM, nick bray <nick.bray1@ntlworld.com> w=
rote:
> On 26/10/11 17:18, Bjorn Helgaas wrote:
>>
>> On Wed, Oct 26, 2011 at 9:33 AM, nick bray<nick.bray1@ntlworld.com>
>> =A0wrote:
>>>
>>> On 26/10/11 15:53, Bjorn Helgaas wrote:
>>>>
>>>> On Wed, Oct 26, 2011 at 4:00 AM, Len Brown<lenb417@gmail.com> =A0 =
=A0wrote:
>>>>>>>
>>>>>>> =A0after upgrading to linux kernel 3.xx I get kernel panic on b=
oot
>>>>>>> unless
>>>>>>> I
>>>>>>> use ACPI=3Doff in the boot parameters this happens with both Ub=
untu
>>>>>>> 11.10
>>>>>>> and
>>>>>>> Fedora 16. The mainboard is an Intel S875WP1-E running a Pentui=
m 4
>>>>>>> 3ghz
>>>>>>> with
>>>>>>> 3gig RAM in single-channel mode. I have performed a Bios upgrad=
e just
>>>>>>> in
>>>>>>> case tha ACPI tables were corrupt but it makes no difference.
>>>>>>> Currently
>>>>>>> running 2.6.38-11-generic #50-Ubuntu SMP (Linux Mint) with no i=
ssues.
>>>>>
>>>>> Is this problem new in 3.1, or is it also present in 2.6.39 or 3.=
0?
>>>>>
>>>>> Also, do any other cmdline parmaters besides acpi=3Doff work-arou=
nd it?
>>>>> pci=3Dnoacpi
>>>>> maxcpus=3D1
>>>>>
>>>>> etc.
>>>>
>>>> Please keep all the cc's when responding. =A0Saves you work, saves=
 us work
>>>> :)
>>>>
>>>> Summary of what I think you're seeing (please correct if wrong):
>>>>
>>>> 2.6.38 (Ubuntu/Mint): works fine, even with no boot args
>>>> 2.6.38 (Fedora 15): works fine, even with no boot args
>>>> 2.6.40? (Fedora 15 with upgraded kernel): requires "acpi=3Doff" to=
 boot
>>>> 3.0.0-12 (Ubuntu/Mint): requires "acpi=3Doff" or "maxcpus=3D1" to =
boot.
>>>> "pci=3Dnoacpi" makes no difference. =A0with no arguments, panics a=
s in
>>>> attached screenshot.
>>>> 3.1.0-0.rc6 (Fedora 16 live CD): can't find root device, drops to
>>>> debug shell, even with "maxcpus=3D1"
>>>>
>>>> Let's focus on Ubuntu and forget Fedora for now.
>>>>
>>>> The screenshot you sent (attached) has a clue ("EIP: [<00000000>] =
0x0
>>>> SS:ESP 007b:00000046 CR2: 00000000ffffffff, Fatal exception in
>>>> interrupt") but doesn't really have enough context. =A0I should ha=
ve
>>>> suggested booting with "vga=3D0xf07". =A0That will use a smaller f=
ont, so
>>>> the photo can capture more information. =A0Can you try that? =A0Yo=
u might
>>>> have to use a lower jpg quality setting or resave with gimp at a l=
ow
>>>> quality setting to make the size 100K or less for the mailing list=
s.
>>>>
>>>> If you can boot 3.0.0-12 with "maxcpus=3D1", collect the dmesg log=
 and
>>>> maybe we can compare it with the new "vga=3D0xf07" screenshot.
>>>
>>> =A0 =A0 =A0 =A0 =A0 =A0your summary is correct. Please see new scre=
enshot taken with
>>> a
>>> better camera with the light off! Also I have resized it to>100k =A0=
Though
>>> I
>>> can't see a difference in the txt size even though I used vga=3D0xf=
07. also
>>> attached dmesg from Ubuntu 11.10 with maxcpus=3D1. Thank you for th=
e time
>>> and
>>> interest. :)
>>
>> Please use reply-all... it saves work for everybody!
>>
>> Dunno why vga=3D doesn't do anything. =A0But this panic is different=
 from
>> the first (and probably more useful). =A0Looks like this problem mig=
ht
>> be in the acpi_processor_add() path, which might explain why
>> "maxcpus=3D1" makes a difference.
>>
>> I added cc: to a few people who have recently changed the ACPI proce=
ssor
>> driver.
>>
>> Are you able to build test kernels yourself? =A0If so, you could
>> sprinkle printks() in acpi_processor_add(), maybe with some
>> mdelay(100) calls to slow things down.
>>
>> There's also a "boot_delay=3D" parameter that supposedly slows down =
boot
>> printks. =A0I haven't had much luck with it myself, but "boot_delay=3D=
100"
>> or so might allow you to get more snapshots of the beginning of the
>> stacktrace.
>>
>> Bjorn
>
> ok reply all it is, I'm sorry I've never needed to report something l=
ike
> this before. I've been using Linux now for around 10 years and consid=
er
> myself reasonably competent at configuration and suchlike but never
> successfully built a kernel (I'm not a coder/programmer), something t=
ells me
> that now is probably not a good time to try. ;)
>
> anyway here is a whole bunch of jpegs taken with boot_delay=3D100 I'm=
 afraid
> they're not contiguous as some of they were too blurred to bother sen=
ding. I
> hope the info is useful.

Perfect, thanks!  Manual transcription of the interesting parts:

=2E..
Brought up 2 CPUs
=2E..
ACPI: Power Button [PWRF]
BUG: unable to handle kernel paging request at 00010282
IP: [<00010282>] 0x10281
*pde =3D 00000000
Oops: 0000 [#1] SMP
=2E..
Pid: 1, comm: swapper Not tainted 3.0.0-12-generic #20-Ubuntu
EIP: 0060:[<00010282>] EFLAGS: 00010282 CPU: 1
=2E..
  ? resched_task+0x22/0x70
  ? __kmalloc+0x189/0x1e0
  acpi_ns_evaluate+0x3a/0x18d
  acpi_evaluate_object+0xd6/0x1c5
  ? try_to_wake_up+0x140/0x190
  acpi_processor_get_power_info_cst+0x53/0x297
  ? wait_for_completion+0x17/0x20
  ? default_spin_lock_flags+0x8/0x10
  ? _raw_spin_lock+0xd/0x10
  ? task_rq_lock+0x49/0x80
  ? set_cpus_allowed_ptr+0x53/0x110
  ? acpi_processor_get_throttling_fadt+0x72/0x7a
  acpi_processor_get_power_info+0x24/0x10c
  acpi_processor_power_init+0xdc/0x10c
  acpi_processor_add+0x131/0x1d2
  acpi_device_probe+0x41/0xf5

I found a report with a serial console log showing a very similar
backtrace here:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/807164

Seems pretty clearly related to acpi_processor_get_power_info();
hopefully an expert in that area will jump in and help out.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
