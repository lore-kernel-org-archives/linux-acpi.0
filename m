From: Edgar Hucek <hostmaster@ed-soft.at>
Subject: Re: ACPI Troubles with 2.6.16-rc3
Date: Fri, 17 Feb 2006 08:32:14 +0100
Message-ID: <43F57BFE.6080402@ed-soft.at>
References: <59D45D057E9702469E5775CBB56411F101A9E4C7@pdsmsx406>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]:63689
	"EHLO mognix.dark-green.com") by vger.kernel.org with ESMTP
	id S932572AbWBQHcT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 17 Feb 2006 02:32:19 -0500
In-Reply-To: <59D45D057E9702469E5775CBB56411F101A9E4C7@pdsmsx406>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org

The patch crashes the Kernel. I cannot say where, because
i have no console output at this time on boot.

cu

Edgar

Li, Shaohua wrote:
> looks like the acpi_os_unmap_memory hasn't the corresponding code to
> acpi_os_map_memory's one code path. Does the attached workaround change
> anything?
> 
> Thanks,
> Shaohua
> 
>> -----Original Message-----
>> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>> owner@vger.kernel.org] On Behalf Of Andrew Morton
>> Sent: Friday, February 17, 2006 10:53 AM
>> To: linux-acpi@vger.kernel.org
>> Cc: Edgar Hucek
>> Subject: Fw: ACPI Troubles with 2.6.16-rc3
>>
>>
>>
>> Begin forwarded message:
>>
>> Date: Thu, 16 Feb 2006 17:44:20 +0100
>> From: Edgar Hucek <hostmaster@ed-soft.at>
>> To: linux-kernel@vger.kernel.org
>> Subject: ACPI Troubles with 2.6.16-rc3
>>
>>
>> Hi.
>>
>> I have ACPI troubles :
>>
>> CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000140
> 0000c1a9
>> 00000000 00000000
>> Checking 'hlt' instruction... OK.
>> iounmap: bad address dfefd000
>> [<c0253684>] acpi_tb_get_table_header+0x67/0x92
>> [<c042a630>] unknown_bootoption+0x0/0x260
>> [<c02536c2>] acpi_tb_get_table+0x13/0x55  [<c02538b2>]
>> acpi_tb_get_table_rsdt+0x1f/0x99
>> [<c024e239>] acpi_ns_root_initialize+0x28a/0x299
>> [<c0253971>] acpi_load_tables+0x45/0xa9
>> [<c0443d56>] acpi_early_init+0x46/0xf6
>> [<c042a56d>] start_kernel+0x2fd/0x3c0
>> [<c042a630>] unknown_bootoption+0x0/0x260
>> iounmap: bad address dfefd000
>> [<c0253f2a>] acpi_tb_delete_single_table+0x30/0x33
>> [<c0252f37>] acpi_tb_convert_to_xsdt+0x8d/0xa3
>> [<c042a630>] unknown_bootoption+0x0/0x260
>> [<c0253900>] acpi_tb_get_table_rsdt+0x6d/0x99
>> [<c024e239>] acpi_ns_root_initialize+0x28a/0x299
>> [<c0253971>] acpi_load_tables+0x45/0xa9
>> [<c0443d56>] acpi_early_init+0x46/0xf6
>> [<c042a56d>] start_kernel+0x2fd/0x3c0
>> [<c042a630>] unknown_bootoption+0x0/0x260
>> iounmap: bad address dfefb000
>> [<c0253684>] acpi_tb_get_table_header+0x67/0x92
>> [<c0253b4e>] acpi_tb_get_required_tables+0x4b/0x1f1
>> [<c042a630>] unknown_bootoption+0x0/0x260
>> [<c0253db5>] acpi_tb_init_table_descriptor+0x3a/0x107
>> [<c0253911>] acpi_tb_get_table_rsdt+0x7e/0x99
>> [<c042a630>] unknown_bootoption+0x0/0x260
>> [<c0253986>] acpi_load_tables+0x5a/0xa9
>> [<c0443d56>] acpi_early_init+0x46/0xf6
>> [<c042a56d>] start_kernel+0x2fd/0x3c0
>>
>> Ataches is the full dmesg output.
>>
>> The machine is an Apple Intel iMac 17" Dual Core booted with
>> elilo.
>>
>> Any ideas ?
>>
>> thx
>>
>> Edgar Hucek
> 

