From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: [patch 2/6] acpi: check _PSS invalidation when BIOS report _PSS
 with 0x80000000
Date: Fri, 9 Jan 2009 13:31:18 -0800
Message-ID: <7E82351C108FA840AB1866AC776AEC4643B5888C@orsmsx505.amr.corp.intel.com>
References: <200901092017.n09KH9OP014905@imap1.linux-foundation.org>
	<alpine.LFD.2.00.0901091559120.16697@localhost.localdomain>
 <20090109132355.b3a3c4dc.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:60555 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757560AbZAIVaj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 16:30:39 -0500
In-Reply-To: <20090109132355.b3a3c4dc.akpm@linux-foundation.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Song, Youquan" <youquan.song@intel.com>



>-----Original Message-----
>From: Andrew Morton [mailto:akpm@linux-foundation.org]
>Sent: Friday, January 09, 2009 1:24 PM
>To: Len Brown
>Cc: linux-acpi@vger.kernel.org; Song, Youquan; Pallipadi, Venkatesh
>Subject: Re: [patch 2/6] acpi: check _PSS invalidation when
>BIOS report _PSS with 0x80000000
>
>On Fri, 09 Jan 2009 16:01:47 -0500 (EST)
>Len Brown <lenb@kernel.org> wrote:
>
>> I recall nacking this one some time ago.
>
>Well please treat it as a bug report then.  "the kernel will boot
>crash when load cpufreq govenors".  Bad!
>

I think this should be a special case even when it is not defined in spec.

There is BIOS code out there that is giving 0x80000000 and Linux fails to
boot on these systems, where as the other OS does not. Existence of even one
such system means that the code will surely be copied onto other BIOSes and
I don't think we can persuade BIOS guys to change this.

Thanks,
Venki
