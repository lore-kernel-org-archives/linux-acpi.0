From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: Debugging spurious wakeup
Date: Wed, 13 May 2015 08:13:46 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B90926301501237@SHSMSX101.ccr.corp.intel.com>
References: <20150513065825.GA10680@sottospazio.it>
 <744357E9AAD1214791ACBA4B0B90926301501164@SHSMSX101.ccr.corp.intel.com>
 <20150513081203.GA11182@sottospazio.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:43129 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752412AbbEMINu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 May 2015 04:13:50 -0400
In-Reply-To: <20150513081203.GA11182@sottospazio.it>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Gianluca Anzolin <gianluca@sottospazio.it>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hmm, none of them seems to be NIC related, can you please attach the output of lspci -vvxx as well?

> -----Original Message-----
> From: Gianluca Anzolin [mailto:gianluca@sottospazio.it]
> Sent: Wednesday, May 13, 2015 4:12 PM
> To: Zhang, Rui
> Cc: linux-acpi@vger.kernel.org
> Subject: Re: Debugging spurious wakeup
> Importance: High
> 
> On Wed, May 13, 2015 at 07:46:09AM +0000, Zhang, Rui wrote:
> > Please attach the output of "cat /proc/acpi/wakeup".
> >
> > Thanks,
> > rui
> 
> File attached.
> 
> Thank you,
> 
> Gianluca
