From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] sbs: Use i2c_smbus_xfer
Date: Fri, 16 Feb 2007 07:25:13 +0100
Message-ID: <20070216072513.d8a1be3f.khali@linux-fr.org>
References: <20070215215215.ccb9c132.khali@linux-fr.org>
	<8E389A5F2FEABA4CB1DEC35A25CB39CEA642CD@mssmsx411>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-105-friday.nerim.net ([62.4.16.105]:4128 "EHLO
	kraid.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932484AbXBPGYo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Feb 2007 01:24:44 -0500
In-Reply-To: <8E389A5F2FEABA4CB1DEC35A25CB39CEA642CD@mssmsx411>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lebedev, Vladimir P" <vladimir.p.lebedev@intel.com>
Cc: linux-acpi@vger.kernel.org

Vladimir,

On Fri, 16 Feb 2007 08:54:25 +0300, Lebedev, Vladimir P wrote:
> Yes, you are right, but we are going to remove i2c objects from sbs
> driver in near future.

How that? How do you plan to access SMBus devices without using i2c
functions?

Thanks,
-- 
Jean Delvare
