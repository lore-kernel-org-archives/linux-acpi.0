From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 21/21] ACPI: EC: make kernel messages more useful when GPE storm is detected
Date: Fri, 7 Nov 2008 14:54:24 +0100
Message-ID: <200811071454.25304.rjw@sisk.pl>
References: <1226032765-15330-1-git-send-email-lenb@kernel.org> <be11b915c297a6ccea17356d689d60734967f5f6.1226032677.git.len.brown@intel.com> <491407F4.4090404@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:36321 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751635AbYKGNuD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Nov 2008 08:50:03 -0500
In-Reply-To: <491407F4.4090404@tuffmail.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, stable@kernel.org

On Friday, 7 of November 2008, Alan Jenkins wrote:
> Len Brown wrote:
> > From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
> >
> > Make sure we can tell if the GPE storm workaround gets activated,
> > and avoid flooding the logs afterwards.
> >
> > http://bugzilla.kernel.org/show_bug.cgi?id=11841
> > "plenty of line "ACPI: EC: non-query interrupt received,
> >  switching to interrupt mode" in dmesg"
> >
> > Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
> > Acked-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> > Signed-off-by: Len Brown <len.brown@intel.com>
> >   
> I see the EC patches that cause this issue are part of 2.6.27-stable. 
> So I think this patch should also be applied to the -stable tree.

Good point, it should.

Thanks,
Rafael
