From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v6 1/2] Mailbox: Add support for Platform Communication Channel
Date: Thu, 4 Sep 2014 22:23:34 -0400
Message-ID: <CAJ5Y-eZnoLLomcX0K_KL-FmprZEYg=sPDvf0JVOZJc_jNZvF+Q@mail.gmail.com>
References: <1409856561-3945-1-git-send-email-ashwin.chaugule@linaro.org>
	<1409856561-3945-2-git-send-email-ashwin.chaugule@linaro.org>
	<1AE640813FDE7649BE1B193DEA596E880266233D@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:51323 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434AbaIECXf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Sep 2014 22:23:35 -0400
Received: by mail-we0-f174.google.com with SMTP id u57so11201332wes.33
        for <linux-acpi@vger.kernel.org>; Thu, 04 Sep 2014 19:23:34 -0700 (PDT)
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E880266233D@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "arnd@arndb.de" <arnd@arndb.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "broonie@kernel.org" <broonie@kernel.org>

Hi Lv,

On 4 September 2014 21:56, Zheng, Lv <lv.zheng@intel.com> wrote:
>> +     spin_lock_irqsave(&chan->lock, flags);
>> +     chan->msg_free = 0;
>> +     chan->msg_count = 0;
>> +     chan->active_req = NULL;
>> +     chan->cl = cl;
>> +     init_completion(&chan->tx_complete);
>> +
>> +     if (chan->txdone_method == TXDONE_BY_POLL && cl->knows_txdone)
>
> The tab should be a space here?
>

Not sure where you're seeing the tab.

>> +static bool pcc_tx_done(struct mbox_chan *chan)
>> +{
>> +     struct acpi_pcct_subspace *pcct_ss = chan->con_priv;
>> +     struct acpi_pcct_shared_memory *generic_comm_base =
>> +             (struct acpi_pcct_shared_memory *) pcct_ss->base_address;
>> +     u16 cmd_delay = pcct_ss->min_turnaround_time;
>
> Should these parameters be acquired with chan-lock held?
> Is that possible to change them during runtime?
>

No. These parameters don't change.

>> +/* Channel lock is already held by mbox controller code. */
>> +static int pcc_send_data(struct mbox_chan *chan, void *data)
>> +{
>> +     struct acpi_pcct_subspace *pcct_ss = chan->con_priv;
>> +     struct acpi_pcct_shared_memory *generic_comm_base =
>> +             (struct acpi_pcct_shared_memory *) pcct_ss->base_address;
>
>
> Ditto.
>

Same as above.

>> +out_err:
>> +     return ACPI_SUCCESS(status) ? 1 : 0;
>
> Should the return value of 1 here be -EINVAL?
>

I dont think it really matters, the caller returns -EINVAL anyway.

Thanks,
Ashwin
