From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH 8/8] ACPI: DMI blacklist to reduce console warnings on OSI(Linux) systems.
Date: Thu, 24 Jan 2008 02:55:14 +0000
Message-ID: <200801240255.15294.carlos@strangeworlds.co.uk>
References: <1201141967-28134-1-git-send-email-lenb@kernel.org> <a1bd4e35e8d9df24db7d7addd74cbfcc87ec9fb3.1201141721.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:38150 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbYAXCzT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Jan 2008 21:55:19 -0500
In-Reply-To: <a1bd4e35e8d9df24db7d7addd74cbfcc87ec9fb3.1201141721.git.len.brown@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

Why not just match on:

> +	.ident = "Acer",
> +	.matches = {
> +		     DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +		},
> +	},

for all Acer laptops?

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
