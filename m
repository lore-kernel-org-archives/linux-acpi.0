From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH -v2 1/5] ACPI, APEI, Fix APEI related table size checking
Date: Wed, 29 Sep 2010 08:47:13 -0700
Message-ID: <AANLkTi=JkcJiQhxLSmU2vgmrACPSrE16cEhRnxCOr_5g@mail.gmail.com>
References: <1285761235-4751-1-git-send-email-ying.huang@intel.com>
	<1285761235-4751-2-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44698 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150Ab0I2PrO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Sep 2010 11:47:14 -0400
In-Reply-To: <1285761235-4751-2-git-send-email-ying.huang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org

On Wed, Sep 29, 2010 at 4:53 AM, Huang Ying <ying.huang@intel.com> wrote:
> On Huang Ying's machine:
>
> erst_tab->header_length == sizeof(struct acpi_table_einj)

So it seems your system firmware violates the 4.0 spec

Yinghai
