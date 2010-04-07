From: "Justin P. mattock" <justinmattock@gmail.com>
Subject: Re: system does not power off - how to debug?
Date: Wed, 07 Apr 2010 06:30:28 -0700
Message-ID: <4BBC88F4.3080406@gmail.com>
References: <4BBC2E3E.40308@maroy.hu> <4BBC30B3.1000209@gmail.com> <4BBC7998.5080106@maroy.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4BBC7998.5080106@maroy.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?w4Frb3MgTWFyw7N5?= <akos@maroy.hu>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 04/07/2010 05:24 AM, =C3=81kos Mar=C3=B3y wrote:
> Justin,
>
>> Since this issue seems easily reproducible
>> the best way to find the issue is through
>> a bisect(hardest part is finding the last
>> good kernel),
>> http://www.kernel.org/pub/software/scm/git/docs/user-manual.html
>>
>> hope this helps,
>
> hm, but wouldn't this assume that there is a kernel version, which
> actually works?
>
>
> Akos
>
>


nice!!, so there never was a good kernel version.
In this case I guess the right question is, is
what/where is the shutdown mechanism(in the kernel)
responsible for this and if possible is there already
some mechanism in place for this machine with this issue
i.g. I had to add my machines dmi info to reboot.c
in order for it to reboot properly.

Now keep in mind this could have nothing todo with
adding some dmi entry, this could somewhere else
(which the bisect could reveal(hopefully)).

as for debugging I normally use ohci1394_dma=3Dearly
you might be able to catch some strace towards the end
with this.


Justin P. Mattock
