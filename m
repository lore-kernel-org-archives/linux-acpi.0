From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] ACPI / IPMI: change warning to debug on timeout
Date: Sat, 25 Mar 2017 10:08:59 -0400
Message-ID: <39c54677-1472-afff-ec70-45a790f56e50@codeaurora.org>
References: <1490283150-24000-1-git-send-email-okaya@codeaurora.org>
 <537c0d7a-fd95-2e7f-be07-9e3ca79ca07a@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48936 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750867AbdCYOJD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 25 Mar 2017 10:09:03 -0400
In-Reply-To: <537c0d7a-fd95-2e7f-be07-9e3ca79ca07a@acm.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: minyard@acm.org, linux-acpi@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org

On 3/24/2017 10:55 PM, Corey Minyard wrote:
> Why would a timeout for a message be expected?  The BMC should
> at least respond with an error for an incorrect message.

Let me add some more context...

In this particular case, the FRU ID that I was trying to access was
correct. 

Platform supports PCIe hotplug. The FRU is embedded into the HW that
is being removed. That's what I mean by non-existent.

When the device is ejected and a FRU command is executed, BMC times out
reaching to the FRU on the device. 

When the device is inserted, everything works as expected.

> 
> -corey
> 
> On 03/23/2017 10:32 AM, Sinan Kaya wrote:
>> Getting timeout message from BMC when trying to read from a non-existent
>> FRU. This is expected but warning is not.
>>
>> Let's reduce the warning to debug.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>   drivers/acpi/acpi_ipmi.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
>> index 747c2ba..1b64419 100644
>> --- a/drivers/acpi/acpi_ipmi.c
>> +++ b/drivers/acpi/acpi_ipmi.c
>> @@ -429,8 +429,7 @@ static void ipmi_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
>>       if (msg->recv_type == IPMI_RESPONSE_RECV_TYPE &&
>>           msg->msg.data_len == 1) {
>>           if (msg->msg.data[0] == IPMI_TIMEOUT_COMPLETION_CODE) {
>> -            dev_WARN_ONCE(dev, true,
>> -                      "Unexpected response (timeout).\n");
>> +            dev_dbg_once(dev, "Unexpected response (timeout).\n");
>>               tx_msg->msg_done = ACPI_IPMI_TIMEOUT;
>>           }
>>           goto out_comp;
> 
> 
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
