From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 06/10] fujitsu-laptop: use .notify method instead of installing handler directly
Date: Tue, 31 Mar 2009 16:09:11 -0600
Message-ID: <200903311609.12829.bjorn.helgaas@hp.com>
References: <20090330174646.20905.18465.stgit@bob.kio> <20090330174839.20905.63966.stgit@bob.kio> <20090331223805.5356a323@linx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:10601 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763645AbZCaWJU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Mar 2009 18:09:20 -0400
In-Reply-To: <20090331223805.5356a323@linx.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tony Vroon <tony@linx.net>
Cc: Len Brown <lenb@kernel.org>, Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org, Carlos Corbacho <carlos@strangeworlds.co.uk>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Zhao Yakui <yakui.zhao@intel.com>, Mattia Dongili <malattia@linux.it>, Harald Welte <laforge@gnumonks.org>, Venki Pallipadi <venkatesh.pallipadi@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <mjg@redhat.com>

On Tuesday 31 March 2009 03:38:05 pm Tony Vroon wrote:
> On Mon, 30 Mar 2009 11:48:39 -0600
> Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> > This patch adds a .notify() method.  The presence of .notify() causes
> > Linux/ACPI to manage event handlers and notify handlers on our behalf,
> > so we don't have to install and remove them ourselves.
> 
> > Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > CC: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
> Acked-By: Tony Vroon <tony@linx.net>
> 
> Dock/lid/radio notifications continue to be delivered with this
> patchset applied to 2.6.29; test platform is a Fujitsu-Siemens Lifebook
> S6420 [FJNB1E6] with BIOS 1.18 (01/09/2009).
> The code also gets much easier to read. Thanks for this Bjorn.

Thanks a lot for testing this, Tony!  If you don't object, I'll also
add a "Tested-By: Tony Vroon <tony@linx.net>" and the config to these
two patches.

Bjorn
