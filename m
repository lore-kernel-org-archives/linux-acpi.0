From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH -v2 3/4] ACPI, APEI, Add APEI bit support in generic _OSC call
Date: Mon, 4 Jul 2011 12:28:51 +0200
Message-ID: <201107041228.51671.trenn@suse.de>
References: <1309163160-3201-1-git-send-email-ying.huang@intel.com> <1309163160-3201-4-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42315 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754289Ab1GDK24 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Jul 2011 06:28:56 -0400
In-Reply-To: <1309163160-3201-4-git-send-email-ying.huang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org

On Monday, June 27, 2011 10:25:59 AM Huang Ying wrote:

>  extern bool osc_sb_apei_support_acked;
>  
> +extern bool osc_sb_apei_support_acked;
> +
double osc_sb_apei_support_acked declaration?

   Thomas
