From: Mandeep Singh Baines <msb@chromium.org>
Subject: Re: [PATCH] thinkpad-acpi: fix potential suspend blocking issue
Date: Tue, 5 Mar 2013 09:59:30 -0800
Message-ID: <CACBanvqHRDsOQiMsQMw5_QDt1wFrb8_DRoiASSvqeA6XdFrwZQ@mail.gmail.com>
References: <201303042055.38040.maciej.rutecki@gmail.com>
	<1362504883-9180-1-git-send-email-msb@chromium.org>
	<20130305174838.GA7276@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:41788 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757997Ab3CER7b (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Mar 2013 12:59:31 -0500
Received: by mail-oa0-f49.google.com with SMTP id j6so11092726oag.8
        for <linux-acpi@vger.kernel.org>; Tue, 05 Mar 2013 09:59:30 -0800 (PST)
In-Reply-To: <20130305174838.GA7276@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, ibm-acpi@hmh.eng.br, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Tue, Mar 5, 2013 at 9:48 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 03/05, Mandeep Singh Baines wrote:
>>
>> @@ -2462,13 +2462,13 @@ static int hotkey_kthread(void *data)
>>       unsigned int poll_freq;
>>       bool was_frozen;
>>
>> +     set_freezable();
>> +
>>       mutex_lock(&hotkey_thread_mutex);
>>
>>       if (tpacpi_lifecycle == TPACPI_LIFE_EXITING)
>>               goto exit;
>>
>> -     set_freezable();
>> -
>
> I don't understand this code... but don't we have the same problem
> with kthread_freezable_should_stop() below? It can call __refrigerator()
> too under the same lock.
>

I don't think the lock is held at that point. There is an unlock right
before entering the while loop and at the bottom of the loop.

> Oleg.
>
