From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] ACPI: Add reboot mechanism
Date: Tue, 17 Jul 2007 13:31:59 +0200
Message-ID: <200707171331.59414.ak@suse.de>
References: <20070716180019.GA5112@google.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:47825 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752495AbXGQLhv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jul 2007 07:37:51 -0400
In-Reply-To: <20070716180019.GA5112@google.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Durbin <adurbin@google.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com, akpm@osdl.org

On Monday 16 July 2007 20:00:19 Aaron Durbin wrote:
> 
> Add the ability to reset the machine using the RESET_REG in ACPI's FADT table.

Why? I had such a patch at some point as experiment, but it never
helped actually fix a box.

-Andi
