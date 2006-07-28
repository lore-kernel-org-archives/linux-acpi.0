From: "Shem Multinymous" <multinymous@gmail.com>
Subject: Re: Generic battery interface
Date: Sat, 29 Jul 2006 01:10:40 +0300
Message-ID: <41840b750607281510j2c5babf8x9fac51fe6910aeda@mail.gmail.com>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
	 <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com>
	 <20060727232427.GA4907@suse.cz>
	 <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com>
	 <20060728074202.GA4757@suse.cz> <20060728122508.GC4158@elf.ucw.cz>
	 <20060728134307.GD29217@suse.cz>
	 <41840b750607280838s3678299fm8a5d2b46c5b2af06@mail.gmail.com>
	 <200607281557.k6SFvn09022794@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:57723 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751364AbWG1WKm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Jul 2006 18:10:42 -0400
Received: by ug-out-1314.google.com with SMTP id m3so964536ugc
        for <linux-acpi@vger.kernel.org>; Fri, 28 Jul 2006 15:10:41 -0700 (PDT)
In-Reply-To: <200607281557.k6SFvn09022794@turing-police.cc.vt.edu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@suse.cz>, "Brown, Len" <len.brown@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, kernel list <linux-kernel@vger.kernel.org>, linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org

On 7/28/06, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> Is there a reliable (or hack-worthy) way for the kernel to determine how
> often the values are re-posted by the hardware?

That's hardware-specific. Some drivers can know, others may just
assume 1sec or 0.1sec or whatever.

  Shem
