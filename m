From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI / PM: Blacklist another machine that needs acpi_sleep=nonvs
Date: Tue, 26 Oct 2010 20:49:21 +0200
Message-ID: <201010262049.21424.rjw@sisk.pl>
References: <201010172101.21576.rjw@sisk.pl> <alpine.LFD.2.00.1010252013270.18670@localhost.localdomain> <20101026131948.GA9221@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:55359 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759041Ab0JZSuV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Oct 2010 14:50:21 -0400
In-Reply-To: <20101026131948.GA9221@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Emanuele Bigiarini <pulmro@gmail.com>

On Tuesday, October 26, 2010, Matthew Garrett wrote:
> On Mon, Oct 25, 2010 at 08:14:42PM -0400, Len Brown wrote:
> > Rather than a black list of machines that can not survive saving NVS,
> > I wonder how long a white list of machines requiring NVS save would be?
> 
> Windows saves the NVS area in my testing. Either there's something that 
> indicates the choices of one behaviour over the other, or the machines 
> that are broken by NVS saving are actually tripping some other bug.

Since we're claiming Windows compatibility through _OSI, we should follow
Windows except for on machines that are blacklisted as not being
Windows-compatible.

Thanks,
Rafael
