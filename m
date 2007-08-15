From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: Battery: add sysfs support
Date: Wed, 15 Aug 2007 00:47:55 -0400
Message-ID: <200708150047.55528.lenb@kernel.org>
References: <46BE1383.8000205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49879 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750880AbXHOEsD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Aug 2007 00:48:03 -0400
In-Reply-To: <46BE1383.8000205@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Saturday 11 August 2007 15:52, Alexey Starikovskiy wrote:
> Hi Len,
> 
> This is a first try to add sysfs support for ACPI battery.
> It should apply on top of clean up patches I sent earlier.
> It lacks alarm support in sysfs, as power_supply class does not support it.

The check-in comments should describe the sysfs support.
it is an API that is being created here -- after all.

thanks,
-len
