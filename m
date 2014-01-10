From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: kdump failed because of hotplug memory adding in kdump kernel
Date: Fri, 10 Jan 2014 02:40:14 +0100
Message-ID: <1573868.THSJocqDKH@vostro.rjw.lan>
References: <52CD6E33.400@redhat.com> <20140109182310.GG25897@redhat.com> <1389292470.1792.109.camel@misato.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50005 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752894AbaAJB0X (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Jan 2014 20:26:23 -0500
In-Reply-To: <1389292470.1792.109.camel@misato.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, Baoquan <bhe@redhat.com>, linux-acpi@vger.kernel.org, zhangyanfei@cn.fujitsu.com, tangchen@cn.fujitsu.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, dyoung@redhat.com

On Thursday, January 09, 2014 11:34:30 AM Toshi Kani wrote:
> On Thu, 2014-01-09 at 13:23 -0500, Vivek Goyal wrote:
> > On Thu, Jan 09, 2014 at 10:24:25AM -0700, Toshi Kani wrote:
> > 
> > [..]
> > > > I think creating a new command line option is simpler as compared to
> > > > creating a new flag in bootparam which in turn disables memory hotplug.
> > > > More users can use that option. For example, if for some reason hotplug
> > > > code is crashing, one can just disable it on command line as work around
> > > > and move on.
> > > 
> > > I do not have a strong opinion about having such option.  However, I
> > > think it is more user friendly to keep the exactmap option works alone
> > > on any platforms.
> > 
> > I think we should create internally a variable which will disable memory
> > hotplug. And set that variable based on memmap=exactmap, mem=X and also
> > provide a way to disable memory hotplug directly using command line
> > option.
> > 
> > Current kexec-tools can use memmap=exactmap and be happy. I am writing
> > a new kexec syscall and will not be using memmap=exactmap and would need
> > to use that command line option to disable memory hotplug behavior.
> 
> Sounds good to me.

Agreed.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
