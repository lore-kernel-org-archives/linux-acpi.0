From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: CONFIG_IBM_BAY
Date: Thu, 15 Mar 2007 08:06:44 -0700
Message-ID: <20070315080644.c73db24a.kristen.c.accardi@intel.com>
References: <11736588493609-git-send-email-hmh@hmh.eng.br>
	<20070315031015.GA6292@khazad-dum.debian.net>
	<20070315031251.GB6292@khazad-dum.debian.net>
	<200703150206.05811.lenb@kernel.org>
	<20070315133900.GC26862@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44596 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422883AbXCOPJj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Mar 2007 11:09:39 -0400
In-Reply-To: <20070315133900.GC26862@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Thu, 15 Mar 2007 10:39:00 -0300
Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote:

> On Thu, 15 Mar 2007, Len Brown wrote:
> > > +config ACPI_IBM_BAY
> > 
> > Should this depend on ACPI_BAY=n?
> 
> It should allow both as modules, so that the user can choose which one to
> run.

Doesn't this option enable support for controlling the bay device via ibm_acpi?
If so - if you compile this one, then the user who chooses to use bay.ko instead
to control the bay can not use ibm_acpi at all to control the remaining
functionality.  I feel this should be dependent on ACPI_BAY=n.
 
