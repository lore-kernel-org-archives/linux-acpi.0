From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [PATCH] thinkpad-acpi: fix module autoloading for older models
Date: Sat, 14 Mar 2009 16:14:19 +0100
Message-ID: <ac3eb2510903140814t26954869m4f07623c25b5948f@mail.gmail.com>
References: <20090314104204.GA11226@mobydick>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:38907 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbZCNPOW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 14 Mar 2009 11:14:22 -0400
In-Reply-To: <20090314104204.GA11226@mobydick>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mathieu Chouquet-Stringer <mchouque@free.fr>, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, Len Brown <lenb@kernel.org>, ibm-acpi-devel@lists.sourceforge.net, linux-acp

On Sat, Mar 14, 2009 at 11:42, Mathieu Chouquet-Stringer
<mchouque@free.fr> wrote:

> While for older Thinkpads, you do this (for instance):
> IBM_BIOS_MODULE_ALIAS("1[0,3,6,8,A-G,I,K,M-P,S,T]");

Aliases are shell-style globs. Any idea what the ',' are doing in a
character class? Confused ...

Thanks,
Kay
