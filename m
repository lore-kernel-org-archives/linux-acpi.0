From: Andika Triwidada <andika@startrek.or.id>
Subject: Re: drivers for Lenovo 3000 series?
Date: Wed, 15 Apr 2009 02:52:21 +0700
Message-ID: <d0cc17060904141252q721daf9cp1f3a6a6667394f9a@mail.gmail.com>
References: <d0cc17060904120051h11e44079u5cf8174466b4e71e@mail.gmail.com>
	 <1239586069.5564.9.camel@localhost.localdomain>
	 <d0cc17060904141231k6613d79cldbb124162b3f57f7@mail.gmail.com>
	 <20090414193340.GA8304@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:42316 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696AbZDNTwV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Apr 2009 15:52:21 -0400
Received: by wf-out-1314.google.com with SMTP id 29so2806408wff.4
        for <linux-acpi@vger.kernel.org>; Tue, 14 Apr 2009 12:52:21 -0700 (PDT)
In-Reply-To: <20090414193340.GA8304@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: yakui_zhao <yakui.zhao@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, Apr 15, 2009 at 2:33 AM, Matthew Garrett <mjg59@srcf.ucam.org> =
wrote:
> On Wed, Apr 15, 2009 at 02:31:35AM +0700, Andika Triwidada wrote:
>
>> =A0/sys/class/backlight/acpi_video0/brightness exist, I can write an=
d
>> the value kept,
>> but no effect on display brightness.
>
> Is this an Intel graphics machine? Is the i915 driver loaded?

yes and yes

$ lspci -nn|egrep '(VGA|Disp)'
00:02.0 VGA compatible controller [0300]: Intel Corporation Mobile 4
Series Chipset Integrated Graphics Controller [8086:2a42] (rev 07)
00:02.1 Display controller [0380]: Intel Corporation Mobile 4 Series
Chipset Integrated Graphics Controller [8086:2a43] (rev 07)

$ lsmod|grep 915
i915                   44928  2
drm                   110304  3 i915
intel_agp              39152  1

Regards,
Andika
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
