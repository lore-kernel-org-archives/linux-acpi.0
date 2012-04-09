From: Ang Way Chuang <wcang79@gmail.com>
Subject: Re: ACPI reports critical temperature even the sensors data says otherwise
Date: Mon, 9 Apr 2012 16:51:41 +0800
Message-ID: <CAKJRshmJiFBpvjD2Lm2wBR3AchOdm-mSWuCd8zXK=HCAHvdtKQ@mail.gmail.com>
References: <CAKJRsh=j36WH_e2KvJ6F-e5QWai3BP8YuEQUbGZK2vr1=ciJnA@mail.gmail.com>
	<1333931948.2387.174.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50330 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753548Ab2DIIvm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Apr 2012 04:51:42 -0400
Received: by pbcun15 with SMTP id un15so4795743pbc.19
        for <linux-acpi@vger.kernel.org>; Mon, 09 Apr 2012 01:51:41 -0700 (PDT)
In-Reply-To: <1333931948.2387.174.camel@rui.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org

Thanks. Reported.
https://bugzilla.kernel.org/show_bug.cgi?id=3D43075
It seems like the bug occurs even when bluetooth is disabled. At this
point, I am not sure what triggers the bug.

On 4/9/12, Zhang Rui <rui.zhang@intel.com> wrote:
> On =E5=85=AD, 2012-04-07 at 20:08 +0800, Ang Way Chuang wrote:
>> Hi all,
>>    I am not sure if this is the right mailing list to ask for help. =
I
>> have a Dell Vostro 3350 that I had been using
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> please file a bug report at
> https://bugzilla.kernel.org/enter_bug.cgi?product=3DACPI
> please attach the output of acpidump as well.
>
> thanks,
> rui
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
