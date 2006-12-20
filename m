From: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 04/19] acpi: replace kmalloc+memset with kzalloc
Date: Wed, 20 Dec 2006 00:42:07 -0800
Message-ID: <20061220004207.4682bd03.akpm@osdl.org>
References: <200612192056.kBJKuBZX010017@shell0.pdx.osdl.net>
	<200612200043.19375.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:46680 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964934AbWLTImw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Dec 2006 03:42:52 -0500
In-Reply-To: <200612200043.19375.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, yan_952@hotmail.com

On Wed, 20 Dec 2006 00:43:19 -0500
Len Brown <lenb@kernel.org> wrote:

> Cleanup patches like this make it very difficult to work with -mm,
> as they conflict with just about every possible change.

hm, I'm a little surprised - I maintain the patch so it applies against
your tree.  I guess you have other stuff outstanding.

> This means that if I don't apply patches in the same order
> as Andrew's quilt series, then I've got merge hell.
> And experience shows that there is a 0% chance that
> I can apply patches in the order that -mm does.
> 
> All this, for zero functional benefit.
> 
> Andrew, please do not accept cleanup patches in -mm
> that touch ACPI files.  It would be easier if they were
> sent to me and I got to choose when the "flag days" occur
> based on what other patches are in the queue to Linus.

It _was_ sent to you - I just sent it ;)

In future I'll stage patches like this at the tail of the -mm acpi queue so
the more substantive things don't get tangled up with it.

