From: "Vegard Nossum" <vegard.nossum@gmail.com>
Subject: Re: ACPI: kmemcheck: Caught 16-bit read from freed memory (f7c12ec6)
Date: Thu, 8 May 2008 09:29:34 +0200
Message-ID: <19f34abd0805080029w1415b7jc4edd2772f7086e4@mail.gmail.com>
References: <19f34abd0805060909q635d2d43j9414e5f179c9e22f@mail.gmail.com>
	 <84144f020805061338yd6e3declaf5ff9ca344c28ba@mail.gmail.com>
	 <19f34abd0805061346q4af7e4f8kd65009f8d3021d0e@mail.gmail.com>
	 <4820C56C.6070204@cs.helsinki.fi>
	 <19f34abd0805071221o236c8629ib184a4720f178e7b@mail.gmail.com>
	 <1210224923.22503.8.camel@minggr.sh.intel.com>
	 <19f34abd0805072305i19dc37bn3e13fbca4b6981e3@mail.gmail.com>
	 <1210227145.23183.7.camel@minggr.sh.intel.com>
	 <19f34abd0805072331i2a33ee7bl940d46c478cc62d9@mail.gmail.com>
	 <1210229802.23330.4.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.232]:39006 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756212AbYEHH3f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 May 2008 03:29:35 -0400
Received: by rv-out-0506.google.com with SMTP id l9so815514rvb.1
        for <linux-acpi@vger.kernel.org>; Thu, 08 May 2008 00:29:34 -0700 (PDT)
In-Reply-To: <1210229802.23330.4.camel@minggr.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, May 8, 2008 at 8:56 AM, Lin Ming <ming.m.lin@intel.com> wrote:
>  > >  On Thu, 2008-05-08 at 08:05 +0200, Vegard Nossum wrote:
>  > >  > Hello,
>  > >  >
>  > >  > On Thu, May 8, 2008 at 7:35 AM, Lin Ming <ming.m.lin@intel.com> wrote:
>  > >  > > Here comes a simple patch that fixes the warning in my machine.
>  > >  > >
>  > >  > >  Vegard, would you please help to test it in your machine?
>  > >  > >
>  > >  >
>  > >  > Thanks for the try, but unfortunately this does not solve the problem.
>  > >
>  > >  It's strange.
>  > >  In my machine, without this patch the warning shows up
>  > >  With this patch applied the waring goes away
>  >
>  > Ah. That is strange indeed.
>  >
>  > >  Would you please upload the acpidump file?
>  >
>  > Which file is this or how can I produce it? Please tell me the exact
>  > parameters to pass to the command line.
>
>  Please download acpidump util from
>  http://kernel.org/pub/linux/kernel/people/lenb/acpi/utils/pmtools-20071116.tar.bz2
>
>  Run "acpidump > acpidump.out" as root
>
>  Then upload acpidump.out to somewhere I can access
>
>  Lin Ming

You can find it here:
http://userweb.kernel.org/~vegard/bugs/20080508-acpi/

(When running acpidump I got some message, now gone from the screen
unfortunately, but it said something like 0B checksum failed? Hm,
well, it seemed to produce the file anyway.)

Hope this helps. Thanks!


Vegard

-- 
"The animistic metaphor of the bug that maliciously sneaked in while
the programmer was not looking is intellectually dishonest as it
disguises that the error is the programmer's own creation."
	-- E. W. Dijkstra, EWD1036
