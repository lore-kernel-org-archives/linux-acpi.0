From: Tyler Baicar <tbaicar@codeaurora.org>
Subject: Re: [PATCH V3] acpi: apei: clear error status before acknowledging
 the error
Date: Thu, 21 Sep 2017 09:27:06 -0600
Message-ID: <a7496f34-4ea9-33a2-0e65-f7e3aa49deb0@codeaurora.org>
References: <1503939221-27732-1-git-send-email-tbaicar@codeaurora.org>
 <20170829081610.moq2dtxzz4vrbmo5@pd.tnic>
 <47ed1861-1bdb-7caf-3d6b-5304235c7e10@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <47ed1861-1bdb-7caf-3d6b-5304235c7e10@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: Borislav Petkov <bp@alien8.de>, lenb@kernel.org, will.deacon@arm.com, james.morse@arm.com, bp@suse.de, shiju.jose@huawei.com, geliangtang@gmail.com, andriy.shevchenko@linux.intel.com, tony.luck@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 9/13/2017 8:40 AM, Baicar, Tyler wrote:
> On 8/29/2017 2:16 AM, Borislav Petkov wrote:
>> On Mon, Aug 28, 2017 at 10:53:41AM -0600, Tyler Baicar wrote:
>>> Currently we acknowledge errors before clearing the error status.
>>> This could cause a new error to be populated by firmware in-between
>>> the error acknowledgment and the error status clearing which would
>>> cause the second error's status to be cleared without being handled.
>>> So, clear the error status before acknowledging the errors.
>>>
>>> Also, make sure to acknowledge the error if the error status read
>>> fails.
>>>
>>> V3: Seperate check for -ENOENT return value
>>>
>>> V2: Only send error ack if there was an error populated
>>>      Remove curly braces that are no longer needed
>>>
>>> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
>>> ---
>>>   drivers/acpi/apei/ghes.c | 16 +++++++++-------
>>>   1 file changed, 9 insertions(+), 7 deletions(-)
>> Reviewed-by: Borislav Petkov <bp@suse.de>
> Hello Rafael,
>
> Were you able to apply this patch?
I haven't heard anything on this patch. It would be great to have it in 
4.14 :)

Thanks,
Tyler
