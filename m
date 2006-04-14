From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: Hibernate
Date: Fri, 14 Apr 2006 10:56:15 +0800
Message-ID: <1144983375.2865.73.camel@sli10-desk.sh.intel.com>
References: <7736DD1D5D6EDD4081B590872B56DCCC0C29F913@gvlexch01.gvl.is.l-3com.com>
	 <200604132126.42755.ncunningham@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:56498 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751215AbWDNC5P (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Apr 2006 22:57:15 -0400
In-Reply-To: <200604132126.42755.ncunningham@cyclades.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: "Cleaveland, AJ Allan @ IS" <Allan.J.Cleaveland@l-3com.com>, linux-acpi@vger.kernel.org

On Thu, 2006-04-13 at 19:26 +0800, Nigel Cunningham wrote:
> Hi Allan.
> 
> On Wednesday 12 April 2006 22:50, Cleaveland, AJ Allan @ IS wrote:
> > I'm trying to get hibernate to work on CentOS 4.  What I really want to do
> > is use hibernate to start-up the machine every time.  To do this I would
> > create an "image" to come out of hibernate with and set the machine to
> > always think it's coming out of hibernate, no matter how it was actually
> > shut down.  It would always use my "image", even if it was placed in
> > hibernate when it shut down.  Without rewriting other people's code does
> > anyone know of a way to do this?
> >
> > Thank you,
> > Allan
> 
> I'm not sure I understand what you're saying correctly, but it sounds to me 
> like you want something like the KeepImage feature in Suspend2. This feature 
> lets you suspend once, and subsequently simply powerdown rather than 
> rewriting the image. To use this mode reliably, any filesystems mounted when 
> the image is created have to be immutable. This is because the image will 
> include information about the filesystems such as superblocks, inodes, 
> dentries and so on, and these data structures must match the data on disk.
We could have file in memory for the snapshot kernel before we mount any
hardisk filesystem, and then create a new initrd including the snapshot
image after boot. Later we always use the new initrd. This way even the
hardisk is touched, the kernel can still resume.

Thanks,
Shaohua 


