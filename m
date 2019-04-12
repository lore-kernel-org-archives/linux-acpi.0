From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2] extcon: axp288: Add a depends on ACPI to the Kconfig
 entry
Date: Fri, 12 Apr 2019 09:59:21 +0900
Message-ID: <df1f3722-28a1-30eb-7dbf-e4d4586c9bc3@samsung.com>
References: <20190404104222.23900-1-yuehaibing@huawei.com>
        <CGME20190404142002epcas1p1a86f6d0d5d1a694581630a99532af633@epcas1p1.samsung.com>
        <20190404141748.27048-1-yuehaibing@huawei.com>
        <c11e2ae8-d785-902d-1469-4ff538ebe2ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <c11e2ae8-d785-902d-1469-4ff538ebe2ab@samsung.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, wens@csie.org, hdegoede@redhat.com, rjw@rjwysocki.net, "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Dear all,
 
+ stable@vger.kernel.org 
 
It should be posted to stable@vger.kernel.org
in order to merge it to stable tree.
 
Regards,
Chanwoo Choi


On 19. 4. 12. 오전 8:30, Chanwoo Choi wrote:
> On 19. 4. 4. 오후 11:17, Yue Haibing wrote:
>> From: YueHaibing <yuehaibing@huawei.com>
>>
>> As Hans de Goede pointed, using this driver without ACPI
>> makes little sense, so add ACPI dependency to Kconfig entry
>> to fix a build error while CONFIG_ACPI is not set.
>>
>> drivers/extcon/extcon-axp288.c: In function 'axp288_extcon_probe':
>> drivers/extcon/extcon-axp288.c:363:20: error: dereferencing pointer to incomplete type
>>     put_device(&adev->dev);
>>
>> Fixes: 0cf064db948a ("extcon: axp288: Convert to use acpi_dev_get_first_match_dev()")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Suggested-by: Hans de Goede <hdegoede@redhat.com>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>> v2: rework patch
>> ---
>>  drivers/extcon/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
>> index 1ed4b45..de06faf 100644
>> --- a/drivers/extcon/Kconfig
>> +++ b/drivers/extcon/Kconfig
>> @@ -30,7 +30,7 @@ config EXTCON_ARIZONA
>>  
>>  config EXTCON_AXP288
>>  	tristate "X-Power AXP288 EXTCON support"
>> -	depends on MFD_AXP20X && USB_SUPPORT && X86
>> +	depends on MFD_AXP20X && USB_SUPPORT && X86 && ACPI
>>  	select USB_ROLE_SWITCH
>>  	help
>>  	  Say Y here to enable support for USB peripheral detection
>>
> 
> Applied it. Thanks.
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
