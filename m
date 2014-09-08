From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v6 1/2] Mailbox: Add support for Platform Communication Channel
Date: Mon, 8 Sep 2014 08:48:56 -0400
Message-ID: <CAJ5Y-eZxtxLVsXH=1TTW4+HuOEBwaRc+Bwa91rPGcCB5sNPdcg@mail.gmail.com>
References: <1409856561-3945-1-git-send-email-ashwin.chaugule@linaro.org>
	<1409856561-3945-2-git-send-email-ashwin.chaugule@linaro.org>
	<1AE640813FDE7649BE1B193DEA596E880266233D@SHSMSX101.ccr.corp.intel.com>
	<CAJ5Y-eZnoLLomcX0K_KL-FmprZEYg=sPDvf0JVOZJc_jNZvF+Q@mail.gmail.com>
	<1AE640813FDE7649BE1B193DEA596E88026624F3@SHSMSX101.ccr.corp.intel.com>
	<CAJ5Y-eYe_VVDbD=4vEGOd3TT03xWeLxk2q2SVmCgn__a2qxgRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:50618 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753078AbaIHMtA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Sep 2014 08:49:00 -0400
Received: by mail-we0-f174.google.com with SMTP id t60so1050707wes.19
        for <linux-acpi@vger.kernel.org>; Mon, 08 Sep 2014 05:48:56 -0700 (PDT)
In-Reply-To: <CAJ5Y-eYe_VVDbD=4vEGOd3TT03xWeLxk2q2SVmCgn__a2qxgRw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "arnd@arndb.de" <arnd@arndb.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "broonie@kernel.org" <broonie@kernel.org>

Hello Mark, Arnd, Lv,

On 5 September 2014 12:15, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
> On 5 September 2014 02:35, Zheng, Lv <lv.zheng@intel.com> wrote:
>>>
>>> On 4 September 2014 21:56, Zheng, Lv <lv.zheng@intel.com> wrote:
>>> >> +     spin_lock_irqsave(&chan->lock, flags);
>>> >> +     chan->msg_free = 0;
>>> >> +     chan->msg_count = 0;
>>> >> +     chan->active_req = NULL;
>>> >> +     chan->cl = cl;
>>> >> +     init_completion(&chan->tx_complete);
>>> >> +
>>> >> +     if (chan->txdone_method == TXDONE_BY_POLL && cl->knows_txdone)
>>> >
>>> > The tab should be a space here?
>>> >
>>>
>>> Not sure where you're seeing the tab.
>>
>> It is a tab here after " txdone_method".
>>>>
>>> >> +out_err:
>>> >> +     return ACPI_SUCCESS(status) ? 1 : 0;
>>> >
>>> > Should the return value of 1 here be -EINVAL?
>>> >
>>>
>>> I dont think it really matters, the caller returns -EINVAL anyway.
>>
>> This is not a "bool" return value or "reversed bool" return value.
>> Why not use errno for all "int" return value across all initialization/finalization functions?
>
> Ok, I'll make it consistent with errnos. Since it doesnt change the
> logic of the code, I wont send out a V7 until there is any other
> feedback from others.
>

Anymore feedback on Patchset V6? I will address Lv's comments above in V7 soon.

Thanks,
Ashwin
