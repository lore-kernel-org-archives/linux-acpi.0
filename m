From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 0/3] acpi/pmic: add opregion driver for Intel BXT
 WhiskeyCove PMIC
Date: Thu, 23 Jun 2016 15:17:30 +0200
Message-ID: <CAJZ5v0hn9rFbsB0d3Jjm24w73qtLD31kKC+Af2+7e2W5yDZXvg@mail.gmail.com>
References: <20160623075515.GB239751@worksta> <CAJZ5v0j1M2X-ygZgmbO3ebbT3d9RQ2h6DRYjs4NK5vROQDHFqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0j1M2X-ygZgmbO3ebbT3d9RQ2h6DRYjs4NK5vROQDHFqQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bin Gao <bin.gao@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aaron Lu <aaron.lu@intel.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ysiyer <yegnesh.s.iyer@intel.com>, Ajay Thomas <ajay.thomas.david.rajamanickam@intel.com>, Bin Gao <bin.gao@intel.com>, Felipe Balbi <felipe.balbi@linux.intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jun 23, 2016 at 3:03 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Thu, Jun 23, 2016 at 9:55 AM, Bin Gao <bin.gao@linux.intel.com> wrote:
>> This series modifies the pen function signature to take bit field
>> and adds a new opregion driver for Intel BXT WhiskeyCove PMIC. It
>> also adds support for PMIC regs operation region.
>>
>> Yegnesh Iyer (1):
>>   acpi: pmic: Modifying the pen function signature to take bit field
>>
>> Ajay Thomas (1):
>>   acpi: pmic: Add opregion driver for Intel BXT WhiskeyCove PMIC
>
> I've just applied the above two patches from the previous series.  Are
> there any changes to them here?

Well, I'm dropping the old series due to comments from Aaron on the
second patch.

I will be waiting for an update addressing the Aaron's comments in
[2/3] and [3/3].
