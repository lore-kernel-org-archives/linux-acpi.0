From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 3/5] intel_idle: Split up and provide per CPU initialization func
Date: Thu, 17 Nov 2011 23:44:45 +0100
Message-ID: <201111172344.46292.trenn@suse.de>
References: <1321569421-46220-1-git-send-email-trenn@suse.de> <1321569421-46220-4-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34968 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751322Ab1KQWos (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Nov 2011 17:44:48 -0500
In-Reply-To: <1321569421-46220-4-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

On Thursday 17 November 2011 23:36:59 Thomas Renninger wrote:

> +EXPORT_SYMBOL(intel_idle_cpu_init);
Just realized: It would be nicer if this is EXPORT_SYMBOL_GPL?
Also: This one is not used yet, but would be if processor_core.c
hotplug parts get enhanced.

Len: Would be great if you could modify this manually to EXPORT_SYMBOL_GPL
if you agree with the rest.

Thanks,

  Thomas
