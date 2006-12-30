From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] ACPI: ibm-acpi: fix Kconfig entries for ibm-acpi bay and dock
Date: Sat, 30 Dec 2006 17:55:20 -0200
Message-ID: <20061230195520.GA15811@khazad-dum.debian.net>
References: <20061230192618.13533.29790.stgit@thorin.khazad-dum.debian.net> <20061230192649.13533.53575.stgit@thorin.khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:51401 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030326AbWL3TzZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 30 Dec 2006 14:55:25 -0500
Content-Disposition: inline
In-Reply-To: <20061230192649.13533.53575.stgit@thorin.khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Sat, 30 Dec 2006, Henrique de Moraes Holschuh wrote:
> Support for ACPI_BAY has not been merged in mainline yet.  Usage of
> "depends on FOO=n" fails if FOO is undefined, thus ibm-acpi support
> for bay was being made non-available in a kernel that has no other
> sort of bay support.
> 
> Fix it to use "depends on ! FOO" instead, that does the right thing
> when FOO is undefined.  Fix ACPI_IBM_DOCK accordingly as well while
> at it, and also improve the help text.

Either this patch, or a different fix (see below), should to be sent to
Linus.  Otherwise, it causes a regression (lack of removable bay support in
ibm-acpi).

Unfortunately, I didn't notice the problem before because I had ACPI_BAY
applied to my 2.6.18 and 2.6.19 test trees.

The patch uses "depends on ! FOO", which means the legacy support in
ibm-acpi can be selected if ACPI_DOCK or ACPI_BAY is set to "m" (module).
Loading ACPI_DOCK or ACPI_BAY module along with ibm-acpi and ACPI_IBM_DOCK
or ACPI_IBM_BAY could cause weird behaviour (untested) on some systems.

There are alternate ways to fix this.  The easiest would be to revert commit
2df910b4c3edcce9a0c12394db6f5f4a6e69c712 from Linus' tree, and I'd submit it
again when ACPI_BAY is ready to be sent to mainline.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
