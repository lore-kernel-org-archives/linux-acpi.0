From: Johan Vromans <jvromans@squirrel.nl>
Subject: Re: RFC [PATCH] acpi: allow SMBus access
Date: Tue, 04 Jul 2006 10:09:06 +0200
Message-ID: <m2d5cln659.fsf@phoenix.squirrel.nl>
References: <17576.14005.767262.868190@phoenix.squirrel.nl>
	<20060703082217.GB17014@poupinou.org>
	<m2mzbrj5yp.fsf@phoenix.squirrel.nl>
	<20060703125156.GD17014@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24]:61453 "EHLO
	smtp-vbr4.xs4all.nl") by vger.kernel.org with ESMTP
	id S1751091AbWGDIJK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 4 Jul 2006 04:09:10 -0400
In-Reply-To: <20060703125156.GD17014@poupinou.org> (Bruno Ducrot's message
 of "Mon, 3 Jul 2006 14:51:56 +0200")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bruno Ducrot <ducrot@poupinou.org>
Cc: Rich Townsend <rhdt@bartol.udel.edu>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Bruno Ducrot <ducrot@poupinou.org> writes:

> I wanted to provide a real bus access via the EC driver, including
> the interrupt driven ones.

Yes, that would be the right way to go. But it is a longer term
solution and AFAIK noone is currently working on it.

In the mean time, several users can benefit from an intermediate
solution like the one I suggested. Besides, it is not a wrong solution
per se, it is equally wrong as the ac_read/write routines that are
exported.

So I still think that exporting the current acpi_ec_read/write would
be a good thing to so, but I agree it should be marked as an
intermediate solution.

-- Johan
