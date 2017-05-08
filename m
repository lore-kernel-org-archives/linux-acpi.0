From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] ACPICA: use designated initializers
Date: Mon, 8 May 2017 13:05:33 -0700
Message-ID: <CAGXu5jKq5VeizqcQYEtW7d97X=RffNr-AfpaquShvuT++0cEiQ@mail.gmail.com>
References: <20161217010425.GA140581@beast> <1AE640813FDE7649BE1B193DEA596E886CDFF348@SHSMSX101.ccr.corp.intel.com>
 <CAGXu5jJk2+_r_72B=yqz9=s=S3VY6v8o7jis7e6YMhy2tSJgHw@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E886CE6BD95@SHSMSX101.ccr.corp.intel.com>
 <CAGXu5j+S28jat1E+wNDE710cQ9qcHnkM12qi3HActrw-imwQGw@mail.gmail.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37E58F104@ORSMSX110.amr.corp.intel.com>
 <CAGXu5jJLQmxEcG6nLKn6fsib5meNpw4y1ZLO2F4ezA+jqF-6DA@mail.gmail.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37E58F7BB@ORSMSX110.amr.corp.intel.com> <CAGXu5jKHfOmeM7iHHV8VqXApmjO7MbztTtvs1KT9xTFiC-f1sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:34641 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755527AbdEHUFg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 May 2017 16:05:36 -0400
Received: by mail-io0-f170.google.com with SMTP id k91so57546859ioi.1
        for <linux-acpi@vger.kernel.org>; Mon, 08 May 2017 13:05:35 -0700 (PDT)
In-Reply-To: <CAGXu5jKHfOmeM7iHHV8VqXApmjO7MbztTtvs1KT9xTFiC-f1sA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "Box, David E" <david.e.box@intel.com>, "Schmauss, Erik" <erik.schmauss@intel.com>

On Tue, Apr 4, 2017 at 8:55 AM, Kees Cook <keescook@chromium.org> wrote:
> On Tue, Apr 4, 2017 at 8:02 AM, Moore, Robert <robert.moore@intel.com> wr=
ote:
>>> -----Original Message-----
>>> From: keescook@google.com [mailto:keescook@google.com] On Behalf Of Kee=
s
>>> Cook
>>> Sent: Monday, April 3, 2017 10:29 AM
>>> To: Moore, Robert <robert.moore@intel.com>
>>> Cc: Zheng, Lv <lv.zheng@intel.com>; linux-kernel@vger.kernel.org;
>>> Wysocki, Rafael J <rafael.j.wysocki@intel.com>; Len Brown
>>> <lenb@kernel.org>; linux-acpi@vger.kernel.org; devel@acpica.org
>>> Subject: Re: [PATCH] ACPICA: use designated initializers
>>>
>>> On Fri, Mar 31, 2017 at 5:45 PM, Moore, Robert <robert.moore@intel.com>
>>> wrote:
>>> > Acpica is built with many compilers, even very old ones. It runs on a=
t
>>> least 12 known operating systems, and very probably more.
>>> >
>>> > I'm sorry, but no, we are not going to start adding compiler-specific
>>> ifdefs/code in the base ACPICA code.
>>> >
>>> > I don't care what you do in the Linux-specific or gcc-specific
>>> headers, however. If this breaks a customer build, we (you) will hear
>>> about it rather quickly.
>>>
>>> Since the change is specific to the one place ACPICA uses an all-
>>> function-pointer structure, I made the change local:
>>>
>>> https://github.com/acpica/acpica/pull/248
>>>
>>> would you rather this is in the .h files instead?
>>>
>>> -Kees
>>>
>>> --
>>> Kees Cook
>>> Pixel Security
>>
>>
>>
>>
>> [Moore, Robert]
>>
>> I have some questions about this entire issue:
>>
>> + * Some compilers can handle designated initializers, which is needed
>> + * under Linux kernel builds for structures that are entirely function
>>   * pointers.
>>
>> I don't understand why this is coming up now, since ACPICA has been inte=
grated with Linux for something like the last 15 years. It's the "which is =
needed under Linux kernel builds" wording that concerns me the most. Are yo=
u saying that the ACPICA build for Linux is broken and does not work?
>
> I was trying to avoid being overly Linux-specific in the ACPICA commit
> message. More accurately, this is "for future Linux builds using the
> structure layout randomization plugin." That plugin will randomize the
> layout of manually marked structures and automatically for structures
> that are entirely function pointers. (And this acpica structure is one
> noticed by the plugin.)

Here is the merge request in upstream ACPICA. Can anyone re-review it?

https://github.com/acpica/acpica/pull/248/

Thanks!

-Kees

--=20
Kees Cook
Pixel Security
