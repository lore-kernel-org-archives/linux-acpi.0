From: Maciek Rutecki <maciej.rutecki@gmail.com>
Subject: Re: Disk spin down issue on shut down/suspend to disk
Date: Sun, 09 Sep 2007 11:20:17 +0200
Message-ID: <46E3BAD1.4080709@gmail.com>
References: <838f88840708051428p3d65ff42w627af4bc38f57de3@mail.gmail.com> <838f88840708051433k6deed4bdg8d411e79c629ca49@mail.gmail.com> <6bffcb0e0709080832o30fb21b5vcd09baa8387efcc0@mail.gmail.com> <200709082329.57811.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:50075 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754567AbXIIJUW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Sep 2007 05:20:22 -0400
Received: by ug-out-1314.google.com with SMTP id z38so384841ugc
        for <linux-acpi@vger.kernel.org>; Sun, 09 Sep 2007 02:20:21 -0700 (PDT)
In-Reply-To: <200709082329.57811.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, =?ISO-8859-2?Q?Micha=B3_sed?= <sedmich@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, htejun@gmail.com, hmh@hmh.eng.br, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

Rafael J. Wysocki pisze:
>> Shutdown is completely broken on HP NX6??? laptops.
> 
> It's not completely broken, it just handles disks incorrectly and we are not
> sure whether or not there are any serious consequences of that.  Moreover,
> it has happened for a long time now, AFAICT, so that's not a regression.

Maybe it isn't regression, we can call it no matter how, but this issue
can shorten disk live.


-- 
Maciej Rutecki
http://www.maciek.unixy.pl
