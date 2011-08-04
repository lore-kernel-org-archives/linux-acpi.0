From: Andrew Lutomirski <luto@mit.edu>
Subject: Re: [PATCH 2/2] x86: Enable monitor/mwait on Intel if BIOS hasn't already
Date: Wed, 3 Aug 2011 23:18:32 -0400
Message-ID: <CAObL_7HZ_8tSfKCpoKN68O1OJczCW+dOEhRiVu-zVwWOFHj1ew@mail.gmail.com>
References: <cover.1312386029.git.luto@mit.edu> <5bec80947da3fb72f2f18fbe6d924a69f83fbed9.1312386029.git.luto@mit.edu>
 <alpine.LFD.2.02.1108031214470.22067@x980> <CAObL_7GuAmzyjo5AmYxbTeiAqFtVk1N+opzWEzwJu8Mgrvts7g@mail.gmail.com>
 <CAObL_7FNa20Hsd0v-hs1vz=ejnkdaT+Yr=wwM681GbZJiuLkMQ@mail.gmail.com> <alpine.LFD.2.02.1108031514550.22067@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:42966 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755018Ab1HDDSw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Aug 2011 23:18:52 -0400
In-Reply-To: <alpine.LFD.2.02.1108031514550.22067@x980>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>, linux-acpi@vger.kernel.org

On Wed, Aug 3, 2011 at 3:17 PM, Len Brown <lenb@kernel.org> wrote:
>> >> What machine has this BIOS bug, and are you running
>> >> the latest version of the BIOS?
>> >
>> > Intel DQ67SW, version SWQ6710H.86A.0051.2011.0413.1154. =A0This is=
 not
>> > quite up-to-date -- I'll test a newer BIOS.
>>
>> SWQ6710H.86A.0053.2011.0615.1535 has the same problem. =A0It fixed A=
SPM, though :)
>>
>> Should I redo the patch with a printk to warn about the firmware bug=
?
>
> I would hope that a patch that _only_ prints [Firmware bug]
> should be enough. =A0This isn't the kind of workaround
> that we should really have to carry in the kernel.
>
> This is still a very new platform, and my guess is that
> they are actively updating the BIOS as we speak.
> I'll see if I can figure out who to talk to
> in order to make sure of that:-)

I can add a strange data point:  with TXT enabled in BIOS, fast
strings are disabled (on all CPUs, I think) and monitor/mwait is
disabled on the boot CPU.  With TXT disabled, both features are
enabled.

I'll see if my laptop does the same thing.

--Andy
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
