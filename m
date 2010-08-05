From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 4/4] ACPI, APEI, ERST debug support
Date: Thu, 5 Aug 2010 10:27:37 +0200
Message-ID: <201008051027.37573.trenn@suse.de>
References: <1280735305-15379-1-git-send-email-ying.huang@intel.com> <1280735305-15379-5-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50522 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759845Ab0HEIYW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 5 Aug 2010 04:24:22 -0400
In-Reply-To: <1280735305-15379-5-git-send-email-ying.huang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, linux-acpi@vger.kernel.org

On Monday 02 August 2010 09:48:25 Huang Ying wrote:
> This patch adds debugging/testing support to ERST. A misc device is
> implemented to export raw ERST read/write/clear etc operations to user
> space. With this patch, we can add ERST testing support to
> linuxfirmwarekit ISO (linuxfirmwarekit.org) to verify the kernel
> support and the firmware implementation.

Shouldn't this show up in debugfs?

      Thomas
