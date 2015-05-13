From: Gianluca Anzolin <gianluca@sottospazio.it>
Subject: Re: Debugging spurious wakeup
Date: Wed, 13 May 2015 12:17:26 +0200
Message-ID: <20150513101726.GA12344@sottospazio.it>
References: <20150513065825.GA10680@sottospazio.it>
 <744357E9AAD1214791ACBA4B0B90926301501164@SHSMSX101.ccr.corp.intel.com>
 <20150513081203.GA11182@sottospazio.it>
 <744357E9AAD1214791ACBA4B0B90926301501237@SHSMSX101.ccr.corp.intel.com>
 <20150513082613.GA11327@sottospazio.it>
 <744357E9AAD1214791ACBA4B0B90926301501298@SHSMSX101.ccr.corp.intel.com>
 <20150513090340.GA11529@sottospazio.it>
 <744357E9AAD1214791ACBA4B0B909263015013BD@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from m-r2.th.seeweb.it ([5.144.164.171]:39275 "EHLO
	m-r2.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418AbbEMKRc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 May 2015 06:17:32 -0400
Content-Disposition: inline
In-Reply-To: <744357E9AAD1214791ACBA4B0B909263015013BD@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, May 13, 2015 at 09:42:46AM +0000, Zhang, Rui wrote:
> > The echo command didn't work: infact I double checked, it didn't change the
> > wakeup status.
> > 
> then please try
> "echo disabled > /sys/bus/pci/0000:04:00.0/power/wakeup" instead.
> 

Here follow the commands given:

root@zanac:~$ cat /sys/bus/pci/devices/0000:04:00.0/power/wakeup
enabled
root@zanac:~$ echo disabled > /sys/bus/pci/devices/0000:04:00.0/power/wakeup
root@zanac:~$ cat /sys/bus/pci/devices/0000:04:00.0/power/wakeup
disabled
root@zanac:~$ poweroff

But after a couple of seconds the system still turns on.

Gianluca
