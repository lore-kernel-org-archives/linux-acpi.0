From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] acpi: Unconditionally set SCI_EN on resume
Date: Tue, 11 May 2010 20:41:02 +0200
Message-ID: <201005112041.02339.rjw@sisk.pl>
References: <1273600165-16681-1-git-send-email-mjg@redhat.com> <201005112027.36923.rjw@sisk.pl> <20100511183343.GA19783@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43248 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754614Ab0EKSkA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 May 2010 14:40:00 -0400
In-Reply-To: <20100511183343.GA19783@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, linux-kernel@vger.kernel.org

On Tuesday 11 May 2010, Matthew Garrett wrote:
> On Tue, May 11, 2010 at 08:27:36PM +0200, Rafael J. Wysocki wrote:
> 
> > No, this breaks my MSI Wind U100 right away.
> > 
> > If you called acpi_enable() before that and do that depending on its result,
> > _that_ would work.
> 
> Calling acpi_enable breaks some HPs. What version of Windows did the 
> Wind ship with?

Without any.  It shipped with SLED 10. :-)

Rafael
