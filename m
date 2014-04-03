From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Linaro-acpi] How to pass I2C platform_data under ACPI
Date: Thu, 03 Apr 2014 17:05:33 +0200
Message-ID: <13098525.yKYfGA04Ut@wuerfel>
References: <D854C92F57B1B347B57E531E78D05EAD57463568@BGSMSX104.gar.corp.intel.com> <20140403135826.GF19349@intel.com> <D854C92F57B1B347B57E531E78D05EAD57464000@BGSMSX104.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <D854C92F57B1B347B57E531E78D05EAD57464000@BGSMSX104.gar.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Pallala, Ramakrishna" <ramakrishna.pallala@intel.com>
Cc: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thursday 03 April 2014 13:59:18 Pallala, Ramakrishna wrote:
> >> We definitely don't want per-board match entries, that does not scale.
> >> The driver should be reasonably generic and get all the necessary data 
> >> out of well-defined tables. You can have different IDs when there are 
> >> only a few cases that are actually relevant, but it has to be 
> >> conceivable that the same driver get used on future hardware without 
> >> changes.
> >
> >Yes, I meant that when the platform data information is not available
> >in ACPI namespace, then (and only then) pass the data by means of different IDs.
> >
> >Preferably this information is included in the ACPI namespace.
> 
> The idea is use the single platform_data struct  and initiaze it 
> accordingly from the driver's __init call based on the board/platform.

In general, you should think of it as being isolated from the board or
platform question, and not rely on an an initcall to do this for you.
A device driver, in particular for a device on something like an i2c
bus, should be able to figure out all the dependencies in its own
probe() function, without code on the platform side or in a specific
driver initcall.

What information it needs of course depends on the specific device,
but if you boot using FDT or ACPI, all the information you need should
be encoded in the data passed from the boot loader in a generic and
documented fashion. What data specifically do you want to pass here
that was previously encoded in platform data?

	Arnd
