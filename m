From: Gianluca Anzolin <gianluca@sottospazio.it>
Subject: Re: Debugging spurious wakeup
Date: Wed, 13 May 2015 12:51:25 +0200
Message-ID: <20150513105125.GA12571@sottospazio.it>
References: <20150513065825.GA10680@sottospazio.it>
 <744357E9AAD1214791ACBA4B0B90926301501164@SHSMSX101.ccr.corp.intel.com>
 <20150513081203.GA11182@sottospazio.it>
 <744357E9AAD1214791ACBA4B0B90926301501237@SHSMSX101.ccr.corp.intel.com>
 <20150513082613.GA11327@sottospazio.it>
 <744357E9AAD1214791ACBA4B0B90926301501298@SHSMSX101.ccr.corp.intel.com>
 <20150513090340.GA11529@sottospazio.it>
 <744357E9AAD1214791ACBA4B0B909263015013BD@SHSMSX101.ccr.corp.intel.com>
 <20150513101726.GA12344@sottospazio.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from m-r2.th.seeweb.it ([5.144.164.171]:46819 "EHLO
	m-r2.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933989AbbEMKvm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 May 2015 06:51:42 -0400
Content-Disposition: inline
In-Reply-To: <20150513101726.GA12344@sottospazio.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, May 13, 2015 at 12:17:26PM +0200, Gianluca Anzolin wrote:
> On Wed, May 13, 2015 at 09:42:46AM +0000, Zhang, Rui wrote:
> > > The echo command didn't work: infact I double checked, it didn't change the
> > > wakeup status.
> > > 
> > then please try
> > "echo disabled > /sys/bus/pci/0000:04:00.0/power/wakeup" instead.
> > 
> 
> Here follow the commands given:
> 
> root@zanac:~$ cat /sys/bus/pci/devices/0000:04:00.0/power/wakeup
> enabled
> root@zanac:~$ echo disabled > /sys/bus/pci/devices/0000:04:00.0/power/wakeup
> root@zanac:~$ cat /sys/bus/pci/devices/0000:04:00.0/power/wakeup
> disabled
> root@zanac:~$ poweroff
> 

A small follow-up.

I looked for the devices with wakeup = enabled and they are:

0000:00:1d.0
0000:04:00.0
0000:05:00.0
0000:05:00.0

For each of them I tried to disable the wakeup with the echo command and then
poweroff, but the system always turns on after a couple of seconds.

I even tried to disable them all to no avail.

Gianluca
