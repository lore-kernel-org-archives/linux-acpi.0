From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: Buggy BIOS on the HP TX2500-series
Date: Thu, 09 Oct 2008 09:32:00 +0800
Message-ID: <1223515920.22227.14.camel@minggr.sh.intel.com>
References: <331496.52627.qm@web23007.mail.ird.yahoo.com>
	 <20081008192641.GA1932@srcf.ucam.org>  <1223513955.2735.28.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:25554 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753783AbYJIBeV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Oct 2008 21:34:21 -0400
In-Reply-To: <1223513955.2735.28.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: MooreRobert <robert.moore@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Gandalf Kristensen <gandkri@yahoo.no>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Wed, 2008-10-08 at 17:59 -0700, Zhang, Rui wrote:
> On Wed, 2008-10-08 at 12:26 -0700, Matthew Garrett wrote:
> > A patch went into the kernel earlier this year to ignore critical trip
> > points that were below 0.
> well, I think this patch is wrong.
> a critical trip point below 0 Celsius doesn't mean it's invalid.
> windows can work well on this laptop.
> please look at:
> http://bugzilla.kernel.org/show_bug.cgi?id=10686#c13
> IMO, we need to fix the ACPICA code first of all.
> 
> Ming, what do you think of the patch in comment #15 and #16?

We have a ACPICA patch at:
http://git.acpica.org/repos/?p=acpica.git;a=commitdiff;h=ab557ef061978bd54baa05daca33ea16942629fa 

        Method (_CRT, 0, Serialized)
        {
            If (LLess (OSYS, 0x07D6))
            {
                If (LEqual (\_SB.TJ85, Zero))
                {
                    Return (Add (0x0AAC, Multiply (TPC, 0x0A)))
                }
                Else
                {
                    Return (Add (0x0AAC, Multiply (TP85, 0x0A)))
                }
            }
        }
    
Previously _CRT returns 0x07D6, now it returns 0 (predicate value of
LLess) which matches windows behavior.

So I felt it's better for the external interface (the driver) to check
the return value (zero) and decide what to do.

Thanks,
Lin Ming



