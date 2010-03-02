From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: pci card in thinkpad dock is not detected.
Date: Tue, 2 Mar 2010 12:53:20 -0700
Message-ID: <201003021253.21066.bjorn.helgaas@hp.com>
References: <117843.66339.qm@web111810.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <117843.66339.qm@web111810.mail.gq1.yahoo.com>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Lara Michaels <laramichaels1978@yahoo.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sunday 28 February 2010 07:35:23 pm Lara Michaels wrote:
> On my system running 2.6.31, a video card inserted into the PCI slot in a Thinkpad Dock II is not detected by the system. This might be the same problem as reported here:
> 
> http://markmail.org/message/xzi7pkbudkeorzjs#query:thinkpad%20dock%20linux%20pci+page:1+mid:5of2pjjpyw6jzrqk+state:results
> 
> But, unlike that lucky poster, the issue did not magically go away on my system after experimenting with the kernel boot options. I know the PCI card itself works, since I have inserted it into an old desktop system and it was detected correctly.

I think this is more likely an ACPI or dock driver problem than a
PCI problem, but I know very little about docks.

I think it's different from the problem you found on the mailing
list, so can you please open a kernel bugzilla report at

  http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI

and attach your dmesg, lspci, and acpidump?  Please respond to this
thread with the new bugzilla URL.

Thanks,
  Bjorn

> I have set the Thinkpad's BIOS to its default settings and then tried booting with
> 
> - acpi=off
> - pci=noacpi
> - pci=nobios
> - pci=assign-busses
> - pci=routeirq
> 
> None of these worked. The video card in the PCI slot (not to be confused with the ATI Radeon Mobility that shows up in lspci's output; that is the laptop's built-in video controller) never becomes visible in the output of lspci.
> 
> I have paste-binned output that might be helpful (both after booting with pci=assign-busses, since that seems to be the most often prescribed solution for similar problems):
> 
> - dmesg: http://pastebin.com/HFhhFnYX
> - lspci -vvv: http://pastebin.com/ehDZ0Twk
> 
> I also saved the dmesg/lspci -vvv output for all other boot options I tried; if that could be helpful, just let me know. 
> 
> thank you for any help on getting this working
> 
> lara
