From: Joshua Wise <joshua@joshuawise.com>
Subject: Re: CPU_IDLE prevents resuming from STR [was: Re: 2.6.21-rc6-mm1]
Date: Mon, 16 Apr 2007 22:50:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0704162243070.3859@dashnine.joshuawise.com>
References: <20070408143559.f5014629.akpm@linux-foundation.org>
 <20070413234513.GA2940@inferi.kami.home> <1176691227.6993.1.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 18.208-100-46.steadfast.net ([208.100.46.18]:48783 "EHLO
	dev.x-plane.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S965397AbXDQCs4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Apr 2007 22:48:56 -0400
In-Reply-To: <1176691227.6993.1.camel@sli10-conroe.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Mattia Dongili <malattia@linux.it>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

On Mon, 16 Apr 2007, Shaohua Li wrote:
> On Sat, 2007-04-14 at 01:45 +0200, Mattia Dongili wrote:
>> ...
> please check if the patch at
> http://marc.info/?l=linux-acpi&m=117523651630038&w=2 fixed the issue

I have the same system as Mattia, and when I applied this patch and turned
CPU_IDLE back on, I got a panic on boot. Unfortunately, the EIP scrolled off
screen, so I can't get a line number.

(I had the same STR breakage as him; STR did not work with CPU_IDLE turned
on, and it did work with CPU_IDLE turned off.)

I'm running +rc6+mm(April 11) on a Sony VAIO SZ.

joshua
