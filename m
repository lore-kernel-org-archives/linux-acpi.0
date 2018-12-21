From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Dec 21 (acpi without CONFIG_PCI)
Date: Fri, 21 Dec 2018 09:26:40 -0800
Message-ID: <9cdc8072-101f-b683-02a1-8d57fda57b7e@infradead.org>
References: <20181221193244.3a6ed685@canb.auug.org.au>
 <6d1dca14-f0e7-7866-cb97-b3bbc57cdc8e@infradead.org>
 <CAK9iUCO_Pk3eYH+hyMuqU6weDsbzC9Sg1Z719fm8u_3Oh7s-iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK9iUCO_Pk3eYH+hyMuqU6weDsbzC9Sg1Z719fm8u_3Oh7s-iQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <Okaya@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 12/21/18 9:23 AM, Sinan Kaya wrote:
> 
> 
> On Friday, December 21, 2018, Randy Dunlap <rdunlap@infradead.org <mailto:rdunlap@infradead.org>> wrote:
> 
>     On 12/21/18 12:32 AM, Stephen Rothwell wrote:
>     > Hi all,
>     >
>     > News: there will be no linux-next release until Jan 2.  Have a good break.
>     >
>     > Changes since 20181220:
>     >
> 
>     on i386 or x86_64:
> 
>     ../drivers/acpi/acpi_lpss.c: In function 'acpi_lpss_find_device':
>     ../drivers/acpi/acpi_lpss.c:538:26: error: 'pci_bus_type' undeclared (first use in this function)
>       return bus_find_device(&pci_bus_type, NULL, &data, match_hid_uid);
>                               ^
> 
> 
> This needs to be closed by #ifdef CONFIG_PCI
> 
> Any other issues? 
> 

I saw a few others but I am still trying to see if they are real or not. ;)

>  
> 
>     ../drivers/acpi/acpi_lpss.c:538:26: note: each undeclared identifier is reported only once for each function it appears in
>     ../drivers/acpi/acpi_lpss.c:539:1: warning: control reaches end of non-void function [-Wreturn-type]
>      }
>      ^
> 
>     when CONFIG_PCI is not set/enabled.
> 
> 
> 
>     -- 
>     ~Randy
> 


-- 
~Randy
