From: Kristen Accardi <kristen.c.accardi@intel.com>
Subject: Re: [patch 1/3] acpi: dock driver v6
Date: Thu, 01 Jun 2006 17:53:17 -0700
Message-ID: <1149209597.14279.27.camel@whizzy>
References: <20060412221027.472109000@intel.com>
	 <1144880322.11215.44.camel@whizzy> <20060412222735.38aa0f58.akpm@osdl.org>
	 <1145054985.29319.51.camel@whizzy> <44410360.6090003@sgi.com>
	 <1145383396.10783.32.camel@whizzy> <1146268318.25490.33.camel@whizzy>
	 <1147373152.15308.14.camel@whizzy> <1149203128.14279.17.camel@whizzy>
	 <20060601162039.02fcd8e1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:40223 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750701AbWFBAl3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 Jun 2006 20:41:29 -0400
In-Reply-To: <20060601162039.02fcd8e1.akpm@osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: len.brown@intel.com, greg@kroah.com, linux-acpi@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org, pavel@ucw.cz

On Thu, 2006-06-01 at 16:20 -0700, Andrew Morton wrote:
> Kristen Accardi <kristen.c.accardi@intel.com> wrote:
> >
> > Changed from last version:
> 
> It would be much preferred if you could issue patches against the previous
> version please (ie: the thing in -mm), instead of reissuing the patch each
> time.
> 

Sorry, another maintainer I routinely post patches too always preferred
me to just redo the whole patch so that he could just drop the old one.
I'll change my procedure for this patch.  If you do have a set of
guidelines for when to know whether to redo entire patches vs. patch
your patch so to speak, it'd be educational for me to hear it - as it is
I just get trained by the person I usually submit to and adopt his
process, making things work really well for me submitting to him, but
probably not so well for me when I submit to others.

I also usually patch/test against 2.6-git - mainly because I imagined
that this hopefully limits weird bugs to problems that I've actually
introduced instead of someone elses bugs - which is why I didn't notice
that acpi_os_free had been removed (although even if it hadn't I
shouldn't be using it anyway - ugh.).  Thanks for fixing the mistake,
looks like I should test against -mm and -git in the future.

Kristen
