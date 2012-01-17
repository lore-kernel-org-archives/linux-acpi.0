From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/5] ACPI processor: Avoid WARN message on processor driver removal
Date: Tue, 17 Jan 2012 15:25:15 +0100
Message-ID: <201201171525.15937.trenn@suse.de>
References: <1321569421-46220-1-git-send-email-trenn@suse.de> <1321569421-46220-3-git-send-email-trenn@suse.de> <4F15554F.8040900@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58226 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754376Ab2AQOZS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jan 2012 09:25:18 -0500
In-Reply-To: <4F15554F.8040900@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>

On Tuesday, January 17, 2012 12:02:39 PM Len Brown wrote:
> On 11/17/2011 05:36 PM, Thomas Renninger wrote:
...

> I think the old cold reads better than the new code,
> since I don't have to guess what "acpi_idle_active" means...
Sigh, Bjorn suggested it exactly the other way around.
I don't mind which way, back to my original post half a year
ago...
 
  Thomas
