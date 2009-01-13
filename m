From: Martin Lucina <mato@kotelna.sk>
Subject: Re: [RFC] [PATCH] panasonic-laptop.c: add support for CD power
	management
Date: Tue, 13 Jan 2009 20:14:04 +0100
Message-ID: <20090113191402.GA4263@nodbug.moloch.sk>
References: <20090113163233.GA734@dezo.moloch.sk> <5e0a1fd80901130916x510395ddwdab40c867e32212b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from chrocht.moloch.sk ([62.176.169.44]:60897 "EHLO mail.moloch.sk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752040AbZAMTOJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 Jan 2009 14:14:09 -0500
Content-Disposition: inline
In-Reply-To: <5e0a1fd80901130916x510395ddwdab40c867e32212b@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Karthik Gopalakrishnan <karthik.g.krishnan@gmail.com>
Cc: linux-acpi@vger.kernel.org, laforge@gnumonks.org

Karthik,

karthik.g.krishnan@gmail.com said:
> To an end user, writing "0" to enable the device & "1" to disable it
> sounds counter-intuitive, especially when the sysfs entry is called
> "cdpower". Is there a reason to not flip that?

/me goes off to look at how other people do it...  sony-laptop uses "1"
for on and "0" for off, so I guess you're right.  Not sure what I was
thinking there, I'll flip it in the final version of the patch.  Thanks!

Which brings me to a related question someone here may be able to
answer:  Which bit of userspace would be responsible for managing the
drive's power state?  To me the most intuitive automatic mode of
operation would be that the system powers off the drive after some time
iff there is no medium in the drive.

On these laptops there is no need to actually power the drive back up,
since it will do so automatically if a user attempts to insert a disc.

-mato
