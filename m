From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 3/3] ipmi/acpi: Install the IPMI space handler to enable ACPI to access the BMC controller
Date: Thu, 17 Dec 2009 15:54:38 -0700
Message-ID: <200912171554.39534.bjorn.helgaas@hp.com>
References: <1260974431-4330-1-git-send-email-yakui.zhao@intel.com> <1260974431-4330-2-git-send-email-yakui.zhao@intel.com> <1260974431-4330-3-git-send-email-yakui.zhao@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g6t0185.atlanta.hp.com ([15.193.32.62]:4792 "EHLO
	g6t0185.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413AbZLQXEE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Dec 2009 18:04:04 -0500
In-Reply-To: <1260974431-4330-3-git-send-email-yakui.zhao@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui.zhao@intel.com
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, minyard@acm.org, openipmi-developer@lists.sourceforege.net

On Wednesday 16 December 2009 07:40:31 am yakui.zhao@intel.com wrote:
> From: Zhao Yakui <yakui.zhao@intel.com>
> 
> V2->V3: According to Bjorn's comment, this IPMI opregion code is put into
> the IPMI subsystem(ipmi_si_intf.c). In such case the part of IPMI opregion
> code  will be installed automatically when IPMI detection module is loaded.
> When the IPMI system interface is detected by loading PNP device driver, we
> will record every IPMI system interface defined in ACPI namespace and then
> install the corresponding IPMI opregion space handler, which is used to enable
> ACPI AML code to access the BMC controller.
> 
> V1->V2: According to Bjorn's comment, we won't install the IPMI space handler
> by loading an ACPI device driver. Instead we will enumerate the ACPI IPMI
> device directly in ACPI device tree and then install the IPMI space handler.
> Then ACPI AML code and access the BMC controller through the IPMI space
> handler.

Oh, BTW, it's handy if you add a [0/n] email with the overview, and
put the V2->V3 stuff in there.  The [0/n] text doesn't become part of
the commit, so the logs don't get cluttered with all the development
history.  Also, please include the version in the subject somewhere,
e.g., "[PATCH v3 0/n] ..."

Bjorn
