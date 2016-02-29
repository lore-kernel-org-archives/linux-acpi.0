From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH V3 1/4] ACPI / CPPC: Optimize PCC Read Write operations
Date: Mon, 29 Feb 2016 12:20:49 -0700
Message-ID: <56D49A11.80800@codeaurora.org>
References: <1455134762-31400-1-git-send-email-pprakash@codeaurora.org>
 <1455134762-31400-2-git-send-email-pprakash@codeaurora.org>
 <20160215163719.GA22453@arm.com>
 <CAJ5Y-eb=0NnH67DfcuYn519S4n3QtXYtEF6m-G3zetcOS+cXcg@mail.gmail.com>
 <20160229173958.GA4809@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51100 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbcB2TUw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Feb 2016 14:20:52 -0500
In-Reply-To: <20160229173958.GA4809@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Klimov <alexey.klimov@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux acpi <linux-acpi@vger.kernel.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>

Hi Alexey,

On 2/29/2016 10:39 AM, Alexey Klimov wrote:
> On Tue, Feb 16, 2016 at 01:47:15PM -0500, Ashwin Chaugule wrote:
>> Hi Alexey,
>>
>> On 15 February 2016 at 11:37, Alexey Klimov <alexey.klimov@arm.com> wrote:
>>> Hi Prashanth and Ashwin,
>>>
>>> On Wed, Feb 10, 2016 at 01:05:59PM -0700, Prashanth Prakash wrote:
>>>> From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>>>>
>>>> Previously the send_pcc_cmd() code checked if the
>>>> PCC operation had completed before returning from
>>>> the function. This check was performed regardless
>>>> of the PCC op type (i.e. Read/Write). Knowing
>>>> the type of cmd can be used to optimize the check
>>>> and avoid needless waiting. e.g. with Write ops,
>>>> the actual Writing is done before calling send_pcc_cmd().
>>>> And the subsequent Writes will check if the channel is
>>>> free at the entry of send_pcc_cmd() anyway.
>>>>
>>>> However, for Read cmds, we need to wait for the cmd
>>>> completion bit to be flipped, since the actual Read
>>>> ops follow after returning from the send_pcc_cmd(). So,
>>>> only do the looping check at the end for Read ops.
>>>>
>>>> Also, instead of using udelay() calls, use ktime as a
>>>> means to check for deadlines. The current deadline
>>>> in which the Remote should flip the cmd completion bit
>>>> is defined as N * Nominal latency. Where N is arbitrary
>>>> and large enough to work on slow emulators and Nominal
>>>> latency comes from the ACPI table (PCCT). This helps
>>>> in working around the CONFIG_HZ effects on udelay()
>>>> and also avoids needing different ACPI tables for Silicon
>>>> and Emulation platforms.
>>>>
>>>> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>>>> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
>>>> ---
>>>>  drivers/acpi/cppc_acpi.c | 99 ++++++++++++++++++++++++++++++++++--------------
>>>>  1 file changed, 71 insertions(+), 28 deletions(-)
>> [..]
>>
>>>>  /*
>>>>   * Arbitrary Retries in case the remote processor is slow to respond
>>>> - * to PCC commands.
>>>> + * to PCC commands. Keeping it high enough to cover emulators where
>>>> + * the processors run painfully slow.
>>>>   */
>>>>  #define NUM_RETRIES 500
>>>>
>>>> +static int check_pcc_chan(void)
>>>> +{
>>>> +     int ret = -EIO;
>>>> +     struct acpi_pcct_shared_memory __iomem *generic_comm_base = pcc_comm_addr;
>>>> +     ktime_t next_deadline = ktime_add(ktime_get(), deadline);
>>>> +
>>>> +     /* Retry in case the remote processor was too slow to catch up. */
>>>> +     while (!ktime_after(ktime_get(), next_deadline)) {
>>>> +             if (readw_relaxed(&generic_comm_base->status) & PCC_CMD_COMPLETE) {
>>> What do you think about polling for error too?
>>> Firmware might set error bit and kernel will spin here for full cycle (maybe even
>>> more than one time).
>>>
>> Hm. I dont think thats useful since we dont do anything special if the
>> firmware errors out. Perhaps at some later point we can stop sending
>> new requests if there are firmware errors, but then how would we know
>> when to resume?
> The suggestion is to jump out of polling loop quickly instead of spinning for full cycle.
> With longer delays given by firmware the spinning issue on error will be worse.
> This is not going to change behaviour on error paths (or in other words I don't suggest
> to change error path behaviour right now).
>
> Does specification describe any resume after error path? I don't see anything.
The specification doesn't really say how to handle the error. While it doesn't say resume after
error, it  also doesn't say abort all commands after an error.
The only thing I see with respect to error bit is "If set, an error occurred executing the last
command."

So, all we know is there was a an error with the execution of the last command and I am not
sure it is correct to assume all the future usage of the channel should be aborted because the
failure of the last command.

Given the above ambiguity, I think it is better to keep the current implementation as is. If
some platforms shows a behavior where after an error the channel becomes completely
useless, then we can maintain some sort of internal state that decides not to use the channel
after say X number of consecutive errors.
> <snip>
>
> Best regards,
> Alexey Klimov.
>
>
>


