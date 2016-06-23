From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 0/3] acpi/pmic: add opregion driver for Intel BXT
 WhiskeyCove PMIC
Date: Thu, 23 Jun 2016 15:18:27 +0200
Message-ID: <CAJZ5v0gYkApQfU-DDtrWQ09cc=RnN3PyW_V4gsMhUafhdHp5rg@mail.gmail.com>
References: <20160623075515.GB239751@worksta> <CAJZ5v0j1M2X-ygZgmbO3ebbT3d9RQ2h6DRYjs4NK5vROQDHFqQ@mail.gmail.com>
 <20160623131641.GF27263@kuha.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160623131641.GF27263@kuha.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Bin Gao <bin.gao@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aaron Lu <aaron.lu@intel.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ysiyer <yegnesh.s.iyer@intel.com>, Ajay Thomas <ajay.thomas.david.rajamanickam@intel.com>, Bin Gao <bin.gao@intel.com>, Felipe Balbi <felipe.balbi@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jun 23, 2016 at 3:16 PM, Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
> On Thu, Jun 23, 2016 at 03:03:34PM +0200, Rafael J. Wysocki wrote:
>> On Thu, Jun 23, 2016 at 9:55 AM, Bin Gao <bin.gao@linux.intel.com> wrote:
>> > This series modifies the pen function signature to take bit field
>> > and adds a new opregion driver for Intel BXT WhiskeyCove PMIC. It
>> > also adds support for PMIC regs operation region.
>> >
>> > Yegnesh Iyer (1):
>> >   acpi: pmic: Modifying the pen function signature to take bit field
>> >
>> > Ajay Thomas (1):
>> >   acpi: pmic: Add opregion driver for Intel BXT WhiskeyCove PMIC
>>
>> I've just applied the above two patches from the previous series.  Are
>> there any changes to them here?
>>
>> > Chandra Sekhar Anagani (1):
>> >  acpi: pmic: Add support for PMIC regs operation region
>>
>> That's a new one I suppose?
>>
>> How is this related to http://marc.info/?l=linux-acpi&m=146660742815070&w=2 ?
>
> Looks the like same to me.. Just ignore the one I send then.

I will.

What about the second patch in your series?

> Sorry, there seems to have been a miscommunication somewhere.

I see, no problem.
