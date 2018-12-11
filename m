From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v2 1/3] ACPI: Allow PCI to be disabled for reboot
Date: Tue, 11 Dec 2018 17:00:22 -0500
Message-ID: <620b7955-de9c-a273-bf1c-5521834e16a6@kernel.org>
References: <20181208214644.5374-1-okaya@kernel.org>
 <CAJZ5v0jV+UZ7A46Kiyv6JysoFJ=_ts7O_p3z9F1Uze3OwZdh_Q@mail.gmail.com>
 <4aa65942-bf97-c957-7f77-38bfdf7d1d3a@kernel.org>
 <CAJZ5v0gsq4-pzMrqrKuiUysXbnjc5AfVnY3=2OxQRZPsma=ZMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0gsq4-pzMrqrKuiUysXbnjc5AfVnY3=2OxQRZPsma=ZMA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 12/11/2018 4:49 PM, Rafael J. Wysocki wrote:
>> I struggled between break and return. Existing code seems to return on failure
>> when bus0 is NULL. I assumed it would be more logical to return as someone could
>> put some code after here that assumes everything is in order.
> Well, there's no such code ATM, so there's no practical difference
> between the two and you don't really need the #else branch at all, do
> you?
> 

OK. I'll go with break.
