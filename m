From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: Hibernate
Date: Thu, 13 Apr 2006 09:30:26 +0800
Message-ID: <1144891826.2865.62.camel@sli10-desk.sh.intel.com>
References: <7736DD1D5D6EDD4081B590872B56DCCC0C29F913@gvlexch01.gvl.is.l-3com.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr20.intel.com ([134.134.136.19]:2704 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S932338AbWDMBb0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Apr 2006 21:31:26 -0400
In-Reply-To: <7736DD1D5D6EDD4081B590872B56DCCC0C29F913@gvlexch01.gvl.is.l-3com.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Cleaveland, AJ Allan @ IS" <Allan.J.Cleaveland@L-3Com.com>
Cc: linux-acpi@vger.kernel.org

On Wed, 2006-04-12 at 20:50 +0800, Cleaveland, AJ Allan @ IS wrote:
> I'm trying to get hibernate to work on CentOS 4.  What I really want
> to do 
> is use hibernate to start-up the machine every time.  To do this I
> would 
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

