From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] ACPI / LPSS: Don't abort acpi scan on missing mem resource.
Date: Fri, 11 Aug 2017 01:09:45 +0200
Message-ID: <5971135.yZgCNB7WaM@aspire.rjw.lan>
References: <1502266542-19268-1-git-send-email-ronald@innovation.ch> <20170809092815.GR2369@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:64707 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753322AbdHJXSE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 10 Aug 2017 19:18:04 -0400
In-Reply-To: <20170809092815.GR2369@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Ronald =?ISO-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>, Len Brown <lenb@kernel.org>
Cc: Federico Lorenzi <florenzi@gmail.com>, linux-acpi@vger.kernel.org

On Wednesday, August 9, 2017 11:28:15 AM CEST Mika Westerberg wrote:
> On Wed, Aug 09, 2017 at 01:15:42AM -0700, Ronald Tschalär wrote:
> > The keyboard and touchpad on MacBook's from 2015 onwards are connected
> > via an SPI bus. On MacBook8's (2015) the ACPI device for the SPI master
> > for this bus has _CID "INT33C1", and hence the acpi-lpss handler here is
> > triggered for it. However, the DSDT lists no memory resources for this
> > device, resulting in an error being returned by the attach callback and
> > therefore the SPI master device being ignored. This prevents us from
> > being able to register the keyboard and touchpad driver.
> > 
> > Furthermore, the controller (a Wildcat Point-LP controller) does not
> > appear to need the functionality provided by the apci-lpss handler.
> > Therefore we now just skip the handler if no memory resources are found
> > and let the ACPI scan complete successfully for this device.
> > 
> > All of this is not an issue on later MacBook(Pro)'s because their ACPI
> > SPI devices don't have any _CID and therefore no attempt is made to attach
> > this handler.
> > 
> > Returning an error was introduced in commit d3e13ff3c1aa - this restores
> > the original behaviour.
> > 
> > Link: https://github.com/cb22/macbook12-spi-driver
> > Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied, thanks!

