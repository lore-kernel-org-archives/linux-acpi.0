From: Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6 patch] ACPI should depend on, not select PCI
Date: Sun, 5 Mar 2006 14:25:54 -0800
Message-ID: <20060305142554.1d0ee460.akpm@osdl.org>
References: <20060305222136.GD20287@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:28141 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751835AbWCEWav (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 5 Mar 2006 17:30:51 -0500
In-Reply-To: <20060305222136.GD20287@stusta.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> ACPI should depend on, not select PCI.
> 

It's surprising that there's any such linkage, actually.  Is it
impossible for a non-PCI system to have ACPI?

