From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: [PATCH] ibm-acpi-0.6 - ACPI driver for IBM ThinkPad laptops
Date: Thu, 21 Oct 2004 17:04:59 +0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <3ACA40606221794F80A5670F0AF15F84041ABFD4@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S269079AbUJUJLP@vger.kernel.org>
Content-class: urn:content-classes:message
To: Borislav Deianov <borislav@users.sourceforge.net>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

>
>On Wed, Oct 20, 2004 at 11:18:08AM +0800, Yu, Luming wrote:
>> 
>> I'm working on a generic hotkey driver, which will move configurable 
>> stuff to user space. 
>[snip]
>> 1. add a new hotkey:
>>  echo "0 : _SB.VGA : _SB.VGA.LCD._BCM :0x86 : 0x86" >
>> /proc/acpi/ev_config
>
>How would user space know what devices and methods to use? In the
>kernel, you can use HIDs where available, or check for specific
>objects with acpi_get_handle(). Are you going to expose these to user
>space somehow?
>
>Boris
>

Wrt hotkey, there don't have any standard or well known method to
find out which acpi device and acpi methods are for which hotkey.
But, they are working in the similar way, which is achieving hotkey 
function through acpi generic core. 

So, at the first stage , I have to rely on user or vendor to supply 
meaningful data, till we have standard auto-config method.

Thanks,
Luming
