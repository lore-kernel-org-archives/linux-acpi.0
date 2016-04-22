From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] ACPICA / Interpreter: Fix a regression triggered because
 of wrong Linux ECDT support
Date: Fri, 22 Apr 2016 12:14:31 +0900
Message-ID: <20160422031430.GB20313@kroah.com>
References: <1461119996-1861-1-git-send-email-lv.zheng@intel.com>
 <20160420055806.GA6285@kroah.com>
 <1AE640813FDE7649BE1B193DEA596E883BB8205F@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:33829 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751835AbcDVDOg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Apr 2016 23:14:36 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id AF03E203A7
	for <linux-acpi@vger.kernel.org>; Thu, 21 Apr 2016 23:14:35 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BB8205F@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, Apr 22, 2016 at 03:05:39AM +0000, Zheng, Lv wrote:
> Hi, Greg
> 
> > From: Greg KH [mailto:greg@kroah.com]
> > Subject: Re: [PATCH] ACPICA / Interpreter: Fix a regression triggered because
> > of wrong Linux ECDT support
> > 
> > On Wed, Apr 20, 2016 at 10:39:56AM +0800, Lv Zheng wrote:
> > > 4.5-stable review patch. If anyone has any objects, please let me know.
> > 
> > Huh?  I don't understand this email...
> > 
> > 
> [Lv Zheng] 
> 
> I received an error notice from you on 4/11/2016:
> FAILED: patch "[PATCH] ACPICA / Interpreter: Fix a regression triggered because of ACPICA: Events: Enhance acpi_ev_execute_reg_method() to" failed to apply to 4.5-stable tree
> And promised you to perform the back porting.
> After having it tested by LKP for several days, I sent it out to the stable mailing list.
> 
> I'm sorry I didn't send this email to you directly and didn't send it to the original mail thread for you to reference.
> The original thread is:
> Message-ID: <14603111697259@kroah.com>
> Subject: FAILED: patch "[PATCH] ACPICA / Interpreter: Fix a regression triggered because of
>  ACPICA: Events: Enhance acpi_ev_execute_reg_method() to" failed to apply to 4.5-stable tree
> 
> Hope you can help to have this shipped in 4.5-stable.

Yes, it's in my "to apply" queue, which is still not empty.  Don't
worry, it's not lost :)

thanks,

greg k-h
