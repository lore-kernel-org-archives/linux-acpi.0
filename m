From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH v2] acpi: Fix regression where _PPC is not read at boot
	even when ignore_ppc=0
Date: Wed, 29 Apr 2009 23:00:37 +0100
Message-ID: <20090429220037.GA8604@srcf.ucam.org>
References: <20090415225348.GW8311@plum> <20090416002712.GX8311@plum> <200904161201.13409.trenn@suse.de> <20090416174217.GY8311@plum> <20090416224507.GA31984@srcf.ucam.org> <20090428193303.GC6968@plum> <20090428195348.GA8376@srcf.ucam.org> <20090429213930.GE6968@plum>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:52645 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465AbZD2WAm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Apr 2009 18:00:42 -0400
Content-Disposition: inline
In-Reply-To: <20090429213930.GE6968@plum>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: Thomas Renninger <trenn@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, cpufreq@vger.kernel.org, linux-acpi@vger.kernel.org

On Wed, Apr 29, 2009 at 02:39:31PM -0700, Darrick J. Wong wrote:

> I don't know about XP's copy of intelppm.sys, but this would seem to confirm
> that WS03 and WS08 check _PPC at boot time.

Ok, so that makes things interesting. From what we know about the T60 
(and based on Ingo's report), _PPC may evaluate to 2 on bootup. However, 
if this is ignored then later notifications are correct. This implies 
that Windows either ignores the initial evaluation or does something 
that triggers a notification.

The only notifications appear to be sent from event methods, so there's 
nothing obvious there that we can trigger. I'm actually quite confused 
by this now. Ingo, if you re-add that block, does your system stop 
working again?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
