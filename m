From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Date: Thu, 15 Nov 2018 17:49:28 -0800
Message-ID: <b9a739c8-80bd-e04c-ac19-97bc54f20eff@kernel.org>
References: <20181115231605.24352-1-mr.nuke.me@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181115231605.24352-1-mr.nuke.me@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: austin_bolen@dell.com, alex_gagniuc@dellteam.com, keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Russell Currey <ruscur@russell.cc>, Sam Bobroff <sbobroff@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-acpi@vger.kernel.org

On 11/15/2018 3:16 PM, Alexandru Gagniuc wrote:
> I've asked around a few people at Dell and they unanimously agree that
> _OSC is the correct way to determine ownership of AER. In linux, we
> use the result of _OSC to enable AER services, but we use HEST to
> determine AER ownership. That's inconsistent. This series drops the
> use of HEST in favor of _OSC.
> 
> [1]https://lkml.org/lkml/2018/11/15/62

This change breaks the existing systems that rely on the HEST table
telling the operating system about firmware first presence.

Besides, HEST table has much more granularity about which PCI component
needs firmware such as global/device/switch.

You should probably circulate these ideas for wider consumption in UEFI
forum as UEFI owns the HEST table definition.
