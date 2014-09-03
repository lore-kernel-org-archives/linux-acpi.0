From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v4 2/4] Mailbox: Add PCC Mailbox Helper functions
Date: Wed, 3 Sep 2014 16:06:08 -0400
Message-ID: <CAJ5Y-eb3Bv5ZDYk3cevjvp=MuM91VjHM-a6AGx7zf_bHHinExA@mail.gmail.com>
References: <1409773139-10356-1-git-send-email-ashwin.chaugule@linaro.org>
	<1409773139-10356-3-git-send-email-ashwin.chaugule@linaro.org>
	<15869691.jmsGqDAs7j@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:33311 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbaICUGK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Sep 2014 16:06:10 -0400
Received: by mail-wi0-f175.google.com with SMTP id ho1so1639424wib.14
        for <linux-acpi@vger.kernel.org>; Wed, 03 Sep 2014 13:06:08 -0700 (PDT)
In-Reply-To: <15869691.jmsGqDAs7j@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux acpi <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Brown <broonie@kernel.org>

On 3 September 2014 15:56, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 03 September 2014 15:38:57 Ashwin Chaugule wrote:
>> The current Mailbox framework expects the Mailbox controller
>> and clients to be backed by Struct devices and uses a DT specific
>> matching method for clients to lookup channels in a controller.
>>
>> The helper functions introduced here allow the PCC Mailbox as defined
>> in the ACPI 5.0+ specification to workaround these expectations and
>> continue to work with the rest of the Mailbox framework even in the case
>> where PCC is defined using DT bindings.
>>
>> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>
> I think the general concept makes sense, but the split between files
> is not good in this version:
>
>> ---
>>  drivers/mailbox/Kconfig       |   8 +++
>>  drivers/mailbox/Makefile      |   2 +
>>  drivers/mailbox/pcc_mailbox.c | 136 ++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 146 insertions(+)
>>  create mode 100644 drivers/mailbox/pcc_mailbox.c
>>
>> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
>> index c8b5c13..0e7be60 100644
>> --- a/drivers/mailbox/Kconfig
>> +++ b/drivers/mailbox/Kconfig
>> @@ -50,4 +50,12 @@ config OMAP_MBOX_KFIFO_SIZE
>>         Specify the default size of mailbox's kfifo buffers (bytes).
>>         This can also be changed at runtime (via the mbox_kfifo_size
>>         module parameter).
>> +
>> +config PCC_MAILBOX_API
>> +     bool "Platform Communication Channel Mailbox API"
>> +     help
>> +             This contains helper functions for registering a PCC mailbox
>> +             with the generic Mailbox framework and for looking up a PCC
>> +             channel.
>> +
>
> I might be missing something, but I see no reason to have separate
> Kconfig symbols for the API and the driver, since you can't really
> have one without the other.
>
>> +
>> +extern struct list_head mbox_cons;
>> +extern struct mutex con_mutex;
>> +extern void mbox_free_channel(struct mbox_chan *chan);
>> +extern void poll_txdone(unsigned long data);
>
> This part is the main issue: you should never declare 'extern' functions
> or data structures in a .c file. They are the interface between two
> files and need to be in a header file that is included by both of them.
>
> It's also bad style to make internal data structures of one driver
> or subsystem available to other drivers, those should go through
> some form of accessor function. Note that you are currently putting
> those four identifiers into the global kernel namespace, where they
> might conflict with any driver that has a local 'poll_txdone' or
> 'con_mutex' symbol, which is not that unlikely.
>
>> +static struct mbox_controller *pcc_mbox;
>> +
>> +struct mbox_chan *pcc_mbox_request_channel(struct mbox_client *cl, int index)
>> +{
>> +     struct mbox_chan *chan;
>> +     unsigned long flags;
>> +     int ret;
>> +
>> +     if (!pcc_mbox) {
>> +             pr_err("PCC Mailbox not found.\n");
>> +             return ERR_PTR(-ENODEV);
>> +     }
>
> (minor comment)
> It's better to use dev_err whenever you can.
>
>> +
>> +     mutex_lock(&con_mutex);
>
> What do you need the mutex for in this function? The only thing
> I see that might need to be protected is the pointer access above,
> but that is outside of the mutex.
>
>> +int pcc_mbox_controller_register(struct mbox_controller *mbox)
>> +{
>> +     int i, txdone;
>
> Why can't you just call the normal registration function?
>
> The pcc mailbox will nor be reachable afterwards through the
> normal mailbox API, but you already have the pointer in the
> driver from patch 3, so if you just move the
> pcc_mbox_request_channel/pcc_mbox_free_channel into
> drivers/mailbox/pcc.c and register the device as normal,
> this should become unnecessary.

hmm. I like the idea of merging this with pcc.c instead. I'll spin
another version soon.

Thanks,
Ashwin
