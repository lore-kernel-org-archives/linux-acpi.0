From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: CONFIG_IBM_BAY
Date: Thu, 15 Mar 2007 10:39:00 -0300
Message-ID: <20070315133900.GC26862@khazad-dum.debian.net>
References: <11736588493609-git-send-email-hmh@hmh.eng.br> <20070315031015.GA6292@khazad-dum.debian.net> <20070315031251.GB6292@khazad-dum.debian.net> <200703150206.05811.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:38590 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933549AbXCONjF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Mar 2007 09:39:05 -0400
Content-Disposition: inline
In-Reply-To: <200703150206.05811.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Thu, 15 Mar 2007, Len Brown wrote:
> > +config ACPI_IBM_BAY
> 
> Should this depend on ACPI_BAY=n?

It should allow both as modules, so that the user can choose which one to
run.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
