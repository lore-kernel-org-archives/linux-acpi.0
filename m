From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [patch 7/7] acpi: remove old blacklist entries
Date: Wed, 3 Feb 2010 21:04:09 -0200
Message-ID: <20100203230409.GC2832@khazad-dum.debian.net>
References: <201002022238.o12Mbx54018702@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:59897 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756553Ab0BCXEN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Feb 2010 18:04:13 -0500
Content-Disposition: inline
In-Reply-To: <201002022238.o12Mbx54018702@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org, arekm@maven.pl, feng.tang@intel.com, flinco@libero.it, mad_soft@inbox.ru, mjg@redhat.com, rjw@sisk.pl

On Tue, 02 Feb 2010, akpm@linux-foundation.org wrote:
> -	/*
> -	 * Boxes that need ACPI disabled
> -	 */
> -	{
> -	 .callback = dmi_disable_acpi,
> -	 .ident = "IBM Thinkpad",
> -	 .matches = {
> -		     DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),
> -		     DMI_MATCH(DMI_BOARD_NAME, "2629H1G"),
> -		     },
> -	 },

The 2629H1G is just one of various models of the ThinkPad A21p, if one
wanted to blacklist the 2629H1G, he should have blacklisted bios_version
KY??HT*, instead, which would get all models with that BIOS (includes the
A22p models as well).

Those thinkpads had Win98 support, and probably worked better in Linux using
APM than ACPI.  That might still be true, but we'd need to find someone with
an A21p or A22p to ask.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
