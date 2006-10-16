From: Martin Lorenz <martin@lorenz.eu.org>
Subject: Re: [ltp] Re: X60s w/t kern 2.6.19-rc1-git: two BUG warnings
Date: Mon, 16 Oct 2006 08:53:13 +0200
Message-ID: <20061016065313.GB5350@gimli>
References: <20061010062826.GC9895@gimli> <20061013154756.GT721@stusta.de> <20061016063222.GA5350@gimli>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from holoclan.de ([62.75.158.126]:22993 "EHLO mail.holoclan.de")
	by vger.kernel.org with ESMTP id S1751483AbWJPGzH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Oct 2006 02:55:07 -0400
Content-Disposition: inline
In-Reply-To: <20061016063222.GA5350@gimli>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-thinkpad@linux-thinkpad.org, linux-kernel@vger.kernel.org, len.brown@intel.com, linux-acpi@vger.kernel.org

On Mon, Oct 16, 2006 at 08:32:22AM +0200, Dipl.-Ing. Martin Lorenz wrote:
> On Fri, Oct 13, 2006 at 05:47:56PM +0200, Adrian Bunk wrote:
> > On Tue, Oct 10, 2006 at 08:28:26AM +0200, Martin Lorenz wrote:
> > > Dear kernel gurus,
> > > 
> > > whatever I do and whic problem I seem to get fixed new ones arise:
> > > 
> > > now I loose ACPI events after suspend/resume. not every time, but roughly 
> > > 3 out of 4 times.
> > > 
> > > the only errornous things I see in the logs are those: 
> > >...
> > 
> > Which was the last working kernel?
> 
> ok...
> 
> tested it again and found it workiing in 2.6.18 
> 
> one strange thing though: there seems to be some inconsistencies in which
> script is treggered by Fn+F4.
> 
> usually it is the /etc/acpi/sleepbtn.sh script, but after one suspend/resume
> the /etc/acpi/sleep.sh script is triggered.

another uptdate:

http://www.lorenz.eu.org/~mlo/kernel/acpid-2.6.18-ie-la-tp-41.5+0813

has the acpi log for the above mentioned behaviour
and 
http://www.lorenz.eu.org/~mlo/kernel/dmesg_boot-2.6.18-ie-la-tp-41.5+0813.out
http://www.lorenz.eu.org/~mlo/kernel/dmesg_running-2.6.18-ie-la-tp-41.5+0813.out
the corresponding dmesg logs - one at boot time (/var/log/dmesg) and one at
runtime (dmesg > ...)

I run this 2.6.18 kernel now to work with but had to disable tp_smapi by
forcefully unloading the module. 

gruss
  mlo
--
Dipl.-Ing. Martin Lorenz

            They that can give up essential liberty 
	    to obtain a little temporary safety 
	    deserve neither liberty nor safety.
                                   Benjamin Franklin

please encrypt your mail to me
GnuPG key-ID: F1AAD37D
get it here:
http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0xF1AAD37D

ICQ UIN: 33588107
