From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] ACPI: bounds check IRQ to prevent memory corruption
Date: Sat, 2 Aug 2008 00:52:36 +0200
Message-ID: <20080801225236.GA15372@one.firstfloor.org>
References: <20080801215755.4761.92512.stgit@tigger.helgaas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:36389 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726AbYHAWwY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Aug 2008 18:52:24 -0400
Content-Disposition: inline
In-Reply-To: <20080801215755.4761.92512.stgit@tigger.helgaas>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Andi Kleen <andi@firstfloor.org>, Andrew Morton <akpm@linux-foundation.org>, Natalie Protasevich <protasnb@gmail.com>, Jack Steiner <steiner@sgi.com>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Aug 01, 2008 at 03:58:17PM -0600, Bjorn Helgaas wrote:
> 
> acpi_penalize_isa_irq() should validate irq before using it to
> index the acpi_irq_penalty[] table.

Applied to test thanks.

> I think this should go in 2.6.27.

Agreed.

-Andi
