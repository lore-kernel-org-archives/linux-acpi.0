From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 6/8] PNP: replace pnp_resource_table with dynamically allocated resources
Date: Fri, 16 May 2008 11:17:25 -0600
Message-ID: <200805161117.26288.bjorn.helgaas@hp.com>
References: <20080505223630.682082986@ldl.fc.hp.com> <200805141718.35158.bjorn.helgaas@hp.com> <482BEC42.9060605@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:37604 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbYEPS0o (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 May 2008 14:26:44 -0400
In-Reply-To: <482BEC42.9060605@keyaccess.nl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>

On Thursday 15 May 2008 01:54:42 am Rene Herman wrote:
> On 15-05-08 01:18, Bjorn Helgaas wrote:
> 
> > Thanks for the report.  I think I've fixed the problem.
> 
> I saw it was PnPBIOS by the way. PnPBIOS appears to be obsolete these 
> days; do you have machines to test it on yourself? I do (plenty), so 
> although I'm not being fast with testing anyway, would you want me to 
> switch those from PnPACPI to PnPBIOS?

All of my machines have ACPI, but in this case, I was able to
reproduce the null pointer dereference Andrew by booting with
"pnpacpi=off".

PNPBIOS testing is pretty scarce, though, so anything you
do along those lines would be much appreciated.

Bjorn
