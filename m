From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v8 1/4] ACPI: Allow CONFIG_PCI to be unset for reboot
Date: Fri, 14 Dec 2018 10:33:26 -0500
Message-ID: <90d988a4-8097-0852-bb25-be477821ed39@kernel.org>
References: <20181214031252.28707-1-okaya@kernel.org>
 <20181214031252.28707-2-okaya@kernel.org>
 <CAJZ5v0ji7xSs=1By9x8VAZ1eRkyQdfvO67B+Vg+FajZmJLmi4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0ji7xSs=1By9x8VAZ1eRkyQdfvO67B+Vg+FajZmJLmi4Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 12/14/2018 4:18 AM, Rafael J. Wysocki wrote:
>>        case ACPI_ADR_SPACE_PCI_CONFIG:
>> +       {
> Why did you add the braces?
> 

I had to move these variables to the inner scope otherwise, I get an unused
variable warning from the compiler.

>> +#ifdef CONFIG_PCI
>> +               unsigned int devfn;
>> +               struct pci_bus *bus0;
