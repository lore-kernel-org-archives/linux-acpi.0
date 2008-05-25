From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] ACPI: add DMI info to enable OSI(Linux) on PRIMEQUEST
Date: Sun, 25 May 2008 13:43:08 +0200
Message-ID: <20080525114308.GA5237@ucw.cz>
References: <4816F9B9.3090609@jp.fujitsu.com> <4836660B.3080406@jp.fujitsu.com> <483667A4.9000606@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4221 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755390AbYEYLnQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 25 May 2008 07:43:16 -0400
Content-Disposition: inline
In-Reply-To: <483667A4.9000606@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri 2008-05-23 15:43:48, Taku Izumi wrote:
> This patch adds DMI info to enable OSI(Linux) on 
> PRIMEQUEST.
> (PRIMEQUEST is ia64 machine.)

Why is it needed? Why needs your bios know whether it is Linux or BSD
or whatver running?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
