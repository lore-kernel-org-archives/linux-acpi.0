From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Please pull ACPI tree
Date: Mon, 21 Jul 2008 17:09:21 +0200
Message-ID: <20080721150921.GA29543@basil.nowhere.org>
References: <20080721114321.GA28786@basil.nowhere.org> <20080721142343.GA11345@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out01.alice-dsl.net ([88.44.60.11]:9786 "EHLO
	smtp-out01.alice-dsl.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753024AbYGUPJ0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Jul 2008 11:09:26 -0400
Content-Disposition: inline
In-Reply-To: <20080721142343.GA11345@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <andi@firstfloor.org>, torvalds@osdl.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jul 21, 2008 at 04:23:43PM +0200, Ingo Molnar wrote:
> 
> * Andi Kleen <andi@firstfloor.org> wrote:
> 
> > This reverts some double commits and a trouble some FADT patch.
> 
> > Andi Kleen (4):
> >       Revert "dock: bay: Don't call acpi_walk_namespace() when ACPI is disabled."
> 
> in that commit log you say:
> 
>    Revert "dock: bay: Don't call acpi_walk_namespace() when ACPI is disabled."
>    Revert double commit by mistake. Noticed by Thomas Gleixner.
> 
> it wasnt just "noticed" by Thomas, he sent a reverter patch with commit 
> message and patch included. Why didnt you simply apply the patch from 
> Thomas?

Of course so that you have something to complain about. I know
that is your favorite pastime in the last months, so I didn't want to deny
you the fun.

Seriously, typing in git revert is the way to apply a revert.
I could have cut'n'pasted his commit message, but it didn't seem
to make much difference.

-Andi (who is amazed he has to write emails on trivialities like this) 

