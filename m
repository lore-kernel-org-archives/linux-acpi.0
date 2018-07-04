From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [RFC PATCH] ACPI: bus: match of_device_id using acpi device
Date: Wed, 4 Jul 2018 13:24:14 +0300
Message-ID: <CAHp75VeuoTM=RoUgk0qWyiRJYk2AncVhxKDvms_2Hv0yE=g8uQ@mail.gmail.com>
References: <1530609760-8919-1-git-send-email-srinath.mannam@broadcom.com>
 <CAHp75VfPvCD7xpp73jbya4ONN=wxpVGNpOfNeqZYjfyirms0PA@mail.gmail.com>
 <CABe79T7EeyzKS97zeQ5akoSaZX0=hMgHxw4XkLCQW15eRR=14Q@mail.gmail.com>
 <CAHp75Vef97XB-M=+xUxsGqzgPrADcUmLTLRdWE+PcVxtTQLN4g@mail.gmail.com>
 <8518137d-c859-657e-844f-51720f6ef8dd@arm.com> <alpine.DEB.2.20.1807041205290.8629@fox.voss.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1807041205290.8629@fox.voss.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Srinath Mannam <srinath.mannam@broadcom.com>, "Voss, Dr. Nikolaus" <Nikolaus.Dr.Voss@loewensteinmedical.de>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Ray Jui <ray.jui@broadcom.com>, Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>, Vikram Prakash <vikram.prakash@broadcom.com>, Scott Branden <scott.branden@broadcom.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, nv@vosn.de
List-Id: linux-acpi@vger.kernel.org

On Wed, Jul 4, 2018 at 1:17 PM, Nikolaus Voss
<nikolaus.voss@loewensteinmedical.de> wrote:
> On Wed, 4 Jul 2018, Sudeep Holla wrote:
>> On 04/07/18 10:32, Andy Shevchenko wrote:
>>> On Wed, Jul 4, 2018 at 6:37 AM, Srinath Mannam
>>> <srinath.mannam@broadcom.com> wrote:

>> +1 on NACK for this and anything else that abuse PRP0001 as a short cut
>> approach.
> This is no abuse but exactly what PRP0001 is meant for. The basic idea of
> PRP0001 is to reuse DT "compatible" strings in ACPI namespace, see
> Documentation/acpi/enumeration.txt. Reusing also means getting access to the
> of_device_id.

The idea was for almost DIY and / or manufacturer to develop a
prototype without modifying match code and faking ACPI IDs.
That's why the target of PRP0001 is almost sensors connected to I2C and SPI.

That's why I agreed on your patch to help with this. But! The proper
solution for the devices (device manufacturer) is to allocate an ACPI
ID and provide a corresponding table to the driver.

This is my understanding of that exercise. Rafael can correct me.

> Allocating an ACPI id for an already existing DT driver is redundant, isn't
> it?

It is not.

-- 
With Best Regards,
Andy Shevchenko
