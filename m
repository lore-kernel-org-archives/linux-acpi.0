From: "Shem Multinymous" <multinymous@gmail.com>
Subject: Re: Generic battery interface
Date: Fri, 28 Jul 2006 18:19:46 +0300
Message-ID: <41840b750607280819t71f55ea7off89aa917421cc33@mail.gmail.com>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
	 <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com>
	 <20060727232427.GA4907@suse.cz>
	 <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com>
	 <20060728074202.GA4757@suse.cz>
	 <d120d5000607280525x447e6821t734a735197481c18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:43504 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751990AbWG1PTx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Jul 2006 11:19:53 -0400
Received: by ug-out-1314.google.com with SMTP id m3so812458ugc
        for <linux-acpi@vger.kernel.org>; Fri, 28 Jul 2006 08:19:47 -0700 (PDT)
In-Reply-To: <d120d5000607280525x447e6821t734a735197481c18@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>, Matthew Garrett <mjg59@srcf.ucam.org>, kernel list <linux-kernel@vger.kernel.org>, linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org

On 7/28/06, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 4) sysfs - all capabilities, IDs, etc for input devices exported there as well.

Forgive my ignorance, but how do I conncet a sysfs directory with a /dev device?
So far the only way I found is to compare /sys/whatever/dev with the
major+minor of the dev file, which requires brute-force enumeration on
at least one side.

  Shem
