From: "Huang\, Ying" <ying.huang@intel.com>
Subject: Re: [RESEND PATCH] acpi/apei/erst: Remove "Error" from initialization and disable output
Date: Tue, 18 Jul 2017 10:15:34 +0800
Message-ID: <87a842trqx.fsf@yhuang-dev.intel.com>
References: <1495639838-28099-1-git-send-email-prarit@redhat.com>
        <CAGXu5jJ4qrfKA9wb8kaCAyVct7dPzcuqBW+bv-6XRZTSp3g=Sw@mail.gmail.com>
        <1848099a-69a6-75ff-f243-7aa6d66165fb@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:39138 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751388AbdGRCPh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 17 Jul 2017 22:15:37 -0400
In-Reply-To: <1848099a-69a6-75ff-f243-7aa6d66165fb@redhat.com> (Prarit
        Bhargava's message of "Mon, 17 Jul 2017 11:20:16 -0400")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: Kees Cook <keescook@google.com>, Huang Ying <ying.huang@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

Prarit Bhargava <prarit@redhat.com> writes:

> On 05/24/2017 12:27 PM, Kees Cook wrote:
>> On Wed, May 24, 2017 at 8:30 AM, Prarit Bhargava <prarit@redhat.com> wrote:
>>> Sent a few weeks back ... no reply.
>> 
>> I've added Huang Ying to CC, as the original author of this code. It
>> looks fine to me, FWIW.
>> 
>> -Kees
>
> ping -- Huang?  Rafael?

The change is find for me.

Best Regards,
Huang, Ying

> P.
>
>> 
>>>
>>> P.
>>>
>>> ---8<---
>>>
>>> The word "Error" is used by many QA groups and users as a keyword to
>>> indicate that there is a critical failure during system bootup. The ESRT
>>> code would interact better with these scripts if the word "Error" was
>>> dropped from non-error messages.  Other ACPI features only use the acronym
>>> for initialization and disable messages so the ESRT code should do the
>>> same.
>>>
>>> Remove "Error Record Serialization Table" and replace it with "ACPI ESRT"
>>> in the messages.
>>>
>>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>>> Cc: Kees Cook <keescook@chromium.org>
>>> Cc: Anton Vorontsov <anton@enomsg.org>
>>> Cc: Colin Cross <ccross@android.com>
>>> Cc: Tony Luck <tony.luck@intel.com>
>>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>>> Cc: Len Brown <lenb@kernel.org>
>> 
>> This is fine by me.
>> 
>>> ---
>>>  drivers/acpi/apei/erst.c |    6 ++----
>>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
>>> index ec4f507b524f..a796b9d91e20 100644
>>> --- a/drivers/acpi/apei/erst.c
>>> +++ b/drivers/acpi/apei/erst.c
>>> @@ -1129,8 +1129,7 @@ static int __init erst_init(void)
>>>                 goto err;
>>>
>>>         if (erst_disable) {
>>> -               pr_info(
>>> -       "Error Record Serialization Table (ERST) support is disabled.\n");
>>> +               pr_info("ACPI ERST support is disabled.\n");
>>>                 goto err;
>>>         }
>>>
>>> @@ -1187,8 +1186,7 @@ static int __init erst_init(void)
>>>         if (!erst_erange.vaddr)
>>>                 goto err_release_erange;
>>>
>>> -       pr_info(
>>> -       "Error Record Serialization Table (ERST) support is initialized.\n");
>>> +       pr_info("ACPI ERST support is initialized.\n");
>>>
>>>         buf = kmalloc(erst_erange.size, GFP_KERNEL);
>>>         spin_lock_init(&erst_info.buf_lock);
>>> --
>>> 1.7.9.3
>>>
>> 
>> 
>> 
