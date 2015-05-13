From: Gianluca Anzolin <gianluca@sottospazio.it>
Subject: Re: Debugging spurious wakeup
Date: Wed, 13 May 2015 11:03:40 +0200
Message-ID: <20150513090340.GA11529@sottospazio.it>
References: <20150513065825.GA10680@sottospazio.it>
 <744357E9AAD1214791ACBA4B0B90926301501164@SHSMSX101.ccr.corp.intel.com>
 <20150513081203.GA11182@sottospazio.it>
 <744357E9AAD1214791ACBA4B0B90926301501237@SHSMSX101.ccr.corp.intel.com>
 <20150513082613.GA11327@sottospazio.it>
 <744357E9AAD1214791ACBA4B0B90926301501298@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from m-r2.th.seeweb.it ([5.144.164.171]:49322 "EHLO
	m-r2.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753374AbbEMJDp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 May 2015 05:03:45 -0400
Content-Disposition: inline
In-Reply-To: <744357E9AAD1214791ACBA4B0B90926301501298@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, May 13, 2015 at 08:30:41AM +0000, Zhang, Rui wrote:
> 04:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
> 	Kernel driver in use: e1000e
> 	Kernel modules: e1000e
> PXSX	  S4	*enabled   pci:0000:04:00.0
> 
> Please run "echo PXSX > /proc/acpi/wakeup" before shutdown and then checks if
> the problem still exists.

Thank you for directions. Here follows what I did:

root@zanac:~$ echo PXSX > /proc/acpi/wakeup
root@zanac:~$ cat /proc/acpi/wakeup | grep PX
PXSX      S4    *disabled
PXSX      S4    *disabled
PXSX      S4    *disabled
PXSX      S4    *disabled
PXSX      S4    *disabled
PXSX      S4    *enabled   pci:0000:04:00.0
PXSX      S4    *enabled   pci:0000:06:00.0
root@zanac:$ poweroff

Then after 2-3 seconds the system turns on.

The echo command didn't work: infact I double checked, it didn't change the
wakeup status.

But if I disabled the wakeup would WOL packets still work?

I ask because if I disable 'Wake-up by PCIe' in the BIOS the system stays off,
but I need the WOL functionality.

Currently ethtool eth0 says:

        Supports Wake-on: pumbg
        Wake-on: g
        Current message level: 0x00000007 (7)
                               drv probe link

This should only allow magic-packets to wake up the system. To be sure I even
disconnected the cable from the NIC. Unfortunately it still turns on by itself.

Thanks,

Gianluca

> 
> Thanks,
> Rui
> 
> > -----Original Message-----
> > From: Gianluca Anzolin [mailto:gianluca@sottospazio.it]
> > Sent: Wednesday, May 13, 2015 4:26 PM
> > To: Zhang, Rui
> > Cc: linux-acpi@vger.kernel.org
> > Subject: Re: Debugging spurious wakeup
> > Importance: High
> > 
> > On Wed, May 13, 2015 at 08:13:46AM +0000, Zhang, Rui wrote:
> > > Hmm, none of them seems to be NIC related, can you please attach the
> > output of lspci -vvxx as well?
> > >
> > 
> > file attached (with I blanked the mac address)
> > 
> > Gianluca
