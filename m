From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH 091/171] ACPI: GPE enabling should happen after EC installation
Date: Wed, 30 Apr 2008 08:17:52 +0100
Message-ID: <200804300817.53800.carlos@strangeworlds.co.uk>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org> <1209551134.12515.47.camel@yakui_zhao.sh.intel.com> <200804300758.54778.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:43705 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753172AbYD3HSF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Apr 2008 03:18:05 -0400
In-Reply-To: <200804300758.54778.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>

On Wednesday 30 April 2008 07:58:53 Carlos Corbacho wrote:
> On Wednesday 30 April 2008 11:25:34 Zhao Yakui wrote:
> > On Tue, 2008-04-29 at 04:44 -0400, Len Brown wrote:
> > > From: Alexey Starikovskiy <astarikovskiy@suse.de>
> > >
> > > GPE could try to access EC region, so should not be enabled before
> > > EC is installed
> >
> > It is caused by broken bios if GPE method tries to access EC region
> > before EC is initialized correctly. It is more appropriate to fix this
> > issue by upgrading bios rather than by the patch.
> > And this patch will cause some potential problems.
>
> 1) Does the BIOS in question work under Windows?

^^^
that should be 'not work'

> 2) Does the system in question require a BIOS upgrade under Windows for
> this issue?
>
> If the answer to both of those is 'no', then the answer is that it's a
> Linux bug, and a patch of some description is appropriate.
>
> Just because there are crappy BIOS's out there, and we'd rather not put in
> nasty fixes, doesn't mean that we shouldn't.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
