From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: ACPI ALS Status ?
Date: Sun, 20 May 2012 15:09:57 +0200
Message-ID: <CAHR064h4bed0koP--TcJkogMcF_fMYm0dXV74q_jSbuDd98qSQ@mail.gmail.com>
References: <CAHR064iRm37Wf4QrYEOvsxT0=wZZbY1XQiZfmrJdqyTj1h8sPA@mail.gmail.com>
	<CAJvTdKnW9VESyiF7Rden698EvRgT=805hyKXtXhFpKkTxLv64w@mail.gmail.com>
	<CAHR064h74hCe6chXskyT=C+PpQbJ9z2+RYHERoFoYzw9QgzsBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:34731 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754421Ab2ETNKA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 20 May 2012 09:10:00 -0400
Received: by bkcji2 with SMTP id ji2so3291311bkc.19
        for <linux-acpi@vger.kernel.org>; Sun, 20 May 2012 06:09:57 -0700 (PDT)
In-Reply-To: <CAHR064h74hCe6chXskyT=C+PpQbJ9z2+RYHERoFoYzw9QgzsBA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>
Cc: Pavel Machek <pavel@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>, Jonathan Cameron <jic23@cam.ac.uk>, Amit Kucheria <amit.kucheria@verdurent.com>, Jean Delvare <khali@linux-fr.org>

On Mon, Mar 5, 2012 at 10:12 AM, Corentin Chary
<corentin.chary@gmail.com> wrote:
> On Sun, Nov 6, 2011 at 11:16 PM, Len Brown <lenb@kernel.org> wrote:
>>> I was looking at the DSDT of a new samsung laptop (I can send you t=
he
>>> output of acpidump if interested), and it export a standard ACPI AL=
S
>>> device. So, it's actually great to see vendor using that, but it se=
ems
>>> that the series adding support for that and sent back in 2009 is no=
t
>>> available in the kernel. I'd really like to use my the ALS, what's =
the
>>> current status of the driver ? Still blocked because we don't have =
a
>>> generic sysfs class ? If yes, can't we just use a non-standard
>>> interface ? It would still be better than no driver at all.
>>
>> Yes, I think ACPI ALS support has been waiting for hardware to justi=
fy
>> its existence.
>>
>> When it first entered the spec, we were excited to see it was presen=
t
>> in some high-end laptops, but IIR on closer examination the AML turn=
ed
>> out to be dummy code.
>>
>> If you can verify that your Samsung really does implement ACPI ALS,
>> then that is all we need to stumble forward.
>>
>> thanks,
>> -Len Brown, Intel Open Source Technology Center
>
> Hello,
>
> As stated in my previous mails, the implementation on this laptop is
> perfectly functional, =C2=A0and since Windows 7 seems to be able to u=
se
> ACPI ALS nativelly [1] I suspect new (high end ?) laptop will all
> support that.
> Is there any plan to revive this driver for 3.4 or 3.5 ? Should
> someone repost the last version of the previous patchset for
> discussion ?
> And no, on this laptop ALS is definitively not a gadget.
>
> Thanks,
>
> - http://download.microsoft.com/download/3/0/2/3027D574-C433-412A-A8B=
6-5E0A75D5B237/ambient-light-sensors.docx

Adding more people that were interested in the previous discussion.
What was the exact status of the als class ? Rui Zhang are you still
interested in this ?
Thanks,

--=20
Corentin Chary
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
