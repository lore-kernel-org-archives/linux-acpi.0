From: Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH 2/2] acpi:ipmi: Make IPMI user
	handler const
Date: Thu, 9 Feb 2017 09:07:21 -0600
Message-ID: <bfb820d6-11a5-d1ea-13be-bd46714c3c15@acm.org>
References: <1484055613-31286-1-git-send-email-minyard@acm.org>
	<1484055613-31286-3-git-send-email-minyard@acm.org>
	<6437353.muxityAQuf@aspire.rjw.lan>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <openipmi-developer-bounces@lists.sourceforge.net>
In-Reply-To: <6437353.muxityAQuf@aspire.rjw.lan>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openipmi-developer>
List-Post: <mailto:openipmi-developer@lists.sourceforge.net>
List-Help: <mailto:openipmi-developer-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=subscribe>
Errors-To: openipmi-developer-bounces@lists.sourceforge.net
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Corey Minyard <cminyard@mvista.com>, linux-kernel@vger.kernel.org, Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>, openipmi-developer@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On 02/09/2017 08:02 AM, Rafael J. Wysocki wrote:
> On Tuesday, January 10, 2017 07:40:13 AM minyard@acm.org wrote:
>> From: Corey Minyard <cminyard@mvista.com>
>>
>> ipmi_create_user() now takes the user handlers as const, make
>> it const in the ACPI IPMI code.
>>
>> Cc: linux-acpi@vger.kernel.org
>> Cc: Zhao Yakui <yakui.zhao@intel.com>
>> Cc: Lv Zheng <lv.zheng@intel.com>
>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Please let me know if you want me to apply this.
>
> Otherwise, feel free to add my ACK to it and route it whatever way you think
> is appropriate.

Thanks, I'll add your ACK and apply it through the IPMI tree.

-corey

>> ---
>>   drivers/acpi/acpi_ipmi.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
>> index f77956c..747c2ba 100644
>> --- a/drivers/acpi/acpi_ipmi.c
>> +++ b/drivers/acpi/acpi_ipmi.c
>> @@ -56,7 +56,7 @@ struct acpi_ipmi_device {
>>   struct ipmi_driver_data {
>>   	struct list_head ipmi_devices;
>>   	struct ipmi_smi_watcher bmc_events;
>> -	struct ipmi_user_hndl ipmi_hndlrs;
>> +	const struct ipmi_user_hndl ipmi_hndlrs;
>>   	struct mutex ipmi_lock;
>>   
>>   	/*
>>
> Thanks,
> Rafael
>


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
