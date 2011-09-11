From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] ACPI, APEI, fix ERST table size checking
Date: Sun, 11 Sep 2011 23:46:22 +0200
Message-ID: <201109112346.23236.trenn@suse.de>
References: <1315256856-14170-1-git-send-email-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45073 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754734Ab1IKVqS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 11 Sep 2011 17:46:18 -0400
In-Reply-To: <1315256856-14170-1-git-send-email-colin.king@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Monday 05 September 2011 23:07:36 Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Check ERST size against acpi_table_erst rather than
> acpi_table_einj.  The original code just so happened to work
> because the ERST and EINJ headers are the same size.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
This looks like a candidate for stable and should either get:
CC: stable@kernel.org
or get submitted there manually.

Thanks,

   Thomas
