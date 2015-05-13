From: Gianluca Anzolin <gianluca@sottospazio.it>
Subject: Re: Debugging spurious wakeup
Date: Wed, 13 May 2015 10:12:03 +0200
Message-ID: <20150513081203.GA11182@sottospazio.it>
References: <20150513065825.GA10680@sottospazio.it>
 <744357E9AAD1214791ACBA4B0B90926301501164@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from m-r2.th.seeweb.it ([5.144.164.171]:36576 "EHLO
	m-r2.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932505AbbEMIMH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 May 2015 04:12:07 -0400
Content-Disposition: inline
In-Reply-To: <744357E9AAD1214791ACBA4B0B90926301501164@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 13, 2015 at 07:46:09AM +0000, Zhang, Rui wrote:
> Please attach the output of "cat /proc/acpi/wakeup".
> 
> Thanks,
> rui

File attached.

Thank you,

Gianluca

--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="wakeup.txt"

Device	S-state	  Status   Sysfs node
PS2K	  S4	*disabled
PS2M	  S4	*disabled
UAR1	  S4	*disabled  pnp:00:06
P0P1	  S4	*disabled  pci:0000:00:1e.0
RP01	  S4	*disabled  pci:0000:00:1c.0
PXSX	  S4	*disabled
RP02	  S4	*disabled
PXSX	  S4	*disabled
RP03	  S4	*disabled
PXSX	  S4	*disabled
RP04	  S4	*disabled
PXSX	  S4	*disabled
RP05	  S4	*disabled
PXSX	  S4	*disabled
RP06	  S4	*disabled  pci:0000:00:1c.5
PXSX	  S4	*enabled   pci:0000:04:00.0
RP08	  S4	*disabled  pci:0000:00:1c.7
PXSX	  S4	*enabled   pci:0000:06:00.0
PEG0	  S4	*disabled  pci:0000:00:01.0
PEGP	  S4	*disabled
PEG1	  S4	*disabled
PEG2	  S4	*disabled
PEG3	  S4	*disabled  pci:0000:00:06.0
RP07	  S4	*disabled  pci:0000:00:1c.6
GLAN	  S4	*disabled
EHC1	  S4	*enabled   pci:0000:00:1d.0
EHC2	  S4	*disabled  pci:0000:00:1a.0
XHC	  S4	*disabled
HDEF	  S4	*disabled  pci:0000:00:1b.0
PWRB	  S4	*enabled   platform:PNP0C0C:00

--fUYQa+Pmc3FrFX/N--
