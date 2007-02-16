From: "Lebedev, Vladimir P" <vladimir.p.lebedev@intel.com>
Subject: RE: [PATCH] sbs: Use i2c_smbus_xfer
Date: Fri, 16 Feb 2007 15:02:55 +0300
Message-ID: <8E389A5F2FEABA4CB1DEC35A25CB39CEA643E5@mssmsx411>
References: <20070216072513.d8a1be3f.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:1380 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751311AbXBPMDP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Feb 2007 07:03:15 -0500
Content-class: urn:content-classes:message
In-Reply-To: <20070216072513.d8a1be3f.khali@linux-fr.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-acpi@vger.kernel.org


Right now sbs driver has access to SBS via 'ec' (read/write) functions,
but it uses the i2c functions/structures - this is historical situation,
so; there are no problems (some time is needed only) to remove i2c using
from sbs driver. We are planning to do it to next release.

Thanks.
Vladimir.

-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org] 
Sent: Friday, February 16, 2007 9:25 AM
To: Lebedev, Vladimir P
Cc: linux-acpi@vger.kernel.org
Subject: Re: [PATCH] sbs: Use i2c_smbus_xfer

Vladimir,

On Fri, 16 Feb 2007 08:54:25 +0300, Lebedev, Vladimir P wrote:
> Yes, you are right, but we are going to remove i2c objects from sbs
> driver in near future.

How that? How do you plan to access SMBus devices without using i2c
functions?

Thanks,
-- 
Jean Delvare
