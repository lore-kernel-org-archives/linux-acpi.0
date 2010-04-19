From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: MacBookPro2,2 unable too boot with the latest HEAD
Date: Mon, 19 Apr 2010 15:09:10 -0700
Message-ID: <4BCCD486.9050006@gmail.com>
References: <i2vdd18b0c31004140812i6a0e9430u68ab49b24273fe9b@mail.gmail.com>	<20100419142804.3cd53666.akpm@linux-foundation.org>	<4BCCCCDF.4010605@gmail.com> <20100419145741.95688467.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yx0-f171.google.com ([209.85.210.171]:65009 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319Ab0DSWHt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Apr 2010 18:07:49 -0400
In-Reply-To: <20100419145741.95688467.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>

On 04/19/2010 02:57 PM, Andrew Morton wrote:
> On Mon, 19 Apr 2010 14:36:31 -0700
> "Justin P. Mattock"<justinmattock@gmail.com>  wrote:
>
>> On 04/19/2010 02:28 PM, Andrew Morton wrote:
>>> On Wed, 14 Apr 2010 08:12:57 -0700
>>> Justin Mattock<justinmattock@gmail.com>   wrote:
>>>
>>>> Just noticed this this morning,
>>>> system can only boot up when I take the battery
>>>> out.(when the battery is plugged in this(below)
>>>> shows up, and if booting no go)
>>>>
>>>> [  169.207193] divide error: 0000 [#1] SMP
>>>> [  169.207203] last sysfs file: /sys/devices/platform/applesmc.768/light
>>>> [  169.207208] CPU 0
>>>> [  169.207212] Modules linked in: rfcomm sco radeon bnep l2cap ttm
>>>> drm_kms_helper drm ipt_LOG iptable_nat nf_nat xt_state
>>>> nf_conntrack_ftp nf_conntrack_ipv4 nf_conntrack nf_defrag_ipv4
>>>> iptable_filter ip_tables x_tables btusb bluetooth firewire_ohci ath9k
>>>> firewire_core ath9k_common video battery ac ath9k_hw evdev joydev
>>>> ohci1394 ath button thermal sky2 i2c_i801 raw1394 ieee1394 uhci_hcd
>>>> ehci_hcd coretemp acpi_cpufreq processor appletouch applesmc uvcvideo
>>>> [  169.207303]
>>>> [  169.207310] Pid: 182, comm: kacpi_notify Not tainted
>>>> 2.6.34-rc3-00502-gd3b0936 #42 Mac-F42187C8/MacBookPro2,2
>>>> [  169.207316] RIP: 0010:[<ffffffff81237e43>]  [<ffffffff81237e43>]
>>>> acpi_ex_extract_from_field+0xb1/0x24a
>>>
>>> Presumably acpi_ex_extract_from_field() fed zero into (the misnamed)
>>> ACPI_ROUND_UP_TO().
>>>
>>> I'll ask Rafael and Maciej to track this as a post-26.33 regression,
>>> thanks.
>>>
>>>
>>
>> the patch here fixes it for me:ACPI: EC: Limit burst to 64 bit
>> https://bugzilla.kernel.org/attachment.cgi?id=25962
>
> hm.  I wonder how you go from a bugzilla attachment back up tot he bug
> to which it is attached?

I don't know.. maybe backwards thinking(me lefthanded people
suffer from things of that nature).

>
> Oh well.  Alexey, I trust that patch is in the 2.6.34 queue?
>
> Thanks.
>


cool..

Justin P. Mattock
