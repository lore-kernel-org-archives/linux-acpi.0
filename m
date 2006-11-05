From: Dave Jones <davej@redhat.com>
Subject: Re: [discuss] Linux 2.6.19-rc4: known unfixed regressions (v2)
Date: Sun, 5 Nov 2006 15:04:48 -0500
Message-ID: <20061105200448.GE859@redhat.com>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <454AFD01.4080306@linux.intel.com> <20061103155656.GA1000@redhat.com> <200611051832.13285.christiand59@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:45773 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161690AbWKEUFz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 5 Nov 2006 15:05:55 -0500
Content-Disposition: inline
In-Reply-To: <200611051832.13285.christiand59@web.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christian <christiand59@web.de>
Cc: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>, Adrian Bunk <bunk@stusta.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Sun, Nov 05, 2006 at 06:32:12PM +0100, Christian wrote:
 > Am Freitag, 3. November 2006 16:56 schrieb Dave Jones:
 > > On Fri, Nov 03, 2006 at 11:25:37AM +0300, Alexey Starikovskiy wrote:
 > >  > Could this be a problem?
 > >  > --------------------
 > >  > ...
 > >  > CONFIG_ACPI_PROCESSOR=m
 > >  > ...
 > >  > CONFIG_X86_POWERNOW_K8=y
 > >
 > > Hmm, possibly.  Christian, does it work again if you set them both to =y ?
 > 
 > Yes, it works now! Only the change to CONFIG_ACPI_PROCESSOR=y made it work 
 > again!

So, the reasoning behind this, is that we have this construct..

config X86_POWERNOW_K8_ACPI
    bool
    depends on X86_POWERNOW_K8 && ACPI_PROCESSOR
    depends on !(X86_POWERNOW_K8 = y && ACPI_PROCESSOR = m)
    default y


Which makes us use the ACPI stuff if it's there, otherwise not,
and in your case, it seems your system _needs_ this enabled
to make powernow work.

Thing is, this was there in 2.6.18 too, so strictly speaking,
we haven't regressed here, and you're getting exactly what you asked for.
The problem is that it's completely silent as to why it then fails.

I'm open to improvements, but I'm not sure what the right thing to do
here is.. opinions ?

	Dave

-- 
http://www.codemonkey.org.uk
