From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH] ACPI / platform: add IDs for Broadcom Bluetooth and GPS
 chips
Date: Wed, 14 May 2014 14:56:11 +0300
Message-ID: <20140514115611.GB12238@xps8300>
References: <1399550344-26952-1-git-send-email-heikki.krogerus@linux.intel.com>
 <17288023.xXIEp15spG@devpool02>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:29639 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753153AbaENL4P (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 May 2014 07:56:15 -0400
Content-Disposition: inline
In-Reply-To: <17288023.xXIEp15spG@devpool02>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rolf Eike Beer <eb@emlix.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org

Hi Rolf,

On Tue, May 13, 2014 at 03:14:01PM +0200, Rolf Eike Beer wrote:
> Am Donnerstag, 8. Mai 2014, 14:59:04 schrieb Heikki Krogerus:
> > These IDs are used on Baytrail boards such as Lenovo Miix 2
> > and Asus Transformer Book T100TA. On lenovo Miix 2 8",
> > BCM4752 is called LNV4752. All the rest of the IDs are for
> > Broadcom BCM43241 module with the ID referring to different
> > revision number.
> 
> the AzureWave AW-AH691A module looks similar to me, it is identified as 
> AAM4752. However if I add it to that list I don't get anything, even with the 
> brcmfmac driver loaded. Is there any magic missing?

Which machine are you using? Could you attach the output of acpidump?

Thanks,

-- 
heikki
