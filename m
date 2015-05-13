From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: Debugging spurious wakeup
Date: Wed, 13 May 2015 08:30:41 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B90926301501298@SHSMSX101.ccr.corp.intel.com>
References: <20150513065825.GA10680@sottospazio.it>
 <744357E9AAD1214791ACBA4B0B90926301501164@SHSMSX101.ccr.corp.intel.com>
 <20150513081203.GA11182@sottospazio.it>
 <744357E9AAD1214791ACBA4B0B90926301501237@SHSMSX101.ccr.corp.intel.com>
 <20150513082613.GA11327@sottospazio.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:25507 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932611AbbEMIgL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 May 2015 04:36:11 -0400
In-Reply-To: <20150513082613.GA11327@sottospazio.it>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Gianluca Anzolin <gianluca@sottospazio.it>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

04:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
	Kernel driver in use: e1000e
	Kernel modules: e1000e
PXSX	  S4	*enabled   pci:0000:04:00.0

Please run "echo PXSX > /proc/acpi/wakeup" before shutdown and then checks if the problem still exists.

Thanks,
Rui

> -----Original Message-----
> From: Gianluca Anzolin [mailto:gianluca@sottospazio.it]
> Sent: Wednesday, May 13, 2015 4:26 PM
> To: Zhang, Rui
> Cc: linux-acpi@vger.kernel.org
> Subject: Re: Debugging spurious wakeup
> Importance: High
> 
> On Wed, May 13, 2015 at 08:13:46AM +0000, Zhang, Rui wrote:
> > Hmm, none of them seems to be NIC related, can you please attach the
> output of lspci -vvxx as well?
> >
> 
> file attached (with I blanked the mac address)
> 
> Gianluca
