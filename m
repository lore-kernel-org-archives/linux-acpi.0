From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Please pull ACPI tree
Date: Mon, 21 Jul 2008 16:23:43 +0200
Message-ID: <20080721142343.GA11345@elte.hu>
References: <20080721114321.GA28786@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:55204 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752033AbYGUOXz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Jul 2008 10:23:55 -0400
Content-Disposition: inline
In-Reply-To: <20080721114321.GA28786@basil.nowhere.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: torvalds@osdl.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org


* Andi Kleen <andi@firstfloor.org> wrote:

> This reverts some double commits and a trouble some FADT patch.

> Andi Kleen (4):
>       Revert "dock: bay: Don't call acpi_walk_namespace() when ACPI is disabled."

in that commit log you say:

   Revert "dock: bay: Don't call acpi_walk_namespace() when ACPI is disabled."
   Revert double commit by mistake. Noticed by Thomas Gleixner.

it wasnt just "noticed" by Thomas, he sent a reverter patch with commit 
message and patch included. Why didnt you simply apply the patch from 
Thomas?

	Ingo
