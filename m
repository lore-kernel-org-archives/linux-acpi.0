From: "Shem Multinymous" <multinymous@gmail.com>
Subject: Re: Generic battery interface
Date: Fri, 28 Jul 2006 03:35:10 +0300
Message-ID: <41840b750607271735v4330fd62yf37fdd418cab97e4@mail.gmail.com>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
	 <20060727221632.GE3797@elf.ucw.cz> <20060727233154.GB4907@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:61855 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750953AbWG1AfO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Jul 2006 20:35:14 -0400
Received: by ug-out-1314.google.com with SMTP id m3so545808ugc
        for <linux-acpi@vger.kernel.org>; Thu, 27 Jul 2006 17:35:11 -0700 (PDT)
In-Reply-To: <20060727233154.GB4907@suse.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Pavel Machek <pavel@suse.cz>, "Brown, Len" <len.brown@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, kernel list <linux-kernel@vger.kernel.org>, linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org

On 7/28/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
>   note: It's absolutely necessary to limit the API to a well usable
>         SUBSET of a superset of the features of all drivers/devices,
>         even sacrificing obscure features to keep the API sane. One
>         example would be the HID Power spec, which simply can't be
>         supported to full extent by any sane API.

Non-standard functions must be handled reasonably within the
framework, otherwise drivers will have to build duplicate interfaces.

How about
  /sys/whatever/battery0/voltage for standard attributes
and
  /sys/whatever/battery0/thinkpad/inhibit-charge-minutes
for non-standard ones?


>   + and the kernel can change the polling frequency based on power
>         saving state changes

Likewise for cached attributes (query hardware only if N jiffies
passed since last querry, other return cached value). And that way,
hardware query frequency is never higher than what userspace actually
needs.

  Shem
