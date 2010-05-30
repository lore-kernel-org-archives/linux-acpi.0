From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Linux 2.6.34 causes system lockup on Compaq Presario 2200
 Laptop
Date: Sat, 29 May 2010 20:22:53 -0700
Message-ID: <20100529202253.0bd18bbd.akpm@linux-foundation.org>
References: <AANLkTil6GGSoc8TpzRacr1LZBZS3ee3H1ejYDSqfdul4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51966 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754247Ab0E3DW4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 29 May 2010 23:22:56 -0400
In-Reply-To: <AANLkTil6GGSoc8TpzRacr1LZBZS3ee3H1ejYDSqfdul4@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeffrey Merkey <jeffmerkey@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

(cc linux-acpi)

On Thu, 27 May 2010 12:08:48 -0600 Jeffrey Merkey <jeffmerkey@gmail.com> wrote:

> 2.6.34 causes a hard system lockup when the screen blanking activates
> for more than 10 minutes with low battery power.  Also misreports
> battery level as "battery broken at 14%" when the battery is fully
> charged.  Does not occur with 2.6.28 but 2.6.33 also seems to do it as
> well.  software debugging tools useless as the keyboard does not
> respond.
> 

