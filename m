From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI / LPSS: Don't abort acpi scan on missing mem
 resource.
Date: Mon, 7 Aug 2017 13:47:09 +0300
Message-ID: <20170807104709.GU2369@lahna.fi.intel.com>
References: <1501890376-2662-1-git-send-email-ronald@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:62309 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752606AbdHGKrN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Aug 2017 06:47:13 -0400
Content-Disposition: inline
In-Reply-To: <1501890376-2662-1-git-send-email-ronald@innovation.ch>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Federico Lorenzi <florenzi@gmail.com>, linux-acpi@vger.kernel.org

On Fri, Aug 04, 2017 at 04:46:16PM -0700, Ronald Tschalär wrote:
> On MacBook8's (2015) there appears to be no memory resource for the
> SPI master device. Returning an error here in this case then leads to
> the acpi device being ignored completely instead of just the handler
> being skipped.

What's the problem if we prevent creation of the SPI master device? How
does user see the issue? It is not like the SPI driver could use the
device anyway.

Just trying to understand why we would want to change the behaviour.
