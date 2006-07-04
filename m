From: Bruno Ducrot <ducrot@poupinou.org>
Subject: Re: RFC [PATCH] acpi: allow SMBus access
Date: Tue, 4 Jul 2006 11:35:10 +0200
Message-ID: <20060704093510.GG17014@poupinou.org>
References: <17576.14005.767262.868190@phoenix.squirrel.nl> <20060703082217.GB17014@poupinou.org> <m2mzbrj5yp.fsf@phoenix.squirrel.nl> <20060703125156.GD17014@poupinou.org> <m2d5cln659.fsf@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from poup.poupinou.org ([195.101.94.96]:46379 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S1751258AbWGDJfS
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 4 Jul 2006 05:35:18 -0400
Content-Disposition: inline
In-Reply-To: <m2d5cln659.fsf@phoenix.squirrel.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johan Vromans <jvromans@squirrel.nl>
Cc: Rich Townsend <rhdt@bartol.udel.edu>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tue, Jul 04, 2006 at 10:09:06AM +0200, Johan Vromans wrote:
> Bruno Ducrot <ducrot@poupinou.org> writes:
> 
> > I wanted to provide a real bus access via the EC driver, including
> > the interrupt driven ones.
> 
> Yes, that would be the right way to go. But it is a longer term
> solution and AFAIK noone is currently working on it.

Indeed

> In the mean time, several users can benefit from an intermediate
> solution like the one I suggested. Besides, it is not a wrong solution
> per se, it is equally wrong as the ac_read/write routines that are
> exported.

Yes, but I always considered the ec_read/write functions being an hack
in order to support sonypi at first.  If it's possible to kill them
and to replace them with the acpi_ec_read|write, well this would be
good IMHO.

> So I still think that exporting the current acpi_ec_read/write would
> be a good thing to so, but I agree it should be marked as an
> intermediate solution.

An intermediate solution would be to use the already existing
ec_read|write instead of the one you want to use.  The original
SMBus driver used acpi_ec_read because the author wanted to be
sure that driver will support laptops with more than one EC, but
he never saw such laptops so far.

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
