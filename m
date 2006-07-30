From: "Shem Multinymous" <multinymous@gmail.com>
Subject: Re: Generic battery interface
Date: Sun, 30 Jul 2006 13:34:06 +0300
Message-ID: <41840b750607300334g2e9cbd56i2b4e5bad285e09c0@mail.gmail.com>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
	 <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com>
	 <20060727232427.GA4907@suse.cz>
	 <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com>
	 <20060728074202.GA4757@suse.cz>
	 <41840b750607280814x50db03erb30d833802ae983e@mail.gmail.com>
	 <20060728202359.GB5313@suse.cz>
	 <41840b750607281548h5ee2219eka1de6745b692c092@mail.gmail.com>
	 <41840b750607291406p2f843054rc89fa1c3c467688d@mail.gmail.com>
	 <20060730100559.GA1920@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:776 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932241AbWG3KeI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Jul 2006 06:34:08 -0400
Received: by ug-out-1314.google.com with SMTP id m3so333653ugc
        for <linux-acpi@vger.kernel.org>; Sun, 30 Jul 2006 03:34:06 -0700 (PDT)
In-Reply-To: <20060730100559.GA1920@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Vojtech Pavlik <vojtech@suse.cz>, "Brown, Len" <len.brown@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, kernel list <linux-kernel@vger.kernel.org>, linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@debian.org>, Mark Underwood <basicmark@yahoo.com>, Jean Delvare <khali@linux-fr.org>

On 7/30/06, Pavel Machek <pavel@suse.cz> wrote:

> Are there any plans at merging tp_smapi, BTW? After fixing few minor
> details (like removing " mV" from files)... it looks like it would fit
> into hwmon infrastructure rather nicely.

Yes, it will definitely be submitted once stable. We're still tweaking
some stuff, such as whitelisting (see "[PATCH] DMI: Decode and save
OEM String information").

BTW, I'll rename the modules to "thinkpad_ec" for basic EC functions
(also used by the patched hdaps), and probably "thinkpad_battery" or
"thinkpad_hwmon" for the rest. Not sure about the latter: we happen to
be doing only battery stuff at the moment but this is likely to change
in the future.

Is "hwmon" suitable for something that *contols* battery charging too,
and might have extra attributes tacked on as we unravel additional
ThinkPad firmware capabilities?

  Shem
