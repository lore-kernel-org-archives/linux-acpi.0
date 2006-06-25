From: "Miles Lane" <miles.lane@gmail.com>
Subject: Re: 2.6.17-mm2 -- Slab corruption, plus invalid opcode: 0000 [#1] -- 4K_STACKS PREEMPT -- last sysfs file: /block/md0/dev
Date: Sun, 25 Jun 2006 13:08:01 -0700
Message-ID: <a44ae5cd0606251308k258eafdfpfc23ca2ad96fc3ad@mail.gmail.com>
References: <a44ae5cd0606241628u18fc9530g9dfbbfca441309fc@mail.gmail.com>
	 <20060624212940.ea8976ae.akpm@osdl.org>
	 <a44ae5cd0606251153j1220f8f5rd5fc6ab85027e3d0@mail.gmail.com>
	 <20060625120026.513a6076.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:49759 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932239AbWFYUIC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 25 Jun 2006 16:08:02 -0400
Received: by py-out-1112.google.com with SMTP id t32so1239657pyc
        for <linux-acpi@vger.kernel.org>; Sun, 25 Jun 2006 13:08:01 -0700 (PDT)
In-Reply-To: <20060625120026.513a6076.akpm@osdl.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On 6/25/06, Andrew Morton <akpm@osdl.org> wrote:

> Do you have
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm2/hot-fixes/cpufreq_register_driver-section-fix.patch
> applied?

Great!  That fixed it.  Thanks.

I still have this showing up:

Slab corruption: start=f021ed10, len=1424
030: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 56 9f fb 54
060: 6b 6b 6b 6b 05 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b
Prev obj: start=f021e780, len=1424
000: 02 00 00 00 00 c0 82 f4 02 00 00 00 00 00 40 00
010: 00 00 00 00 ff ff ff ff 80 00 00 00 76 00 00 00
Next obj: start=f021f2a0, len=1424
000: 00 00 00 00 00 50 01 f3 02 00 00 00 40 20 40 00
010: 00 00 00 00 ff ff ff ff 80 00 00 00 75 00 00 00
