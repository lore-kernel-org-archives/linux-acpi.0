From: Alex G <mr.nuke.me@gmail.com>
Subject: Re: [PATCH v1 1/3] PCI / ACPI: Do not export pci_get_hp_params()
Date: Mon, 22 Apr 2019 18:45:27 -0500
Message-ID: <0b2b2396-b60b-ad25-d4ab-e3633fd93d0c@gmail.com>
References: <20190208162414.3996-1-mr.nuke.me@gmail.com>
 <20190208162414.3996-2-mr.nuke.me@gmail.com>
 <20190422205845.GM173520@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190422205845.GM173520@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: austin_bolen@dell.com, alex_gagniuc@dellteam.com, keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de, okaya@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 4/22/19 3:58 PM, Bjorn Helgaas wrote:
> On Fri, Feb 08, 2019 at 10:24:11AM -0600, Alexandru Gagniuc wrote:
>> This is only used within drivers/pci, and there is no reason to make
>> it available outside of the PCI core.
>>
>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> 
> Applied the whole series to pci/hotplug for v5.2, thanks!
> 
> I dropped the "list" member from struct hpx_type3 because it didn't
> seem to be used.

That's a good call. That was a vestigial appendage from when I first 
intended to store a list of registers in memory. I'm glad we didn't end 
up needing a list.

Alex
