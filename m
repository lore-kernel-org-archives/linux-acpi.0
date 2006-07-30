From: "Shem Multinymous" <multinymous@gmail.com>
Subject: Re: Generic battery interface
Date: Sun, 30 Jul 2006 14:48:07 +0300
Message-ID: <41840b750607300448u353a3276o8c30d7d880da6329@mail.gmail.com>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
	 <20060728074202.GA4757@suse.cz> <20060728122508.GC4158@elf.ucw.cz>
	 <20060728134307.GD29217@suse.cz>
	 <41840b750607280838s3678299fm8a5d2b46c5b2af06@mail.gmail.com>
	 <200607281557.k6SFvn09022794@turing-police.cc.vt.edu>
	 <41840b750607281510j2c5babf8x9fac51fe6910aeda@mail.gmail.com>
	 <200607282314.k6SNESSg019274@turing-police.cc.vt.edu>
	 <41840b750607290248r5999d1fen41f9d3044d385857@mail.gmail.com>
	 <200607300835.k6U8ZvSB016669@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:20828 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932293AbWG3LsI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Jul 2006 07:48:08 -0400
Received: by ug-out-1314.google.com with SMTP id m3so345496ugc
        for <linux-acpi@vger.kernel.org>; Sun, 30 Jul 2006 04:48:07 -0700 (PDT)
In-Reply-To: <200607300835.k6U8ZvSB016669@turing-police.cc.vt.edu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@suse.cz>, "Brown, Len" <len.brown@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, kernel list <linux-kernel@vger.kernel.org>, linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org

On 7/30/06, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> If the program says '100ms' because it knows it will need to do a GUI update
> then, and you block it for 5 seconds because that's when the next value
> update happens, the user is stuck looking at their gkrellm or whatever not
> doing anything at all for 4.9 seconds....
>
> This almost forces the use of multiple threads if the program wants to do
> its own timer management.

Please read my detailed proposal, posted (and resivsed) later.

The program is not blocked by the new ioctl, it still does a poll() or
select() and can provide a timeout, as usual. The only trick is that
the poll() won't return with an input-ready event until the
appropriate time.

  Shem
