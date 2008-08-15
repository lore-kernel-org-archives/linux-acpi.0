From: Jean Delvare <khali@linux-fr.org>
Subject: Re: kernel BUG at arch/x86/mm/pat.c:233 in 2.6.27-rc3-git2
Date: Fri, 15 Aug 2008 13:09:26 +0200
Message-ID: <20080815130926.620cf987@hyperion.delvare>
References: <20080814161852.2dce7c21@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:37354 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752911AbYHOLJg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Aug 2008 07:09:36 -0400
In-Reply-To: <20080814161852.2dce7c21@hyperion.delvare>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-mm@kvack.org, linux-acpi@vger.kernel.org
Cc: Andi Kleen <ak@linux.intel.com>, lenb@kernel.org

On Thu, 14 Aug 2008 16:18:52 +0200, Jean Delvare wrote:
> The boot then completes, but network doesn't work. Kernel 2.6.26.1
> works fine on that machine, and I seem to recall that 2.6.27-rc2 did as
> well (but I'm not 100% sure.)

Correcting this: kernel 2.6.27-rc2 had the same problem.

> The board is an Intel D865GSA. I can provide additional information on
> request. I can also create an entry in bugzilla if needed.

-- 
Jean Delvare
