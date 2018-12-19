From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v11 1/7] ACPI: Allow CONFIG_PCI to be unset for reboot
Date: Wed, 19 Dec 2018 23:21:12 +0100
Message-ID: <0fe1a7e1-216f-9a75-df48-09bf7eca7a64@kernel.org>
References: <20181218025606.32668-1-okaya@kernel.org>
 <20181218025606.32668-2-okaya@kernel.org>
 <20181218073139.GA8612@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218073139.GA8612@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 12/18/2018 8:31 AM, Christoph Hellwig wrote:
>> @@ -44,8 +47,9 @@ void acpi_reboot(void)
>>   		/* Write the value that resets us. */
>>   		pci_bus_write_config_byte(bus0, devfn,
>>   				(rr->address & 0xffff), reset_value);
>> +#endif
> This would be a lot cleaner if this was split into a little helper
> function.
> 

done.
