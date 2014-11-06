From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v9] Mailbox: Add support for Platform Communication Channel
Date: Wed, 5 Nov 2014 19:48:40 -0500
Message-ID: <CAJ5Y-eYXWVm-6HGo-kxuvAqciYqgTOSdkZ8xtVzDwePonvcT9Q@mail.gmail.com>
References: <1412972037-12793-1-git-send-email-ashwin.chaugule@linaro.org>
	<1412972037-12793-2-git-send-email-ashwin.chaugule@linaro.org>
	<CAJ5Y-eY5XtViMjU4FC-q1vCSgFa69DLGFeRr2GTmEO0CtnZPtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:51144 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990AbaKFAsm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Nov 2014 19:48:42 -0500
Received: by mail-wg0-f52.google.com with SMTP id b13so2193672wgh.39
        for <linux-acpi@vger.kernel.org>; Wed, 05 Nov 2014 16:48:41 -0800 (PST)
In-Reply-To: <CAJ5Y-eY5XtViMjU4FC-q1vCSgFa69DLGFeRr2GTmEO0CtnZPtA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>, linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>, Ashwin Chaugule <ashwin.chaugule@linaro.org>

Hi,

On 23 October 2014 11:36, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
> Hello,
>
> On 10 October 2014 16:13, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
>> ACPI 5.0+ spec defines a generic mode of communication
>> between the OS and a platform such as the BMC. This medium
>> (PCC) is typically used by CPPC (ACPI CPU Performance management),
>> RAS (ACPI reliability protocol) and MPST (ACPI Memory power
>> states).
>>
>> This patch adds PCC support as a Mailbox Controller.
>>
>> Reviewed-by: Mark Brown <broonie@kernel.org>
>> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>> ---
>>  drivers/mailbox/Kconfig   |  12 ++
>>  drivers/mailbox/Makefile  |   2 +
>>  drivers/mailbox/mailbox.c |   4 +-
>>  drivers/mailbox/mailbox.h |  16 ++
>>  drivers/mailbox/pcc.c     | 369 ++++++++++++++++++++++++++++++++++++++++++++++
>>  5 files changed, 400 insertions(+), 3 deletions(-)
>>  create mode 100644 drivers/mailbox/mailbox.h
>>  create mode 100644 drivers/mailbox/pcc.c
>>
>> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
>> index 9fd9c67..c04fed9 100644
>> --- a/drivers/mailbox/Kconfig
>> +++ b/drivers/mailbox/Kconfig
>> @@ -33,4 +33,16 @@ config OMAP_MBOX_KFIFO_SIZE
>>           Specify the default size of mailbox's kfifo buffers (bytes).
>>           This can also be changed at runtime (via the mbox_kfifo_size
>>           module parameter).
>> +
>> +config PCC
>> +       bool "Platform Communication Channel Driver"
>> +       depends on ACPI
>> +       help
>> +         ACPI 5.0+ spec defines a generic mode of communication
>> +         between the OS and a platform such as the BMC. This medium
>> +         (PCC) is typically used by CPPC (ACPI CPU Performance management),
>> +         RAS (ACPI reliability protocol) and MPST (ACPI Memory power
>> +         states). Select this driver if your platform implements the
>> +         PCC clients mentioned above.
>> +
>>  endif
>
> Looks like Linus has agreed to pull in the Mailbox framework in 3.18
> [1], so I was hoping we could move this patch forward.
>
> When I started working on the PCC driver, I based it off of ACPI v5.0.
> Since then the spec moved to v5.1 and added a trivial change to the
> PCC section. This change adds a new subtable to support systems that
> dont have an SCI for the doorbell irq. The new structure declaration
> is already in mainline [2]. Given that there were no existing users of
> PCC so far and that the future users are more likely to use the new
> subtable, I'd like to include it here and make it the default from the
> start. SCI support can be added later if it is needed. The change to
> do this is also trivial and the diff is below.
>
> Mark, are you okay with squashing this diff into the original patch
> [v9] and keeping your reviewed-by tag? I can then send a git pull
> request.
>
> Arnd, Rafael, if there are no further comments on this patch, kindly
> advise which tree to rebase on for the git pull.

Guessing there are no objections to this patch and the diff? Can we
please merge this upstream?

Thanks,
Ashwin

>
> --------------------8<-----------------------
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 0006fc3..592c6fa 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -130,7 +130,7 @@ EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
>   */
>  static bool pcc_tx_done(struct mbox_chan *chan)
>  {
> -    struct acpi_pcct_subspace *pcct_ss = chan->con_priv;
> +    struct acpi_pcct_hw_reduced *pcct_ss = chan->con_priv;
>      struct acpi_pcct_shared_memory *generic_comm_base =
>          (struct acpi_pcct_shared_memory *) pcct_ss->base_address;
>      u16 cmd_delay = pcct_ss->min_turnaround_time;
> @@ -182,7 +182,7 @@ static int get_subspace_id(struct mbox_chan *chan)
>   */
>  static int pcc_send_data(struct mbox_chan *chan, void *data)
>  {
> -    struct acpi_pcct_subspace *pcct_ss = chan->con_priv;
> +    struct acpi_pcct_hw_reduced *pcct_ss = chan->con_priv;
>      struct acpi_pcct_shared_memory *generic_comm_base =
>          (struct acpi_pcct_shared_memory *) pcct_ss->base_address;
>      struct acpi_generic_address doorbell;
> @@ -191,14 +191,12 @@ static int pcc_send_data(struct mbox_chan *chan,
> void *data)
>      u64 doorbell_write;
>      u16 cmd = *(u16 *) data;
>      u16 ss_idx = -1;
> -    int ret = 0;
>
>      ss_idx = get_subspace_id(chan);
>
>      if (ss_idx < 0) {
>          pr_err("Invalid Subspace ID from PCC client\n");
> -        ret = -EINVAL;
> -        goto out_err;
> +        return -EINVAL;
>      }
>
>      doorbell = pcct_ss->doorbell_register;
> @@ -219,8 +217,7 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
>      acpi_write((doorbell_val & doorbell_preserve) | doorbell_write,
>              &doorbell);
>
> -out_err:
> -    return ret;
> +    return 0;
>  }
>
>  static struct mbox_chan_ops pcc_chan_ops = {
> @@ -241,12 +238,12 @@ static struct mbox_chan_ops pcc_chan_ops = {
>  static int parse_pcc_subspace(struct acpi_subtable_header *header,
>          const unsigned long end)
>  {
> -    struct acpi_pcct_subspace *pcct_ss;
> +    struct acpi_pcct_hw_reduced *pcct_ss;
>
>      if (pcc_mbox_ctrl.num_chans <= MAX_PCC_SUBSPACES) {
> -        pcct_ss = (struct acpi_pcct_subspace *) header;
> +        pcct_ss = (struct acpi_pcct_hw_reduced *) header;
>
> -        if (pcct_ss->header.type != ACPI_PCCT_TYPE_GENERIC_SUBSPACE) {
> +        if (pcct_ss->header.type != ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE) {
>              pr_err("Incorrect PCC Subspace type detected\n");
>              return -EINVAL;
>          }
> @@ -287,7 +284,7 @@ static int __init acpi_pcc_probe(void)
>
>      count = acpi_table_parse_entries(ACPI_SIG_PCCT,
>              sizeof(struct acpi_table_pcct),
> -            ACPI_PCCT_TYPE_GENERIC_SUBSPACE,
> +            ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE,
>              parse_pcc_subspace, MAX_PCC_SUBSPACES);
>
>      if (count <= 0) {
>
> ---------------8------------------------
>
>
> Thanks,
> Ashwin
>
> [1] - https://lkml.org/lkml/2014/10/21/660
> [2] - https://lkml.org/lkml/2014/7/30/9
