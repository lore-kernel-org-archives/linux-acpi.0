From: Simon Kitching <skitching@apache.org>
Subject: Re: Index is beyond end of object; Method parse/execution failed
Date: Sat, 12 Sep 2009 15:01:24 +0200
Message-ID: <1252760484.23058.5.camel@simon-laptop>
References: <1252437365.5669.14.camel@simon-laptop>
	 <d3f22a0909081931i5c71a804yc2cb405f9b050ea2@mail.gmail.com>
	 <1252524747.15601.3.camel@simon-laptop>
	 <200909100902.10097.bjorn.helgaas@hp.com>
Reply-To: skitching@apache.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from viefep11-int.chello.at ([62.179.121.31]:55055 "EHLO
	viefep11-int.chello.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400AbZILNBc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Sep 2009 09:01:32 -0400
In-Reply-To: <200909100902.10097.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Lin Ming <lin@minggr.cn>, linux-acpi@vger.kernel.org, Frans Pop <elendil@planet.nl>

On Thu, 2009-09-10 at 09:02 -0600, Bjorn Helgaas wrote:
> On Wednesday 09 September 2009 01:32:27 pm Simon Kitching wrote:
> > On Wed, 2009-09-09 at 10:31 +0800, Lin Ming wrote:
> > > On Wed, Sep 9, 2009 at 3:16 AM, Simon Kitching<skitching@apache.org> wrote:
> > > > Hi All,
> > > >
> > > > Suspend-to-mem and resume seem to work fine, but I get a few odd ACPI
> > > > messages in dmesg. Is this of interest to anyone?
> > > >
> > > > [  188.914261] ACPI Exception: AE_AML_PACKAGE_LIMIT, Index (000000005)
> > > > is beyond end of object 20090521 exoparg2-445
> > > > [  188.914278] ACPI Error (psparse-0537): Method parse/execution failed
> > > > [\_SB_.C248] (Node f701a6d8), AE_AML_PACKAGE_LIMIT
> > > > [  188.914344] ACPI Error (psparse-0537): Method parse/execution failed
> > > > [\_SB_.C002.C0DE.C354._STM] (Node f701d780), AE_AML_PACKAGE_LIMIT
> > > > [  188.914415] ata5: ACPI set timing mode failed (status=0x300b)
> > > >
> > > >
> > > > Kernel: 2.6.31-rc9
> > > > Distro: ubuntu 09.04
> > > > Hardware: Compaq nc8430 laptop
> > > > CPU: core duo T2500
> > > >
> > > > These messages are generated every time I run
> > > >   echo "mem" > /sys/power/state
> > > > although otherwise the suspend/resume seems 100% ok.
> > > >
> > > > I'm happy to provide more info or run tests if anyone wants me to.
> > > 
> > > Could you attach the acpidump output?
> > 
> > Rather than send a 300kb attachment, I have put the relevant file here:
> >   http://people.apache.org/~skitching/acpidump.txt
> 
> I think this is a BIOS defect.  Frans Pop reported the same
> problem earlier on a Compaq 2510p.  I poked our notebook BIOS
> people about it, but since these are fairly old notebooks and
> we haven't seen any real problem (other than the error messages),
> there's not much interest in fixing it.  Sorry; I wish I had a
> better answer.
> 

Well, if this is due to a defective BIOS, then not much can be done;
there certainly isn't much point in releasing new BIOS versions for
3-year-old systems. I posted mainly because it might indicate a Linux
ACPI implementation bug that could be fixed.

Hopefully in future BIOS makers will try boot/suspend/resume tests with
Linux before shipping :-)

Thanks to you all.

Regards, Simon

