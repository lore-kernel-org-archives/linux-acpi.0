From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] ACPICA: use designated initializers
Date: Tue, 4 Apr 2017 08:55:55 -0700
Message-ID: <CAGXu5jKHfOmeM7iHHV8VqXApmjO7MbztTtvs1KT9xTFiC-f1sA@mail.gmail.com>
References: <20161217010425.GA140581@beast> <1AE640813FDE7649BE1B193DEA596E886CDFF348@SHSMSX101.ccr.corp.intel.com>
 <CAGXu5jJk2+_r_72B=yqz9=s=S3VY6v8o7jis7e6YMhy2tSJgHw@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E886CE6BD95@SHSMSX101.ccr.corp.intel.com>
 <CAGXu5j+S28jat1E+wNDE710cQ9qcHnkM12qi3HActrw-imwQGw@mail.gmail.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37E58F104@ORSMSX110.amr.corp.intel.com>
 <CAGXu5jJLQmxEcG6nLKn6fsib5meNpw4y1ZLO2F4ezA+jqF-6DA@mail.gmail.com> <94F2FBAB4432B54E8AACC7DFDE6C92E37E58F7BB@ORSMSX110.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37E58F7BB@ORSMSX110.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "Box, David E" <david.e.box@intel.com>, "Schmauss, Erik" <erik.schmauss@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 4, 2017 at 8:02 AM, Moore, Robert <robert.moore@intel.com> wrot=
e:
>> -----Original Message-----
>> From: keescook@google.com [mailto:keescook@google.com] On Behalf Of Kees
>> Cook
>> Sent: Monday, April 3, 2017 10:29 AM
>> To: Moore, Robert <robert.moore@intel.com>
>> Cc: Zheng, Lv <lv.zheng@intel.com>; linux-kernel@vger.kernel.org;
>> Wysocki, Rafael J <rafael.j.wysocki@intel.com>; Len Brown
>> <lenb@kernel.org>; linux-acpi@vger.kernel.org; devel@acpica.org
>> Subject: Re: [PATCH] ACPICA: use designated initializers
>>
>> On Fri, Mar 31, 2017 at 5:45 PM, Moore, Robert <robert.moore@intel.com>
>> wrote:
>> > Acpica is built with many compilers, even very old ones. It runs on at
>> least 12 known operating systems, and very probably more.
>> >
>> > I'm sorry, but no, we are not going to start adding compiler-specific
>> ifdefs/code in the base ACPICA code.
>> >
>> > I don't care what you do in the Linux-specific or gcc-specific
>> headers, however. If this breaks a customer build, we (you) will hear
>> about it rather quickly.
>>
>> Since the change is specific to the one place ACPICA uses an all-
>> function-pointer structure, I made the change local:
>>
>> https://github.com/acpica/acpica/pull/248
>>
>> would you rather this is in the .h files instead?
>>
>> -Kees
>>
>> --
>> Kees Cook
>> Pixel Security
>
>
>
>
> [Moore, Robert]
>
> I have some questions about this entire issue:
>
> + * Some compilers can handle designated initializers, which is needed
> + * under Linux kernel builds for structures that are entirely function
>   * pointers.
>
> I don't understand why this is coming up now, since ACPICA has been integ=
rated with Linux for something like the last 15 years. It's the "which is n=
eeded under Linux kernel builds" wording that concerns me the most. Are you=
 saying that the ACPICA build for Linux is broken and does not work?

I was trying to avoid being overly Linux-specific in the ACPICA commit
message. More accurately, this is "for future Linux builds using the
structure layout randomization plugin." That plugin will randomize the
layout of manually marked structures and automatically for structures
that are entirely function pointers. (And this acpica structure is one
noticed by the plugin.)

> Further, there are quite a few similar dispatch tables in ACPICA, why are=
 these not a problem?

I can double-check, but I think this was the only one that showed up
in an x86 allyesconfig with the plugin enabled.

FWIW, I've been making these changes in lots of places, not just
ACPICA. ACPICA just has external requirements. :P

$ git log --oneline v4.9..next-20170404 | grep -i "designated initializers"
b3c829193253 reiserfs: use designated initializers
8291798dcf05 TOMOYO: Use designated initializers
f231aebfc4ca rbtree: use designated initializers
c4d27f4b4dc9 [media] solo6x10: use designated initializers
6351db2b4df3 [media] mtk-vcodec: use designated initializers
613e61a0252c drm/amdgpu: use designated initializers
8486adf0d755 apparmor: use designated initializers
7f6856b789ff RDMA/i40iw: use designated initializers
6554c9f7f749 RDMA/nes: use designated initializers
a641261e9998 video: fbdev: matroxfb: use designated initializers
6895aff47170 video: fbdev: sh_mobile_lcdcfb: use designated initializers
54e22bbf11ca staging: comedi: daqboard2000: use designated initializers
5f5fca6db3d3 scsi: cciss: use designated initializers
93380123fbb5 scsi: hpsa: use designated initializers
2fd2434c3f47 staging: lustre: ldlm: use designated initializers
f93a1c9e5e6a ALSA: synth: use designated initializers
2fa70bb9b564 drm/nouveau: use designated initializers
5ca16d8efa66 drm/vmwgfx: use designated initializers
4e98c378a137 drm/ttm: use designated initializers
c92f72370571 drm/ttm: use designated initializers
ffc7dc8d838c x86/floppy: Use designated initializers
e999cb43d51f net/x25: use designated initializers
ebf12f1320c7 isdn: use designated initializers
9751362a4fe7 bna: use designated initializers
aabd7ad94924 WAN: use designated initializers
9d1c0ca5e1d6 net: use designated initializers
99a5e178bde4 ATM: use designated initializers
4794195058b9 isdn/gigaset: use designated initializers


-Kees

--=20
Kees Cook
Pixel Security
