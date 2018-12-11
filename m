From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v2 1/3] ACPI: Allow PCI to be disabled for reboot
Date: Tue, 11 Dec 2018 11:54:39 -0500
Message-ID: <4aa65942-bf97-c957-7f77-38bfdf7d1d3a@kernel.org>
References: <20181208214644.5374-1-okaya@kernel.org>
 <CAJZ5v0jV+UZ7A46Kiyv6JysoFJ=_ts7O_p3z9F1Uze3OwZdh_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jV+UZ7A46Kiyv6JysoFJ=_ts7O_p3z9F1Uze3OwZdh_Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 12/11/2018 5:12 AM, Rafael J. Wysocki wrote:
> On Sat, Dec 8, 2018 at 10:47 PM Sinan Kaya <okaya@kernel.org> wrote:
>>
>> Make PCI reboot conditional on PCI support being present on the kernel
>> configuration.
>>
>> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> 
> Same comment as for patch [2/3]: make the subject say clearly that
> this is about CONFIG_PCI.

Sure

>>          case ACPI_ADR_SPACE_PCI_CONFIG:
>> +       {
>> +#ifdef CONFIG_PCI
>> +               unsigned int devfn;
>> +               struct pci_bus *bus0;
>> +
>>                  /* The reset register can only live on bus 0. */
>>                  bus0 = pci_find_bus(0, 0);
>>                  if (!bus0)
>> @@ -45,7 +48,10 @@ void acpi_reboot(void)
>>                  pci_bus_write_config_byte(bus0, devfn,
>>                                  (rr->address & 0xffff), reset_value);
>>                  break;
>> -
>> +#else
>> +               return;
> 
> Why not "break"?
> 

I struggled between break and return. Existing code seems to return on failure
when bus0 is NULL. I assumed it would be more logical to return as someone could
put some code after here that assumes everything is in order.
