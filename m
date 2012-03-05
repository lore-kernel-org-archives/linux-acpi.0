From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: ACPI ALS Status ?
Date: Mon, 5 Mar 2012 10:12:23 +0100
Message-ID: <CAHR064h74hCe6chXskyT=C+PpQbJ9z2+RYHERoFoYzw9QgzsBA@mail.gmail.com>
References: <CAHR064iRm37Wf4QrYEOvsxT0=wZZbY1XQiZfmrJdqyTj1h8sPA@mail.gmail.com>
	<CAJvTdKnW9VESyiF7Rden698EvRgT=805hyKXtXhFpKkTxLv64w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33833 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756344Ab2CEJMY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Mar 2012 04:12:24 -0500
Received: by bkcik5 with SMTP id ik5so2900639bkc.19
        for <linux-acpi@vger.kernel.org>; Mon, 05 Mar 2012 01:12:23 -0800 (PST)
In-Reply-To: <CAJvTdKnW9VESyiF7Rden698EvRgT=805hyKXtXhFpKkTxLv64w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, Pavel Machek <pavel@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>

On Sun, Nov 6, 2011 at 11:16 PM, Len Brown <lenb@kernel.org> wrote:
>> I was looking at the DSDT of a new samsung laptop (I can send you the
>> output of acpidump if interested), and it export a standard ACPI ALS
>> device. So, it's actually great to see vendor using that, but it seems
>> that the series adding support for that and sent back in 2009 is not
>> available in the kernel. I'd really like to use my the ALS, what's the
>> current status of the driver ? Still blocked because we don't have a
>> generic sysfs class ? If yes, can't we just use a non-standard
>> interface ? It would still be better than no driver at all.
>
> Yes, I think ACPI ALS support has been waiting for hardware to justify
> its existence.
>
> When it first entered the spec, we were excited to see it was present
> in some high-end laptops, but IIR on closer examination the AML turned
> out to be dummy code.
>
> If you can verify that your Samsung really does implement ACPI ALS,
> then that is all we need to stumble forward.
>
> thanks,
> -Len Brown, Intel Open Source Technology Center

Hello,

As stated in my previous mails, the implementation on this laptop is
perfectly functional,  and since Windows 7 seems to be able to use
ACPI ALS nativelly [1] I suspect new (high end ?) laptop will all
support that.
Is there any plan to revive this driver for 3.4 or 3.5 ? Should
someone repost the last version of the previous patchset for
discussion ?
And no, on this laptop ALS is definitively not a gadget.

Thanks,

- http://download.microsoft.com/download/3/0/2/3027D574-C433-412A-A8B6-5E0A75D5B237/ambient-light-sensors.docx

-- 
Corentin Chary
http://xf.iksaif.net
