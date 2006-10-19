From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: speedstep-centrino: ENODEV
Date: Thu, 19 Oct 2006 18:06:11 +0200
Message-ID: <4537A273.4050907@gmail.com>
References: <EB12A50964762B4D8111D55B764A8454C1A2D8@scsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from av1.karneval.cz ([81.27.192.123]:53039 "EHLO av1.karneval.cz")
	by vger.kernel.org with ESMTP id S1946158AbWJSQGQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Oct 2006 12:06:16 -0400
In-Reply-To: <EB12A50964762B4D8111D55B764A8454C1A2D8@scsmsx413.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: =?UTF-8?B?U3VuZSBNw7hsZ2FhcmQ=?= <sune@molgaard.org>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

Pallipadi, Venkatesh wrote:
> No. As in 2.6.18, speedstep-centrino and acpi-cpufreq are  two different drivers/modules that support Enhanced Speedstep in slightly different ways. It depends on your platform/BIOS on which one will work for your system. So you should try loading both those drivers in that order. If you have both compiled in the kernel, these drivers will be loaded (or tried to) in proper order. Please try this with the latest stable 2.6.18 kernel.

Thanks, I'll try later.

> Also, can both of you send the complete acpidump output from your system. You can find acpidump in latest version of pmtools package here: http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

May be obtained over there:

[...]

>>>> processor, but speedstep-centrino returns ENODEV because of 
>>>> lack of _PCT et al 
>>>> entries in DSDT (http://www.fi.muni.cz/~xslaby/sklad/adump). 
----------------------^^^^

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
