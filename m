From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [0/12] acpi: make ACPI use driver model
Date: Fri, 24 Nov 2006 09:07:01 -0200
Message-ID: <20061124110701.GA2287@khazad-dum.debian.net>
References: <1158916460.11985.45.camel@localhost.localdomain> <200611222307.26536.len.brown@intel.com> <1164257655.5461.96.camel@localhost.localdomain> <200611232338.06895.len.brown@intel.com> <1164348080.5768.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:24531 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1757673AbWKXLHH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 06:07:07 -0500
Content-Disposition: inline
In-Reply-To: <1164348080.5768.32.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger" <linux-acpi@vger.kernel.org>

On Fri, 24 Nov 2006, Zhang Rui wrote:
> The problem is the driver name "ibm/hotkey".
> '/' and "\0" can not exist in an kobject->name.
> In driver/acpi/ibm_acpi.c line 1828, please replace the '/' with '-' or
> any other character and try again :)

ACK.  Patch to fix this throughout ibm-acpi being written right now.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
