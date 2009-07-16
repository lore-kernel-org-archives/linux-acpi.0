From: "Cai, Crane" <crane.cai@amd.com>
Subject: Re: [PATCH] ACPI: add driver for SMBus Control Method Interface
Date: Thu, 16 Jul 2009 09:23:10 +0800
Message-ID: <20090716012310.GA5806@crane-desktop>
References: <20090715060219.GA30514@crane-desktop> <1247651002.4113.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756921AbZGPBXZ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1247651002.4113.9.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: Crane Cai <crane.cai@amd.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jul 15, 2009 at 05:43:22PM +0800, ykzhao wrote:
> On Wed, 2009-07-15 at 14:02 +0800, Crane Cai wrote:
>> This driver supports the SMBus Control Method Interface. It needs BIOS declare
>> ACPI control methods via SMBus Control Method Interface Spec.
> It seems that SM bus control is realized in BIOS. And OS can use the
> given control method interface to access it. 
> Will this controller be accessed directly directly BIOS?
Controller accessed by ACPI control method, the control method is called by OS.

> If it can be accessed by BIOS, how to resolve the conflict between BIOS
> and OS?
About conflicts see next question's answer.
> 
> In fact we see the conflict on some boxes. The SMbus controller will be
> accessed by BIOS. If the corresponding driver is loaded for the SMBUS
> controller, there exists the potential risk. In such case we will hide
> the SMbus controller or not load the device driver for it.
About conflicts, 
CMI driver access SMBus host controller via ACPI control methods. Its related 
resource will be declared in ACPI region. Its controll methods will be insured 
by BIOS.
Native PCI interface SMBus host controller driver such as i2c-piix4.c, its
resource is in PCI region. Its access methods is in its driver.
So, CMI driver & native PCI interface driver use different resouces and methods
to access SMBus host controller. 2 different devices controlled by 2 different
drivers and no conflicts exists.

> 
> Thanks.

-- 
Best Regards,
- Crane
