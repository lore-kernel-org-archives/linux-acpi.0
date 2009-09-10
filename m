From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: Index is beyond end of object; Method parse/execution failed
Date: Thu, 10 Sep 2009 09:02:09 -0600
Message-ID: <200909100902.10097.bjorn.helgaas@hp.com>
References: <1252437365.5669.14.camel@simon-laptop> <d3f22a0909081931i5c71a804yc2cb405f9b050ea2@mail.gmail.com> <1252524747.15601.3.camel@simon-laptop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:25946 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494AbZIJPCI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Sep 2009 11:02:08 -0400
In-Reply-To: <1252524747.15601.3.camel@simon-laptop>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: skitching@apache.org
Cc: Lin Ming <lin@minggr.cn>, linux-acpi@vger.kernel.org, Frans Pop <elendil@planet.nl>

On Wednesday 09 September 2009 01:32:27 pm Simon Kitching wrote:
> On Wed, 2009-09-09 at 10:31 +0800, Lin Ming wrote:
> > On Wed, Sep 9, 2009 at 3:16 AM, Simon Kitching<skitching@apache.org> wrote:
> > > Hi All,
> > >
> > > Suspend-to-mem and resume seem to work fine, but I get a few odd ACPI
> > > messages in dmesg. Is this of interest to anyone?
> > >
> > > [  188.914261] ACPI Exception: AE_AML_PACKAGE_LIMIT, Index (000000005)
> > > is beyond end of object 20090521 exoparg2-445
> > > [  188.914278] ACPI Error (psparse-0537): Method parse/execution failed
> > > [\_SB_.C248] (Node f701a6d8), AE_AML_PACKAGE_LIMIT
> > > [  188.914344] ACPI Error (psparse-0537): Method parse/execution failed
> > > [\_SB_.C002.C0DE.C354._STM] (Node f701d780), AE_AML_PACKAGE_LIMIT
> > > [  188.914415] ata5: ACPI set timing mode failed (status=0x300b)
> > >
> > >
> > > Kernel: 2.6.31-rc9
> > > Distro: ubuntu 09.04
> > > Hardware: Compaq nc8430 laptop
> > > CPU: core duo T2500
> > >
> > > These messages are generated every time I run
> > >   echo "mem" > /sys/power/state
> > > although otherwise the suspend/resume seems 100% ok.
> > >
> > > I'm happy to provide more info or run tests if anyone wants me to.
> > 
> > Could you attach the acpidump output?
> 
> Rather than send a 300kb attachment, I have put the relevant file here:
>   http://people.apache.org/~skitching/acpidump.txt

I think this is a BIOS defect.  Frans Pop reported the same
problem earlier on a Compaq 2510p.  I poked our notebook BIOS
people about it, but since these are fairly old notebooks and
we haven't seen any real problem (other than the error messages),
there's not much interest in fixing it.  Sorry; I wish I had a
better answer.

Bjorn
