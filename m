From: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.20-rc6-mm3
Date: Thu, 1 Feb 2007 09:01:08 +0100
Message-ID: <20070201080108.GC14378@elte.hu>
References: <20070129204528.eb8d695e.akpm@osdl.org> <200701310155.05474.fzu@wemgehoertderstaat.de> <20070131132245.GA26066@elte.hu> <200701311525.50160.fzu@wemgehoertderstaat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:46814 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030520AbXBAIC5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 Feb 2007 03:02:57 -0500
Content-Disposition: inline
In-Reply-To: <200701311525.50160.fzu@wemgehoertderstaat.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Karsten Wiese <fzu@wemgehoertderstaat.de>
Cc: Andrew Morton <akpm@osdl.org>, Maciej Rutecki <maciej.rutecki@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org


* Karsten Wiese <fzu@wemgehoertderstaat.de> wrote:

> Serial port console is off here and the jiffies update fix doesn't 
> make a noticeable difference.

ok, this eliminates my serial port theory.

and this means i'm having trouble reproducing this problem locally. 
Maybe i tried it the wrong way: does it only occur with suspend-to-disk, 
or suspend-to-ram too? Does it need ACPI suspend-to-disk, or 
software-suspend?

	Ingo
