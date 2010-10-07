From: Sameer Nanda <snanda@chromium.org>
Subject: Re: [PATCH] ACPI: Read TSC upon resume
Date: Thu, 7 Oct 2010 14:27:37 -0700
Message-ID: <AANLkTimD5Vrjp8tB6crdaOdS-=LYV+JZL0tCLLcruFGu@mail.gmail.com>
References: <1286406919-6236-1-git-send-email-snanda@chromium.org>
 <20101007021959.GA7300@suse.de> <AANLkTi=mjaojm-O2rbKRTpsqpKiSKjU+P2dGZmENd-jU@mail.gmail.com>
 <201010072159.31482.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.35]:20535 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755967Ab0JGV2B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Oct 2010 17:28:01 -0400
Received: from hpaq3.eem.corp.google.com (hpaq3.eem.corp.google.com [172.25.149.3])
	by smtp-out.google.com with ESMTP id o97LRxW7012805
	for <linux-acpi@vger.kernel.org>; Thu, 7 Oct 2010 14:27:59 -0700
Received: from qyk35 (qyk35.prod.google.com [10.241.83.163])
	by hpaq3.eem.corp.google.com with ESMTP id o97LNvga007047
	for <linux-acpi@vger.kernel.org>; Thu, 7 Oct 2010 14:27:58 -0700
Received: by qyk35 with SMTP id 35so423992qyk.20
        for <linux-acpi@vger.kernel.org>; Thu, 07 Oct 2010 14:27:58 -0700 (PDT)
In-Reply-To: <201010072159.31482.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <gregkh@suse.de>, lenb@kernel.org, stefan.bader@canonical.com, brad.figg@canonical.com, apw@canonical.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Oct 7, 2010 at 12:59 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Thursday, October 07, 2010, Sameer Nanda wrote:
>> (resending as plain text, sorry if you got dupe messages)
>>
>> On Wed, Oct 6, 2010 at 7:19 PM, Greg KH <gregkh@suse.de> wrote:
>> > On Wed, Oct 06, 2010 at 04:15:19PM -0700, Sameer Nanda wrote:
>> >> Read the TSC upon resuming and print it out. This is useful
>> >> in helping figure out amount of time spent in the BIOS when
>> >> resuming from suspend.
>> >>
>> >> Change-Id: I1d6a32bd62421becddecd152d561763e5f3e1101
>> >
>> > What is this tag for? =C2=A0I don't think it matches anything the =
kernel
>> > community wants, do you?
>>
>> Yeah, its not needed. =C2=A0Let me resubmit the patch without this t=
ag.
>>
>> >
>> > And are you always going to be printing this out? =C2=A0Why do we =
want to
>> > know this every time?
>>
>> Yes, every time. =C2=A0This helps track variance in BIOS resume time=
s
>> within a single boot.
>>
>> >
>> >> Signed-off-by: Sameer Nanda <snanda@chromium.org>
>> >> ---
>> >> =C2=A0drivers/acpi/sleep.c | =C2=A0 =C2=A04 ++++
>> >> =C2=A01 files changed, 4 insertions(+), 0 deletions(-)
>> >>
>> >> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
>> >> index c0fed2e..f0588fa 100644
>> >> --- a/drivers/acpi/sleep.c
>> >> +++ b/drivers/acpi/sleep.c
>> >> @@ -214,6 +214,7 @@ static int acpi_suspend_enter(suspend_state_t=
 pm_state)
>> >> =C2=A0 =C2=A0 =C2=A0 acpi_status status =3D AE_OK;
>> >> =C2=A0 =C2=A0 =C2=A0 unsigned long flags =3D 0;
>> >> =C2=A0 =C2=A0 =C2=A0 u32 acpi_state =3D acpi_target_sleep_state;
>> >> + =C2=A0 =C2=A0 u64 tsc;
>> >>
>> >> =C2=A0 =C2=A0 =C2=A0 ACPI_FLUSH_CPU_CACHE();
>> >>
>> >> @@ -235,6 +236,9 @@ static int acpi_suspend_enter(suspend_state_t=
 pm_state)
>> >>
>> >> =C2=A0 =C2=A0 =C2=A0 case ACPI_STATE_S3:
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do_suspend_lowle=
vel();
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rdtscll(tsc);
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_INFO "TSC=
 at resume: %llu\n",
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (unsigned long long)tsc);
>> >
>> > How long does this take, will it slow down resume?
>>
>> The impact is ~10us (as measured on an Intel Atom N455 @ 1.66Ghz).
>> Given that resume time is currently of the order of 1sec, its in the
>> noise range.
>
> Do I think correctly that it assumes the TSC will be updated in the s=
leep state?

No, it actually banks on TSC not being updated while the system is in S=
3 state.
Theory here being that upon resuming from S3, the CPU gets reset and so=
 TSC
starts counting up from 0.  Therefore, reading the TSC value in the ker=
nel upon
resuming gives the number of cycles spent in the BIOS in resume path.

>
> Rafael
>



--=20
Sameer
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
