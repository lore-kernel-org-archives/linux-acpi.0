From: Niel Lambrechts <niel.lambrechts@gmail.com>
Subject: Re: 2.6.30-rc1 (latest git): thinkpad-acpi: cannot control brightness
 with hotkeys
Date: Sun, 12 Apr 2009 00:44:59 +0200
Message-ID: <49E11D6B.3000001@gmail.com>
References: <49E10684.5090101@gmail.com> <20090411150555.8b13ed18.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f165.google.com ([209.85.219.165]:53910 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759050AbZDKWop (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Apr 2009 18:44:45 -0400
In-Reply-To: <20090411150555.8b13ed18.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "linux.kernel" <linux-kernel@vger.kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org

On 04/12/2009 12:05 AM, Andrew Morton wrote:
> (cc's added)
>
> On Sat, 11 Apr 2009 23:07:16 +0200 Niel Lambrechts <niel.lambrechts@gmail.com> wrote:
>
>   
>> Hi there,
>>
>> With latest git kernel, I'm no longer able to control my Thinkpad (W500)
>> brightness, although I can still control the backlight, bluetooth etc.
>>     
>
> So 2.6.29 was OK
Hi Andrew,

Yes - I quickly rebooted to 2.6.29.1, and it is working fine there ...

So these results are with both kernels using:
options thinkpad_acpi experimental=1

Thanks,
Niel
