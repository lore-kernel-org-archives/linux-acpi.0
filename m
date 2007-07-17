From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] ACPI: Add reboot mechanism
Date: Tue, 17 Jul 2007 17:42:38 +0200
Message-ID: <200707171742.39067.ak@suse.de>
References: <20070716180019.GA5112@google.com> <86802c440707170740i30ed2110l130dafbec8e4d4a5@mail.gmail.com> <8f95bb250707170808n19799ba5l3acd13e2ee7e0f08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:47489 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934684AbXGQPmm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jul 2007 11:42:42 -0400
In-Reply-To: <8f95bb250707170808n19799ba5l3acd13e2ee7e0f08@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Durbin <adurbin@google.com>
Cc: Yinghai Lu <yhlu.kernel@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com, akpm@osdl.org

On Tuesday 17 July 2007 17:08:19 Aaron Durbin wrote:
 
> This is true if SMIs are still flowing, and the SMI handler correctly handles
> the reset properly. I have seen cases where the SMI handler is broken which
> causes the system to perpetually hang.

Ah, that is the rationale that was missing in the first mail ...
Ok that makes some sense. Is it a common issue? 

-Andi
