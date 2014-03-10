From: Mauro Carvalho Chehab <m.chehab@samsung.com>
Subject: Re: [PATCH 2/2] trace, RAS: Add eMCA trace event interface
Date: Mon, 10 Mar 2014 08:41:13 -0300
Message-ID: <20140310084113.7be77602@samsung.com>
References: <1393924997-8992-1-git-send-email-gong.chen@linux.intel.com>
 <1393924997-8992-3-git-send-email-gong.chen@linux.intel.com>
 <20140307114416.GA5255@pd.tnic> <20140310082241.GA873@gchen.bj.intel.com>
 <20140310070435.1981ddd5@samsung.com> <20140310103129.GC14808@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout4.w2.samsung.com ([211.189.100.14]:55621 "EHLO
	usmailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105AbaCJLlU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Mar 2014 07:41:20 -0400
Received: from uscpsbgm1.samsung.com
 (u114.gpu85.samsung.co.kr [203.254.195.114]) by usmailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0N2700KORXSVWC50@usmailout4.samsung.com> for
 linux-acpi@vger.kernel.org; Mon, 10 Mar 2014 07:41:19 -0400 (EDT)
In-reply-to: <20140310103129.GC14808@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Chen, Gong" <gong.chen@linux.intel.com>, tony.luck@intel.com, arozansk@redhat.com, linux-acpi@vger.kernel.org

Em Mon, 10 Mar 2014 11:31:29 +0100
Borislav Petkov <bp@alien8.de> escreveu:

> On Mon, Mar 10, 2014 at 07:04:35AM -0300, Mauro Carvalho Chehab wrote:
> > Changing the format breaks any userspace application that relies on
> > parsing them. That's an API breakage. Adding more data could be
> > fine, if we take enough care when doing it, and properly document
> > how userspace is supposed to parse it.
> 
> Yes, we don't want code duplication if it can be helped. Besides, having
> one function doing the error format issual keeps us from the case when
> having two or more diverge from one another.
> 
> > Well, actually, EDAC drivers use 0 to indicate an unknown physical address.
> > The better is to use the same standard used there.
> 
> However, physical address 0 is a valid address... all FFF...Fs is hardly valid.

True, but if we decide to go on that direction, a change like that should
then be done on all EDAC drivers, and that's an API change. 

We also need to be sure that userspace will handle this change properly.

Regards,
Mauro

-- 

Regards,
Mauro
