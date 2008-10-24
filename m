From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: Oops in ACPI with git latest
Date: Fri, 24 Oct 2008 12:22:32 -0700
Message-ID: <200810241222.32979.jbarnes@virtuousgeek.org>
References: <1224791103.3330.37.camel@localhost.localdomain> <200810241104.19704.jbarnes@virtuousgeek.org> <200810242043.04078.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-32.bluehost.com ([69.89.18.152]:58667 "HELO
	outbound-mail-32.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750936AbYJXTWn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Oct 2008 15:22:43 -0400
In-Reply-To: <200810242043.04078.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Moore, Robert" <robert.moore@intel.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Friday, October 24, 2008 11:43 am Rafael J. Wysocki wrote:
> On Friday, 24 of October 2008, Jesse Barnes wrote:
> > So who wants to send me a final patch for this?
>
> I already did: http://marc.info/?l=linux-kernel&m=122484871717023&w=4
> but I can remove the "!output.pointer || " if you prefer. :-)

Yeah Bob said it would likely contain garbage anyway, so we should just remove 
it.

Jesse
