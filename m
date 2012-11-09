From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: mmotm 2012-11-08-15-17 uploaded  (acpi)
Date: Fri, 09 Nov 2012 14:46:12 -0800
Message-ID: <509D87B4.7060702@infradead.org>
References: <20121108231753.E6B7A100047@wpzn3.hot.corp.google.com> <509D862C.2060408@infradead.org> <alpine.DEB.2.00.1211091345080.2974@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1211091345080.2974@chino.kir.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Rientjes <rientjes@google.com>
Cc: akpm@linux-foundation.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 11/09/2012 01:45 PM, David Rientjes wrote:

> On Fri, 9 Nov 2012, Randy Dunlap wrote:
> 
>> on x86_64:
>>
>> drivers/built-in.o: In function `acpi_pm_device_sleep_state':
>> (.text+0x21855): undefined reference to `acpi_target_system_state'
>> drivers/built-in.o: In function `acpi_pm_device_sleep_wake':
>> (.text+0x2198e): undefined reference to `acpi_target_system_state'
>> drivers/built-in.o: In function `acpi_dev_suspend_late':
>> (.text+0x21add): undefined reference to `acpi_target_system_state'
>>
> 
> Sent a fix for this yesterday: 
> http://marc.info/?l=linux-kernel&m=13524024192708


Thanks for both of those fixes.

-- 
~Randy
