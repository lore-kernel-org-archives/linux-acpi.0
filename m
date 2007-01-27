From: Andrew Morton <akpm@osdl.org>
Subject: Re: x86_64-mm-always-use-physical-delivery-mode-on-8-cpus vs
 git-acpi
Date: Sat, 27 Jan 2007 01:38:24 -0800
Message-ID: <20070127013824.e646a73c.akpm@osdl.org>
References: <20070126172402.77a3edbc.akpm@osdl.org>
	<200701270429.57170.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:46641 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752227AbXA0Jjr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 27 Jan 2007 04:39:47 -0500
In-Reply-To: <200701270429.57170.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andi Kleen <ak@muc.de>, linux-acpi@vger.kernel.org

On Sat, 27 Jan 2007 04:29:57 -0500
Len Brown <lenb@kernel.org> wrote:

> On Friday 26 January 2007 20:24, Andrew Morton wrote:
> > 
> > The new stuff which just landed in Len's tree caused a huge mess in
> > arch/x86_64/kernel/genapic.c:clustered_apic_check() when applying
> > ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches/always-use-physical-delivery-mode-on-8-cpus
> > on top of it.
> 
> The ACPI change this cleanup patch is conflicting with is quite small:

Oh, OK.  I'll take another lok at it if/when I manage to get next -mm out
the door (over 40 compilation fixes needed so far).

