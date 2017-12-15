From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] APEI / ERST: Fix missing error handling in erst_reader()
Date: Thu, 14 Dec 2017 17:05:14 -0800
Message-ID: <CAGXu5jJT7XsANGKVjYnZ83S-o=gjLv1QjS1vikVdR4Rgf4yNWw@mail.gmail.com>
References: <20171214123116.929-1-tiwai@suse.de> <CAJZ5v0gAiSiwwcWpHXWGEpo_Tjy4tqy1D5XvL==BJeuQ6LRKOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:36483 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754506AbdLOBFQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Dec 2017 20:05:16 -0500
Received: by mail-ua0-f193.google.com with SMTP id w47so5198870uah.3
        for <linux-acpi@vger.kernel.org>; Thu, 14 Dec 2017 17:05:16 -0800 (PST)
In-Reply-To: <CAJZ5v0gAiSiwwcWpHXWGEpo_Tjy4tqy1D5XvL==BJeuQ6LRKOg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Jerry Tang <jtang@suse.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Dec 14, 2017 at 5:01 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Thu, Dec 14, 2017 at 1:31 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> The commit f6f828513290 ("pstore: pass allocated memory region back to
>> caller") changed the check of the return value from erst_read() in
>> erst_reader() in the following way:
>>
>>         if (len == -ENOENT)
>>                 goto skip;
>> -       else if (len < 0) {
>> -               rc = -1;
>> +       else if (len < sizeof(*rcd)) {
>> +               rc = -EIO;
>>                 goto out;
>>
>> This introduced another bug: since the comparison with sizeof() is
>> cast to unsigned, a negative len value doesn't hit any longer.
>> As a result, when an error is returned from erst_read(), the code
>> falls through, and it may eventually lead to some weird thing like
>> memory corruption.
>>
>> This patch adds the negative error value check more explicitly for
>> addressing the issue.

Ew, nice catch, thanks!

>>
>> Fixes: f6f828513290 ("pstore: pass allocated memory region back to caller")
>
> That's ancient. :-)
>
>> Cc: <stable@vger.kernel.org>
>> Tested-by: Jerry Tang <jtang@suse.com>
>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>> ---
>>  drivers/acpi/apei/erst.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
>> index 6742f6c68034..9bff853e85f3 100644
>> --- a/drivers/acpi/apei/erst.c
>> +++ b/drivers/acpi/apei/erst.c
>> @@ -1007,7 +1007,7 @@ static ssize_t erst_reader(struct pstore_record *record)
>>         /* The record may be cleared by others, try read next record */
>>         if (len == -ENOENT)
>>                 goto skip;
>> -       else if (len < sizeof(*rcd)) {
>> +       else if (len < 0 || len < sizeof(*rcd)) {
>>                 rc = -EIO;
>>                 goto out;
>>         }
>> --
>
> OK, I'm going to queue this up unless I see objections from Boris or Tony.

Please do, yes.

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
