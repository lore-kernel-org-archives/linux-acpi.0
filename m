From: Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: ACPI patch flow
Date: Wed, 10 Sep 2003 16:23:33 -0400
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <3F5F8845.9080405@pobox.com>
References: <BF1FE1855350A0479097B3A0D2A80EE009FD58@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE009FD58-N2PTB0HCzHJF3Yvz3xaN/VDQ4js95KgL@public.gmane.org>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Brown, Len wrote:
> I've re-named the linux-acpi* tree to be linux-acpi-release*; and made
> the staging area for the release tree visible -- calling it
> linux-acpi-test*
> 
> So a 2 stage release is now visible on the net:

cool!


> As before, the BK trees live here:  http://linux-acpi.bkbits.com  If
> there is demand for plain patches of the _test_ tree we can probably
> also export those on http://sourceforge.net/projects/acpi too, but as
> the test tree will change more often, those updates would have to be
> on-demand or on significant events.

I definitely support the posting of plain patches, and strongly 
encourage it.  We don't want any barriers at all to people testing the 
latest ACPI fixes.

May I make a humble suggestion?  :)  Whenever net driver stuff gets send 
off, I'll often run a prepared script which will create a GNU diff 
against mainline, gzip it, and upload it to ftp.kernel.org.  That gives 
the non-BK users patches to play with.

I first considered posting these net driver patches on sourceforge 
(project: gkernel), but uploads to sourceforge are time-consuming 
events.  You have a upload to an FTP site, then fill out a bunch of 
forms and click a bunch of buttons.  It's a system that _discourages_ 
frequent software postings, IMO.

So, my suggestion is to get an account on some web/ftp site 
(kernel.org?) and create a script that combines two tasks (bk push and 
GNU patch upload) into a single command you run on your local Linux box. 
  Properly scripted, posting a patch shouldn't be any more work than 
pushing to your new test tree.  And IMHO you will reap the benefits.

	Jeff
