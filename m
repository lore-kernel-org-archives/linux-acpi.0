From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 4/6] thermal: add sanity check for the passive attribute
Date: Wed, 26 Aug 2009 17:23:42 +0100
Message-ID: <20090826162342.GA15868@srcf.ucam.org>
References: <1251303445-25317-1-git-send-email-elendil@planet.nl> <1251303445-25317-5-git-send-email-elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:33419 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbZHZQXt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Aug 2009 12:23:49 -0400
Content-Disposition: inline
In-Reply-To: <1251303445-25317-5-git-send-email-elendil@planet.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>

On Wed, Aug 26, 2009 at 06:17:23PM +0200, Frans Pop wrote:
> Values below 40000 milli-celsius (limit is somewhat arbitrary)
> don't make sense and can cause the system to go into a thermal
> heart attack: the actual temperature will always be lower and
> thus the system will be throttled down to its lowest setting.

Not keen on this - it's a pretty arbitrary cutoff, and there are some 
cases where someone might want this value. Policy belongs in userspace, 
and all that.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
