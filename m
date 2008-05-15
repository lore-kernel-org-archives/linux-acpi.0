From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 2/2] Add a passive cooling trip point if the firmware doesn't define one
Date: Thu, 15 May 2008 13:47:28 +0200
Message-ID: <87iqxfzt4f.fsf@basil.nowhere.org>
References: <20080514010000.GB21608@srcf.ucam.org>
	<20080514010300.GC21608@srcf.ucam.org>
	<20080514010820.GD21608@srcf.ucam.org>
	<200805132330.20159.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out03.alice-dsl.net ([88.44.63.5]:58555 "EHLO
	smtp-out03.alice-dsl.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740AbYEOL7p (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 May 2008 07:59:45 -0400
In-Reply-To: <200805132330.20159.lenb@kernel.org> (Len Brown's message of "Tue, 13 May 2008 23:30:20 -0400")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org

Len Brown <lenb@kernel.org> writes:
>
> Yes, I'm aware of the Dell D610, and I'm truly sorry
> that Dell built a machine with a poor thermal solution,
> didn't supply _PSV, and somehow looked after Windows
> without looking after Linux.

Do you know how it works in Windows?

> But I'm not willing to screw up Linux for the
> benefit of an obsolete screwed up Dell laptop.

Wouldn't it be possible to add a D610 specific quirk that 
simply adds a trip point for that machine only?

As long as the problem is not wide-spread over many models
a quirk is a reasonable solution.

-Andi
