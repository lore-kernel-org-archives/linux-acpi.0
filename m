From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [ibm-acpi-devel] [PATCH] ACPI: ibm-acpi: allow module to load when acpi notifiers can't be set
Date: Thu, 15 Mar 2007 16:48:40 -0300
Message-ID: <20070315194840.GF14394@khazad-dum.debian.net>
References: <20070315071019.GA22613@tuatara.stupidest.org> <20070315175113.GA6596@khazad-dum.debian.net> <20070315122654.468bdd39.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:46009 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933233AbXCOTsr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Mar 2007 15:48:47 -0400
Content-Disposition: inline
In-Reply-To: <20070315122654.468bdd39.kristen.c.accardi@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: linux-acpi@vger.kernel.org, Chris Wedgwood <cw@f00f.org>, ibm-acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>

On Thu, 15 Mar 2007, Kristen Carlson Accardi wrote:
> this patch gives me the following compile error:
> 
> drivers/acpi/ibm_acpi.c: In function ???ibm_init???:
> drivers/acpi/ibm_acpi.c:2605: warning: implicit declaration of function ???ibm_exit???
> drivers/acpi/ibm_acpi.c: At top level:
> drivers/acpi/ibm_acpi.c:2616: warning: conflicting types for ???ibm_exit???
> drivers/acpi/ibm_acpi.c:2616: error: static declaration of ???ibm_exit??? follows non-static declaration
> drivers/acpi/ibm_acpi.c:2605: error: previous implicit declaration of ???ibm_exit??? was here

Fixed in v2.  I developed it against acpi-test, which has a header file that
prototypes ibm_exit, and sent it before it finished compiling on 2.6.21.
Drat, that teaches me about not waiting for these things...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
