From: Philippe De Muyter <phdm@macqel.be>
Subject: Re: how to diagnose/fix : cannot boot without acpi=off
Date: Thu, 1 Apr 2010 10:23:48 +0200
Message-ID: <20100401082348.GB28762@frolo.macqel>
References: <20100330205516.GC26538@frolo.macqel> <alpine.LFD.2.00.1003312138001.13993@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailrelay007.isp.belgacom.be ([195.238.6.173]:14839 "EHLO
	mailrelay007.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753979Ab0DAIXw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Apr 2010 04:23:52 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1003312138001.13993@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Thanks Len,

On Wed, Mar 31, 2010 at 09:42:48PM -0400, Len Brown wrote:
> On Tue, 30 Mar 2010, Philippe De Muyter wrote:
> 
> > Hello acpi experts
> > 
> > I have just installed opensuse 11.3 milestone 4 (2.6.33-6-desktop) on a laptop
> > hp pavilion dv6-1300sb, and it refuses to boot without acpi=off which in turn
> > prevents me to use the wireless chip.
> > 
> > I would like to diagnose precisely what the problem(s) is/are.
> > 
> > which option should I add to the linux commandline to make it point to the
> > problem ?  I have already tried 'ignore_loglevel debug' but the last
> > message is never the same.
> 
> Did previous versions of Linux boot properly on this machine?

The opensuse 11.3 milestone 4 installation kernel works flawlessly.
The opensuse 11.3 milestone 4 installed kernel does not boot without acpi=off
and often (but not always) crashes at boot even with acpi=off

> 
> Please open a bug report:
> 
> https://bugzilla.kernel.org/enter_bug.cgi?product=ACPI

Done : https://bugzilla.kernel.org/show_bug.cgi?id=15665

> 
> and attach the output from acpidump and dmesg -s64000
> from your acpi=off boot.

acpidump : done
dmesg -s64000 : will do when back at home

> 
> If you can take a photo of the failed boot, or otherwise
> describe it in more detail, that would be helpful.

I have attached several netconsole ignore_loglevel logs to the bug report

> 
> See if any of these random options help it boot:
> acpi=ht (likely this will work)
> acpi=rsdt
> acpi=noirq
> pci=noacpi

will do when back at home

Philippe

-- 
Philippe De Muyter  phdm at macqel dot be  Tel +32 27029044
Macq Electronique SA  rue de l'Aeronef 2  B-1140 Bruxelles  Fax +32 27029077
