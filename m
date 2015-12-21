From: Jon Masters <jonathan@jonmasters.org>
Subject: Re: overriding ACPI _CRS method
Date: Mon, 21 Dec 2015 02:59:49 -0500
Message-ID: <5677B175.6040800@jonmasters.org>
References: <1448794735.18592.0@outlook-emeawest.office365.com>	<1AE640813FDE7649BE1B193DEA596E883BAFA0F9@SHSMSX101.ccr.corp.intel.com> <1448853801.18315.0@outlook-emeawest.office365.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448853801.18315.0@outlook-emeawest.office365.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel J Blueman <daniel@numascale.com>, "Zheng, Lv" <lv.zheng@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Steffen Persvold <sp@numascale.com>, Myron Stowe <myron.stowe@redhat.com>
List-Id: linux-acpi@vger.kernel.org

On 11/29/15, 10:23 PM, Daniel J Blueman wrote:
> On Mon, Nov 30, 2015 at 11:09 AM, Zheng, Lv <lv.zheng@intel.com> wrote:
>> Hi,
>>
>> IMO, if you want the new _CRS to be applied during the Linux early
>> boot stage, you can override the table using initrd override or DSDT
>> override mechanism.
>> Please see Documentation/acpi/initrd_table_override.txt or
>> Documentation/acpi/dsdt-override.txt.
>>
>> If you want the new _CRS to be applied during Linux runtime, you can
>> override it using method customization mechanism.
>> Please see Documentation/acpi/method-customizing.txt
>
> The reason I'm trying to adjust this in firmware, is to deliver the
> right behaviour with pre-built/distro kernels, so I can't use that
> approach.

The initrd method prepends an override initrd so you can use the stock 
distro one (obviously any such modification might impact whether a 
system vendor will support you in any case). This is in fact why I use 
an initrd override method on ARM servers to test ACPI fixes.

The other option you have is to use the "acpi" command in GRUB to 
provide an override set of tables pre-OS boot. Depending upon your OS, 
you might need to regenerate your (dracut) initramfs with that via the 
GRUB configuration file(s).

Jon.
