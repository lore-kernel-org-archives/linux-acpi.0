From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 3/4] ipmi: Convert tracking of the ACPI device pointer to a PNP device
Date: Fri, 5 Mar 2010 12:34:39 -0700
Message-ID: <201003051234.40610.bjorn.helgaas@hp.com>
References: <20100304033146.30205.68689.stgit@bob.kio> <1267753600.3613.128.camel@localhost.localdomain> <1267807265.2411.81.camel@zim>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:1429 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635Ab0CETem (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Mar 2010 14:34:42 -0500
In-Reply-To: <1267807265.2411.81.camel@zim>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Myron Stowe <myron.stowe@hp.com>
Cc: ykzhao <yakui.zhao@intel.com>, "minyard@acm.org" <minyard@acm.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "lenb@kernel.org" <lenb@kernel.org>

On Friday 05 March 2010 09:41:05 am Myron Stowe wrote:
> By the way, if there are conflicts between our two patch series I'll =
be
> more than willing to help resolve such. =C2=A0If it ends up being eas=
ier for
> Corey to take in your series first I'll rework my series and resubmit
> it.

BTW, Corey, what's happening as far as merging Yakaui's IPMI opregion
patches?  I checked linux-next, and I don't see them there.  Are you
planning to push them upstream during this (soon-to-close) merge
window?

http://git.kernel.org/?p=3Dlinux/kernel/git/next/linux-next.git;a=3Dhis=
tory;f=3Ddrivers/char/ipmi/ipmi_si_intf.c;h=3D176f1751237f57807f3023d94=
27972dcb6614392;hb=3DHEAD

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
