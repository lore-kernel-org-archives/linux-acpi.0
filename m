From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Dec 21 (acpi without CONFIG_PCI)
Date: Fri, 21 Dec 2018 08:37:04 -0800
Message-ID: <6d1dca14-f0e7-7866-cb97-b3bbc57cdc8e@infradead.org>
References: <20181221193244.3a6ed685@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181221193244.3a6ed685@canb.auug.org.au>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sinan Kaya <okaya@kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 12/21/18 12:32 AM, Stephen Rothwell wrote:
> Hi all,
> 
> News: there will be no linux-next release until Jan 2.  Have a good break.
> 
> Changes since 20181220:
> 

on i386 or x86_64:

../drivers/acpi/acpi_lpss.c: In function 'acpi_lpss_find_device':
../drivers/acpi/acpi_lpss.c:538:26: error: 'pci_bus_type' undeclared (first use in this function)
  return bus_find_device(&pci_bus_type, NULL, &data, match_hid_uid);
                          ^
../drivers/acpi/acpi_lpss.c:538:26: note: each undeclared identifier is reported only once for each function it appears in
../drivers/acpi/acpi_lpss.c:539:1: warning: control reaches end of non-void function [-Wreturn-type]
 }
 ^

when CONFIG_PCI is not set/enabled.



-- 
~Randy
