From: Sergey Yanovich <ynvich@gmail.com>
Subject: Re: [PATCH 6/7] [sony-laptop] add control over wifi power in Sony
 laptops
Date: Mon, 03 Nov 2008 12:55:50 +0200
Message-ID: <490ED8B6.8000206@gmail.com>
References: <1225705280-12775-1-git-send-email-malattia@linux.it> <1225705280-12775-2-git-send-email-malattia@linux.it> <1225705280-12775-3-git-send-email-malattia@linux.it> <1225705280-12775-4-git-send-email-malattia@linux.it> <1225705280-12775-5-git-send-email-malattia@linux.it> <1225705280-12775-6-git-send-email-malattia@linux.it> <1225705280-12775-7-git-send-email-malattia@linux.it> <20081103103218.GA28263@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:11491 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755129AbYKCK4D (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Nov 2008 05:56:03 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1670511ugf.37
        for <linux-acpi@vger.kernel.org>; Mon, 03 Nov 2008 02:55:59 -0800 (PST)
In-Reply-To: <20081103103218.GA28263@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Mattia Dongili <malattia@linux.it>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Matthew Garrett wrote:
> On Mon, Nov 03, 2008 at 06:41:19PM +0900, Mattia Dongili wrote:
> 
>> Sony laptops have a single hardware rfkill switch, which controls
>> several wireless devices: wifi, bluetooth, wwan. The code to
>> selectively control bluetooth and wwan is already present. This
>> patch adds handling of wifi.

My Vaio VGN-TX770P has ipw2200, which IIUC understands hardware rfkill 
switch state. At the same time, when there is no wifi network around and 
I am on internal GRPS modem link, I would like global switch to be on, 
but wifi to be off. The main reason is to save power. The device has a 
dedicated key combination for this, on which Windows drivers by Sony 
operates.

> Please don't add more custom radio control switches. It'd be better to 
> add rfkill support. Otherwise we have even more stuff in /sys to carry 
> around for ages before deprecating.

Do you mean that the patch should use some other file instead of 
/sys/devices/platform/sony-laptop/wifipower for input/output?

If so, could you please provide some pointers on what should be done, 
and where in the source tree to look for references?

-- 
Cheers,
Sergey Yanovich
