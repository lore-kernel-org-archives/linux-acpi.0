From: Len Brown <lenb@kernel.org>
Subject: Re: [GIT PULL] ibm-acpi updates
Date: Fri, 23 Feb 2007 23:13:07 -0500
Message-ID: <200702232313.07338.lenb@kernel.org>
References: <20070222205520.GA11505@khazad-dum.debian.net> <200702230129.24251.lenb@kernel.org> <20070223110855.GA11902@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59217 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933367AbXBXEVh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 23 Feb 2007 23:21:37 -0500
In-Reply-To: <20070223110855.GA11902@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Kristen Carlson Accardi <kristen.c.accardi@intel.com>

On Friday 23 February 2007 06:08, Henrique de Moraes Holschuh wrote:
> On Fri, 23 Feb 2007, Len Brown wrote:
> > +config ACPI_IBM_BAY
> > +	bool "Legacy Removable Bay Support"
> > +	depends on ACPI_IBM
> > +	default y
> > +	---help---
> > +	  Allows the ibm_acpi driver to handle removable bays.  It will allow
> > +	  disabling the device in the bay, and also generate notifications when
> > +	  the bay lever is ejected or inserted.
> > +
> > +	  If you are not sure, say Y here.
> > +
> > 
> > Why is the default Y?
> 
> ACPI_BAY is still experimental, and breaks completely on ThinkPads if
> whatever is in the bay is not a disk (e.g. if it is a battery), at least
> during boot.
> 
> Also, some thinkpads benefit from *optional* extra intelligence on bay
> handling during STR (which is not in ibm-acpi yet).  E.g. a T43 can save a
> few watts if you power off whatever is in the bay right before STR, *as long
> as it is not a battery*.
> 
> This is just an interim patch to let people easily disable ibm-acpi bay
> support.  Another patch making it default to N and depend on !ACPI_BAY can
> be added later, but since I did not have a time window to work on ACPI_BAY
> + ibm-acpi interaction yet, I fear it is a little early for that.

Thanks for the clarification, Henrique.

-Len

