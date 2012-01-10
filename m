From: Jamie Kitson <jamie@kitten-x.com>
Subject: Re: /sys/class/power_supply/BAT0/ charge_ vs energy_
Date: Tue, 10 Jan 2012 14:30:51 +0000
Message-ID: <CA+z-pWF+pvFrfJ8O9ddF6dXaK+Wo-WvUVX3uHuScEbbAn5qYhA@mail.gmail.com>
References: <CA+z-pWGrhtT3m=tOXcCDph3TC6AcbTVQJTF35V-o5MHeAB=HCg@mail.gmail.com>
 <CA+z-pWHyhVO16AGz-fxmDhTyO0xXGfOB-_pPQZjMqf4vBUZw_g@mail.gmail.com>
 <CA+z-pWHPj-_ZA0v+siLaVtwFtyd-tDFM5+71s3j6ng3=pWGu0Q@mail.gmail.com>
 <CA+z-pWGJ_sFh138kgZh-oX=rwv3t_LRDvgCvdGxuxnMDegxgaA@mail.gmail.com>
 <CA+z-pWEtiW9Rc9yjXNZSc7daFRwDieYb3Bnxt6=m+G+k_ELL8g@mail.gmail.com>
 <CA+z-pWGmiRvpYQWQwb-f9TjH18k1pvu1rbOPUuF1t9-m3HvHqA@mail.gmail.com>
 <CA+z-pWE9LmEiYDxVAbdR7GhO=C5fiDf1QozO2n4v0fQ4V6hrNQ@mail.gmail.com>
 <20120109133722.GA9981@srcf.ucam.org> <CA+z-pWEcv7ejAPbD+oLXdptf5h4xbZ4g4sxm0uuqxdGp7n7r4A@mail.gmail.com>
 <20120109213902.GB18923@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:43019 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756245Ab2AJObN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Jan 2012 09:31:13 -0500
Received: by wgbdt14 with SMTP id dt14so2677705wgb.1
        for <linux-acpi@vger.kernel.org>; Tue, 10 Jan 2012 06:31:12 -0800 (PST)
In-Reply-To: <20120109213902.GB18923@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

Could we not have a new generic file (or two) in the directory to
state battery level as a percentage, and perhaps another for warning
level as a percentage?

On 9 January 2012 21:39, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Mon, Jan 09, 2012 at 09:36:34PM +0000, Jamie Kitson wrote:
>> Thanks for your reply. Is this something that is likely to be fixed?
>
> You'd have to ask Lenovo. We report the statistics that the firmware
> gives us.
>
> --
> Matthew Garrett | mjg59@srcf.ucam.org
