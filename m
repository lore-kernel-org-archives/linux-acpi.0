From: Stephen Clark <Stephen.Clark@seclark.us>
Subject: Re: Error calling BSTS
Date: Tue, 05 Dec 2006 12:13:49 -0500
Message-ID: <4575A8CD.2070602@seclark.us>
References: <4570BECB.5050502@seclark.us> <200612041856.48871.corentincj@iksaif.net> <4574CE67.2000302@seclark.us> <200612050804.44486.corentincj@iksaif.net>
Reply-To: Stephen.Clark@seclark.us
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpout06-01.prod.mesa1.secureserver.net ([64.202.165.224]:44472
	"HELO smtpout06-04.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S968459AbWLEROA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Dec 2006 12:14:00 -0500
In-Reply-To: <200612050804.44486.corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: corentincj@iksaif.net
Cc: linux-acpi@vger.kernel.org

Corentin CHARY wrote:

>>ACPI: AC Adapter [AC0] (on-line)
>>Asus Laptop ACPI Extras version 0.31b2
>>  Error calling BSTS
>>  Z96F model detected, supported
>>    
>>
>
>The Error is "normal" .. It will be fixed ...
>Now files is /proc/acpi/asus/ should work (and maybe /sys/class/backlight/ if 
>you kernel support it).
>  
>

I don't see a /sys/class/backlight - so it must not be configured in the 
kernel.

Thanks,
Steve

-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



