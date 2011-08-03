From: Andrew Lutomirski <luto@mit.edu>
Subject: Re: [PATCH 2/2] x86: Enable monitor/mwait on Intel if BIOS hasn't already
Date: Wed, 3 Aug 2011 12:42:13 -0400
Message-ID: <CAObL_7FNa20Hsd0v-hs1vz=ejnkdaT+Yr=wwM681GbZJiuLkMQ@mail.gmail.com>
References: <cover.1312386029.git.luto@mit.edu> <5bec80947da3fb72f2f18fbe6d924a69f83fbed9.1312386029.git.luto@mit.edu>
 <alpine.LFD.2.02.1108031214470.22067@x980> <CAObL_7GuAmzyjo5AmYxbTeiAqFtVk1N+opzWEzwJu8Mgrvts7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:48275 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754283Ab1HCQmd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Aug 2011 12:42:33 -0400
In-Reply-To: <CAObL_7GuAmzyjo5AmYxbTeiAqFtVk1N+opzWEzwJu8Mgrvts7g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>, linux-acpi@vger.kernel.org

On Wed, Aug 3, 2011 at 12:22 PM, Andrew Lutomirski <luto@mit.edu> wrote=
:
> On Wed, Aug 3, 2011 at 12:15 PM, Len Brown <lenb@kernel.org> wrote:
>> On Wed, 3 Aug 2011, Andy Lutomirski wrote:
>>
>>> I have a Sandy Bridge machine with an Intel BIOS that enables
>>> monitor/mwait on all but the boot CPU. =A0With this patch, intel_id=
le
>>> works.
>>
>> What machine has this BIOS bug, and are you running
>> the latest version of the BIOS?
>
> Intel DQ67SW, version SWQ6710H.86A.0051.2011.0413.1154. =A0This is no=
t
> quite up-to-date -- I'll test a newer BIOS.

SWQ6710H.86A.0053.2011.0615.1535 has the same problem.  It fixed ASPM, =
though :)

Should I redo the patch with a printk to warn about the firmware bug?

--Andy

>
> (Enabling monitor/mwait on some but not all CPUs is obnoxious, too. =A0=
I
> think it's just dumb luck that Linux notices at all and doesn't
> crash.)
>
> --Andy
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
