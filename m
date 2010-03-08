From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: pci card in thinkpad dock is not detected.
Date: Mon, 8 Mar 2010 11:16:36 -0700
Message-ID: <201003081116.36574.bjorn.helgaas@hp.com>
References: <117843.66339.qm@web111810.mail.gq1.yahoo.com> <201003021253.21066.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <201003021253.21066.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Lara Michaels <laramichaels1978@yahoo.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday 02 March 2010 12:53:20 pm Bjorn Helgaas wrote:
> On Sunday 28 February 2010 07:35:23 pm Lara Michaels wrote:
> > On my system running 2.6.31, a video card inserted into the PCI slot in a Thinkpad Dock II is not detected by the system. This might be the same problem as reported here:
> > 
> > http://markmail.org/message/xzi7pkbudkeorzjs#query:thinkpad%20dock%20linux%20pci+page:1+mid:5of2pjjpyw6jzrqk+state:results
> > 
> > But, unlike that lucky poster, the issue did not magically go away on my system after experimenting with the kernel boot options. I know the PCI card itself works, since I have inserted it into an old desktop system and it was detected correctly.
> 
> I think this is more likely an ACPI or dock driver problem than a
> PCI problem, but I know very little about docks.
> 
> I think it's different from the problem you found on the mailing
> list, so can you please open a kernel bugzilla report at
> 
>   http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
> 
> and attach your dmesg, lspci, and acpidump?  Please respond to this
> thread with the new bugzilla URL.

Ping, did you make any progress on this?

Bjorn
