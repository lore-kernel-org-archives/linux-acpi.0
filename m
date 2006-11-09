From: "Yinghai Lu" <yinghai.lu@amd.com>
Subject: Re: 2.6.19-rc5 x86_64 irq 22: nobody cared
Date: Wed, 8 Nov 2006 23:55:03 -0800
Message-ID: <86802c440611082355q67c69da2v316062bbe0170a9@mail.gmail.com>
References: <4551D12D.4010304@trollprod.org> <20061109064956.GG4729@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:48270 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1754240AbWKIHzF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Nov 2006 02:55:05 -0500
Received: by ug-out-1314.google.com with SMTP id m3so145427ugc
        for <linux-acpi@vger.kernel.org>; Wed, 08 Nov 2006 23:55:03 -0800 (PST)
In-Reply-To: <20061109064956.GG4729@stusta.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Olivier Nicolas <olivn@trollprod.org>, Stephen Hemminger <shemminger@osdl.org>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz, len.brown@intel.com, linux-acpi@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>

olivier,

lspci -vvxxx please.

it seems usb and audio share the interrtupts by ioapic.

YH
