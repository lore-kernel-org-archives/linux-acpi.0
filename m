From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] ACPI / LPSS: Don't abort acpi scan on missing mem
 resource.
Date: Wed, 9 Aug 2017 12:28:15 +0300
Message-ID: <20170809092815.GR2369@lahna.fi.intel.com>
References: <1502266542-19268-1-git-send-email-ronald@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:49830 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752442AbdHIJ2T (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 9 Aug 2017 05:28:19 -0400
Content-Disposition: inline
In-Reply-To: <1502266542-19268-1-git-send-email-ronald@innovation.ch>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Federico Lorenzi <florenzi@gmail.com>, linux-acpi@vger.kernel.org

On Wed, Aug 09, 2017 at 01:15:42AM -0700, Ronald Tschalär wrote:
> The keyboard and touchpad on MacBook's from 2015 onwards are connected
> via an SPI bus. On MacBook8's (2015) the ACPI device for the SPI master
> for this bus has _CID "INT33C1", and hence the acpi-lpss handler here is
> triggered for it. However, the DSDT lists no memory resources for this
> device, resulting in an error being returned by the attach callback and
> therefore the SPI master device being ignored. This prevents us from
> being able to register the keyboard and touchpad driver.
> 
> Furthermore, the controller (a Wildcat Point-LP controller) does not
> appear to need the functionality provided by the apci-lpss handler.
> Therefore we now just skip the handler if no memory resources are found
> and let the ACPI scan complete successfully for this device.
> 
> All of this is not an issue on later MacBook(Pro)'s because their ACPI
> SPI devices don't have any _CID and therefore no attempt is made to attach
> this handler.
> 
> Returning an error was introduced in commit d3e13ff3c1aa - this restores
> the original behaviour.
> 
> Link: https://github.com/cb22/macbook12-spi-driver
> Signed-off-by: Ronald Tschalär <ronald@innovation.ch>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
