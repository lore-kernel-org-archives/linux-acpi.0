From: Simon Kitching <skitching@apache.org>
Subject: Re: Index is beyond end of object; Method parse/execution failed
Date: Wed, 09 Sep 2009 21:32:27 +0200
Message-ID: <1252524747.15601.3.camel@simon-laptop>
References: <1252437365.5669.14.camel@simon-laptop>
	 <d3f22a0909081931i5c71a804yc2cb405f9b050ea2@mail.gmail.com>
Reply-To: skitching@apache.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from viefep14-int.chello.at ([62.179.121.34]:17053 "EHLO
	viefep14-int.chello.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349AbZIITc2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Sep 2009 15:32:28 -0400
In-Reply-To: <d3f22a0909081931i5c71a804yc2cb405f9b050ea2@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <lin@minggr.cn>
Cc: linux-acpi@vger.kernel.org

On Wed, 2009-09-09 at 10:31 +0800, Lin Ming wrote:
> On Wed, Sep 9, 2009 at 3:16 AM, Simon Kitching<skitching@apache.org> wrote:
> > Hi All,
> >
> > Suspend-to-mem and resume seem to work fine, but I get a few odd ACPI
> > messages in dmesg. Is this of interest to anyone?
> >
> > [  188.914261] ACPI Exception: AE_AML_PACKAGE_LIMIT, Index (000000005)
> > is beyond end of object 20090521 exoparg2-445
> > [  188.914278] ACPI Error (psparse-0537): Method parse/execution failed
> > [\_SB_.C248] (Node f701a6d8), AE_AML_PACKAGE_LIMIT
> > [  188.914344] ACPI Error (psparse-0537): Method parse/execution failed
> > [\_SB_.C002.C0DE.C354._STM] (Node f701d780), AE_AML_PACKAGE_LIMIT
> > [  188.914415] ata5: ACPI set timing mode failed (status=0x300b)
> >
> >
> > Kernel: 2.6.31-rc9
> > Distro: ubuntu 09.04
> > Hardware: Compaq nc8430 laptop
> > CPU: core duo T2500
> >
> > These messages are generated every time I run
> >   echo "mem" > /sys/power/state
> > although otherwise the suspend/resume seems 100% ok.
> >
> > I'm happy to provide more info or run tests if anyone wants me to.
> 
> Could you attach the acpidump output?

Rather than send a 300kb attachment, I have put the relevant file here:
  http://people.apache.org/~skitching/acpidump.txt

Thanks for taking an interest.

Regards, Simon



