From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH 2/4] acer-wmi: Make device detection error messages more descriptive
Date: Tue, 11 Mar 2008 22:10:45 +0000
Message-ID: <200803112210.45888.carlos@strangeworlds.co.uk>
References: <20080224133412.2317.5802.stgit@pacifica> <20080224133424.2317.90354.stgit@pacifica> <200803111757.37771.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:56292 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754508AbYCKWKw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Mar 2008 18:10:52 -0400
In-Reply-To: <200803111757.37771.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Tuesday 11 March 2008 21:57:37 Len Brown wrote:
> Instead, to get under 80 columns, you simpmly want to do something like
> this:
>
> printk(ACER_ERR "Unable to detect available WMID "
> 	"devices");

Will do.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
