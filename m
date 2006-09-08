From: Dave Jones <davej@redhat.com>
Subject: Re: patch [0/2]: acpi: add generic removable drive bay support
Date: Fri, 8 Sep 2006 16:33:10 -0400
Message-ID: <20060908203310.GM28592@redhat.com>
References: <20060907161305.67804d14.kristen.c.accardi@intel.com> <20060908195842.GA17220@srcf.ucam.org> <20060908132123.16137ea3.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:35289 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751209AbWIHU0I (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Sep 2006 16:26:08 -0400
Content-Disposition: inline
In-Reply-To: <20060908132123.16137ea3.kristen.c.accardi@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com

On Fri, Sep 08, 2006 at 01:21:23PM -0700, Kristen Carlson Accardi wrote:
 > On Fri, 8 Sep 2006 20:58:42 +0100
 > Matthew Garrett <mjg59@srcf.ucam.org> wrote:
 > 
 > > On Thu, Sep 07, 2006 at 04:13:05PM -0700, Kristen Carlson Accardi wrote:
 > > 
 > > Firstly, thanks for this - I wrote some related code a while ago. A 
 > > couple of questions...
 > > 
 > > > can then be used by udev to unmount or rescan depending on the event.  It will
 > > > create a proc entry under /proc/acpi/bay for "eject" and for "status".  Writing 
 > > 
 > > Do we really want it under /proc? It would seem to make more sense for 
 > > it to be under /sys.
 > 
 > I agree - this is under proc because this is an acpi driver, and the acpi
 > subsystem is still using the /proc fs for driver/user space interface. I
 > thought I would just conform to their standard.

It's my understanding from talking with Len that he'd like to see /proc/acpi/
go away over time, so adding more to it seems to be at odds with that goal.
 
	Dave
