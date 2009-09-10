From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 5/6] thermal: Only set passive_delay for forced passive
	cooling
Date: Thu, 10 Sep 2009 17:15:16 +0100
Message-ID: <20090910161516.GA7195@srcf.ucam.org>
References: <1251303445-25317-1-git-send-email-elendil@planet.nl> <1251303445-25317-6-git-send-email-elendil@planet.nl> <20090826162537.GC15868@srcf.ucam.org> <200909101807.13874.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:39685 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbZIJQPW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Sep 2009 12:15:22 -0400
Content-Disposition: inline
In-Reply-To: <200909101807.13874.elendil@planet.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>

On Thu, Sep 10, 2009 at 06:07:12PM +0200, Frans Pop wrote:

> Have you had a chance to check this?

I think this was just an artifact of me modifying the existing logic 
rather than it being meaningful, so as long as this works for you:

Acked-by: Matthew Garrett <mjg@redhat.com>

-- 
Matthew Garrett | mjg59@srcf.ucam.org
