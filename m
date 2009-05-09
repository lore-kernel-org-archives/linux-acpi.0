From: Michal Jaegermann <michal@ellpspace.math.ualberta.ca>
Subject: Re: Asus Eee 901Go ACPI errors on 2.6.30-rc4-git4
Date: Fri, 8 May 2009 20:56:43 -0600
Message-ID: <20090509025643.GA24335@ellpspace.math.ualberta.ca>
References: <87vdobq48p.fsf@fzidpc73.tu-graz.ac.at> <9b2b86520905080646r85f30bcp6f50d7388d8289f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753234AbZEIC5X@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9b2b86520905080646r85f30bcp6f50d7388d8289f5@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Cc: Mario Lang <mlang@tugraz.at>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-acpi@vger.kernel.org

On Fri, May 08, 2009 at 02:46:05PM +0100, Alan Jenkins wrote:
> On 5/8/09, Mario Lang <mlang@tugraz.at> wrote:
> >
> > Booting 2.6.30-rc4-git4 on an Asus Eee 901Go I get the following in dmesg:
> >
> > [   27.005071] ACPI: EC: missing confirmations, switch off interrupt mode.
> > [   27.548097] ACPI Exception (evregion-0422): AE_TIME, Returned by Handler
> > for [EmbeddedControl] [20090320]
> > [   27.548139] ACPI Error (psparse-0537): Method parse/execution failed
> > [\_SB_.PCI0.SBRG.EC0_.BST1] (Node f7033d4c), AE_TIME
> > [   27.548280] ACPI Error (psparse-0537): Method parse/execution failed
> > [\_SB_.PCI0.CBST] (Node f70366f8), AE_TIME
> > [   27.548393] ACPI Error (psparse-0537): Method parse/execution failed
> > [\_SB_.PCI0.BAT0._BST] (Node f7034c48), AE_TIME
> > [   27.548521] ACPI Exception (battery-0385): AE_TIME, Evaluating _BST
> > [20090320]
> 
> Odd.  Did this happen in 2.6.29?

I have seen something similar with different kernels.  See for example
https://bugzilla.redhat.com/show_bug.cgi?id=492699
which reports that for kernel-2.6.27.19-170.2.35.fc10 and
kernel-2.6.29-3.fc10 Fedora kernels and Asus Eeeps 1002HA.

https://bugzilla.redhat.com/buglist.cgi?quicksearch=+Method+parse%2Fexecution+failed

brings a list where it is possible to find something of that sort
in different settings too.

    Michal
