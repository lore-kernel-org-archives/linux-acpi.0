From: Sameer Nanda <snanda@chromium.org>
Subject: Re: [PATCH] ACPI: Read TSC upon resume
Date: Thu, 7 Oct 2010 10:58:10 -0700
Message-ID: <AANLkTi=mjaojm-O2rbKRTpsqpKiSKjU+P2dGZmENd-jU@mail.gmail.com>
References: <1286406919-6236-1-git-send-email-snanda@chromium.org> <20101007021959.GA7300@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101007021959.GA7300@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: lenb@kernel.org, stefan.bader@canonical.com, brad.figg@canonical.com, apw@canonical.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

(resending as plain text, sorry if you got dupe messages)

On Wed, Oct 6, 2010 at 7:19 PM, Greg KH <gregkh@suse.de> wrote:
> On Wed, Oct 06, 2010 at 04:15:19PM -0700, Sameer Nanda wrote:
>> Read the TSC upon resuming and print it out. This is useful
>> in helping figure out amount of time spent in the BIOS when
>> resuming from suspend.
>>
>> Change-Id: I1d6a32bd62421becddecd152d561763e5f3e1101
>
> What is this tag for? =C2=A0I don't think it matches anything the ker=
nel
> community wants, do you?

Yeah, its not needed.  Let me resubmit the patch without this tag.

>
> And are you always going to be printing this out? =C2=A0Why do we wan=
t to
> know this every time?

Yes, every time.  This helps track variance in BIOS resume times
within a single boot.

>
>> Signed-off-by: Sameer Nanda <snanda@chromium.org>
>> ---
>> =C2=A0drivers/acpi/sleep.c | =C2=A0 =C2=A04 ++++
>> =C2=A01 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
>> index c0fed2e..f0588fa 100644
>> --- a/drivers/acpi/sleep.c
>> +++ b/drivers/acpi/sleep.c
>> @@ -214,6 +214,7 @@ static int acpi_suspend_enter(suspend_state_t pm=
_state)
>> =C2=A0 =C2=A0 =C2=A0 acpi_status status =3D AE_OK;
>> =C2=A0 =C2=A0 =C2=A0 unsigned long flags =3D 0;
>> =C2=A0 =C2=A0 =C2=A0 u32 acpi_state =3D acpi_target_sleep_state;
>> + =C2=A0 =C2=A0 u64 tsc;
>>
>> =C2=A0 =C2=A0 =C2=A0 ACPI_FLUSH_CPU_CACHE();
>>
>> @@ -235,6 +236,9 @@ static int acpi_suspend_enter(suspend_state_t pm=
_state)
>>
>> =C2=A0 =C2=A0 =C2=A0 case ACPI_STATE_S3:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do_suspend_lowlevel=
();
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rdtscll(tsc);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_INFO "TSC at=
 resume: %llu\n",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (unsigned long long)tsc);
>
> How long does this take, will it slow down resume?

The impact is ~10us (as measured on an Intel Atom N455 @ 1.66Ghz).
Given that resume time is currently of the order of 1sec, its in the
noise range.

Thanks for the feedback!

>
> thanks,
>
> greg k-h
>



--=20
Sameer
