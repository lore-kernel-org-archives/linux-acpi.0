From: Marek Hobler <kernellist@neutrinus.com>
Subject: Re: [PATCH] Add bluetooth enabling support for toshiba_acpi
Date: Wed, 26 Sep 2007 12:12:36 +0200
Message-ID: <46FA3094.5010402@neutrinus.com>
References: <46EA538B.4050407@neutrinus.com> <200709260250.51140.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from neutrinus.com ([85.10.192.131]:2774 "EHLO neutrinus.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753132AbXIZKLi (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Wed, 26 Sep 2007 06:11:38 -0400
In-Reply-To: <200709260250.51140.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Linux-acpi@vger.kernel.org

Len Brown:
> unfortunately we don't permit additional API's under /proc
> (and have not for a long time)
> and the maitaining of this driver doesn't seem to be responding
> on moving the existing ones to sysfs.
I understand this.

Moving whole toshiba_acpi to sysfs is on my TODO list.



regards,
Marek Hobler, 'neutrinus'
-- 
GNU/Human
