From: "Cleaveland, AJ Allan @ IS" <Allan.J.Cleaveland@L-3Com.com>
Subject: RE: Hibernate
Date: Thu, 13 Apr 2006 08:19:52 -0500
Message-ID: <7736DD1D5D6EDD4081B590872B56DCCC0C29F91B@gvlexch01.gvl.is.l-3com.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpout3.l-3com.com ([166.20.84.211]:56330 "EHLO
	smtpout3.l-3com.com") by vger.kernel.org with ESMTP id S964926AbWDMNT7
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Apr 2006 09:19:59 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: 'Shaohua Li' <shaohua.li@intel.com>
Cc: linux-acpi@vger.kernel.org

Shaohua,

     I will look into that.  Thank you.

Sincerely,
Allan

-----Original Message-----
From: Shaohua Li [mailto:shaohua.li@intel.com] 
Sent: Wednesday, April 12, 2006 8:30 PM
To: Cleaveland, AJ Allan @ IS
Cc: linux-acpi@vger.kernel.org
Subject: Re: Hibernate


On Wed, 2006-04-12 at 20:50 +0800, Cleaveland, AJ Allan @ IS wrote:
> I'm trying to get hibernate to work on CentOS 4.  What I really want 
> to do is use hibernate to start-up the machine every time.  To do this 
> I would
> create an "image" to come out of hibernate with and set the machine
> to 
> always think it's coming out of hibernate, no matter how it was
> actually 
> shut down.  It would always use my "image", even if it was placed in 
> hibernate when it shut down.  Without rewriting other people's code
> does 
> anyone know of a way to do this? 
The resume from initrd might be good for you.

Thanks,
Shaohua
