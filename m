From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 0/8] [-mm] ACPI: add ACPI device sysfs interface
Date: Wed, 21 Mar 2007 16:11:44 -0300
Message-ID: <20070321191144.GA21721@khazad-dum.debian.net>
References: <1174382471.8833.79.camel@localhost.localdomain> <20070320153105.GD13042@khazad-dum.debian.net> <1174461421.8833.103.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:44159 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933751AbXCUTMH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Mar 2007 15:12:07 -0400
Content-Disposition: inline
In-Reply-To: <1174461421.8833.103.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

On Wed, 21 Mar 2007, Zhang Rui wrote:
> On Tue, 2007-03-20 at 12:31 -0300, Henrique de Moraes Holschuh wrote:
> > On Tue, 20 Mar 2007, Zhang Rui wrote:
> > > Add sysfs interface for ACPI devices.
> > 
> > While doing the ibm-acpi sysfs work (not submitted yet), I have found I need
> > something like this to properly parse simple ulongs from sysfs:
> > 
> > static int parse_strtoul(const char *buf,
> > 		unsigned long max, unsigned long *value)
> > {
> > 	char *endp;
> > 
> > 	*value = simple_strtoul(buf, &endp, 0);
> > 	while (*endp && isspace(*endp))
> > 		endp++;
> > 	if (*endp || *value > max)
> > 		return -EINVAL;
> > 
> > 	return 0;
> > }
> > 
> Sounds nice.
> But I think it can work better without the parameter "max".

Well, it is a generic parser for unsigned longs as I needed them in
ibm-acpi, where the minimum value is always zero, and there is always a
maximum value.  If you don't need "max", just remove it :-)

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
