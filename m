From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v6 5/5] ACPICA: Remove PCI bits from ACPICA when
 CONFIG_PCI is unset
Date: Wed, 12 Dec 2018 14:34:27 -0500
Message-ID: <39dc076f-1b3d-ad0c-c4bb-056ac589f361@kernel.org>
References: <20181212171941.7437-1-okaya@kernel.org>
 <20181212171941.7437-6-okaya@kernel.org>
 <CF6A88132359CE47947DB4C6E1709ED53C556B2C@ORSMSX122.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53C556B2C@ORSMSX122.amr.corp.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Schmauss, Erik" <erik.schmauss@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 12/12/2018 2:02 PM, Schmauss, Erik wrote:
>> ++ b/drivers/acpi/acpica/achware.h
>> @@ -109,8 +109,17 @@ acpi_hw_enable_runtime_gpe_block(struct
>> acpi_gpe_xrupt_info *gpe_xrupt_info,
> CONFIG_PCI is a Linux-ism. We should stay with the OS-independent nature of
> ACPICA. Please use ACPI_PCI_CONFIGURED and put it above the comment like so:
> 
> #ifdef ACPI_PCI_CONFIGURED

Thanks for the feedback. My search for ACPI_PCI_CONFIGURED returned nothing.

git grep ACPI_PCI_CONFIGURED

@Rafael,

How do you want to handle this?
