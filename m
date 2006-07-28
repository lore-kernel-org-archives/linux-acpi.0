From: "Shem Multinymous" <multinymous@gmail.com>
Subject: Re: Generic battery interface
Date: Fri, 28 Jul 2006 03:10:56 +0300
Message-ID: <41840b750607271710r6b3cfffdjc5ca60d0f1618284@mail.gmail.com>
References: <CFF307C98FEABE47A452B27C06B85BB601168A85@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:30840 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750749AbWG1AK5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Jul 2006 20:10:57 -0400
Received: by ug-out-1314.google.com with SMTP id m3so539291ugc
        for <linux-acpi@vger.kernel.org>; Thu, 27 Jul 2006 17:10:56 -0700 (PDT)
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB601168A85@hdsmsx411.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Pavel Machek <pavel@suse.cz>, Matthew Garrett <mjg59@srcf.ucam.org>, vojtech@suse.cz, kernel list <linux-kernel@vger.kernel.org>, linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org

On 7/28/06, Brown, Len <len.brown@intel.com> wrote:
> I'm not religious about /dev vs. /sys.

I would greatly prefer a sysfs interface.
Having a clean, textual sysfs API that's easily accessed from shell
has been extremely conductive for the development of the tp_smapi
driver -- users can easily test and script the driver without extra
programming and userspace components. Since tp_smapi is (AFAIK) the
most feature-rich battery driver we now have, this is some to
consider.

(If you're not convinced yet, let me say one word: udev.)

  Shem
