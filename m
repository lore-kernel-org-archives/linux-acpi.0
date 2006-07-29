From: "Shem Multinymous" <multinymous@gmail.com>
Subject: Re: Generic battery interface
Date: Sat, 29 Jul 2006 13:30:56 +0300
Message-ID: <41840b750607290330t35eab99fscef30fb46fdf4ec0@mail.gmail.com>
References: <20060727232427.GA4907@suse.cz> <20060728074202.GA4757@suse.cz>
	 <20060728122508.GC4158@elf.ucw.cz> <20060728134307.GD29217@suse.cz>
	 <41840b750607280838s3678299fm8a5d2b46c5b2af06@mail.gmail.com>
	 <200607281557.k6SFvn09022794@turing-police.cc.vt.edu>
	 <41840b750607281510j2c5babf8x9fac51fe6910aeda@mail.gmail.com>
	 <200607282314.k6SNESSg019274@turing-police.cc.vt.edu>
	 <41840b750607290248r5999d1fen41f9d3044d385857@mail.gmail.com>
	 <20060729101730.GA7438@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:37041 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1422737AbWG2Ka5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 29 Jul 2006 06:30:57 -0400
Received: by ug-out-1314.google.com with SMTP id m3so91327ugc
        for <linux-acpi@vger.kernel.org>; Sat, 29 Jul 2006 03:30:56 -0700 (PDT)
In-Reply-To: <20060729101730.GA7438@suse.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>, Pavel Machek <pavel@suse.cz>, "Brown, Len" <len.brown@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, kernel list <linux-kernel@vger.kernel.org>, linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org

On 7/29/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > The lazy polling approach I described in my last post to Vojtech
> > ("block until there's  a new readout or N milliseconds have passed,
> > whichever is later") looks like a more general, accurate and efficient
> > interface.
>
> If "N" is given by the kernel, then it's identical to an event-based
> approach. ;) Just described in different words.

No, N is given separately by each userspace client, on every call.
That's the whole point. The kernel driver then does the minimal
hardware querying and event generation that (a) makes sense for the
hardware and (b) satisfies all userspace clients.

  Shem
