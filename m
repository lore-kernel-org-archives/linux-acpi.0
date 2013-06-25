From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 0/3] Fix backlight issues on some Windows 8 systems
Date: Tue, 25 Jun 2013 17:13:38 +0100
Message-ID: <20130625161338.GA27609@srcf.ucam.org>
References: <1370818899-8595-1-git-send-email-matthew.garrett@nebula.com>
 <1371937599.17761.19.camel@scapa>
 <20130625160848.GA27123@srcf.ucam.org>
 <CAKMK7uEtF9XnPem+rTQuBgAef6RDhRuj-=SdvufTa4zBs80Ssw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:54346 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182Ab3FYQNm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Jun 2013 12:13:42 -0400
Content-Disposition: inline
In-Reply-To: <CAKMK7uEtF9XnPem+rTQuBgAef6RDhRuj-=SdvufTa4zBs80Ssw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Yves-Alexis Perez <corsac@debian.org>, linux-acpi@vger.kernel.org, seth.forshee@canonical.com, joeyli.kernel@gmail.com, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Henrique de Moraes Holschuh <hmh@debian.org>

On Tue, Jun 25, 2013 at 06:10:35PM +0200, Daniel Vetter wrote:

> Do we have any chances to amend this mistake by (gradually) phasing
> out support for the direct keypress forwarding in ACPI? Or at least
> some plans?

We could make the default value of brightness_switch_enabled a config 
variable and encourage distributions to flip their behaviour.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
