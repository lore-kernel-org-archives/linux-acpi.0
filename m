From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
Date: Thu, 13 Nov 2008 00:56:13 +0000
Message-ID: <20081113005613.GA23943@srcf.ucam.org>
References: <200810192350.57993.trenn@suse.de> <20081111005856.GA10535@srcf.ucam.org> <200811121758.39105.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:51478 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbYKMA4V (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Nov 2008 19:56:21 -0500
Content-Disposition: inline
In-Reply-To: <200811121758.39105.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "devel@acpica.org" <devel@acpica.org>

On Wed, Nov 12, 2008 at 05:58:37PM -0600, Thomas Renninger wrote:
> On Monday 10 November 2008 06:58:56 pm Matthew Garrett wrote:
> > I've now had confirmation from multiple sources that Vista still uses
> > the 32-bit addresses for the GPE blocks.
> Are you sure that Windows Server implementations also use 32-bit addresses?

Yes.

> Are you sure that upcoming Windows implementations will always use 32-bit 
> addresses?

I'm sure that Microsoft will not break widespread hardware, yes.

> Do all X86 machines support Windows or could there be machines, especially 
> servers which only support Mac OS, Solaris/Linux or other OSes which stick to 
> the spec which you break with this change?

Do you have any examples of machines that this would break?

> > We're actually seeing the same 
> > bug on some currently shipping machines
> Which ones?

Various workstations from HP.

> I also disagree with violating the spec unconditionally, breaking machines 
> which would stick to it. It's likely that machines do not get a latest 
> mainline kernel tests. Once this change is in distributions and machines do 
> break, people are busted. There should at least be a boot param to switch 
> back.

*Which* machines would this break? Who would put a good value in the 
64-bit field and a bad one in the 32-bit field? Note that the patch 
checks whether the 32-bit field is unset and whether the 64-bit field 
refers to system IO space.

> We might come away with it. But I have the strong feeling that there are 
> machines running better using 32-bit and machines running better with 64-bit 
> addresses used.

If you can find a single example of the latter case, I'll be 
astonishingly surprised.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
