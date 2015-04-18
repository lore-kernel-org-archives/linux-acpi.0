From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: Help with debugging intermittent crash on resume from
 hibernation
Date: Sat, 18 Apr 2015 06:01:43 +0200
Message-ID: <1429329703.4034.4.camel@gmail.com>
References: <8761a3s1vq.fsf@vostro.rath.org>
	 <87vbhwwdzz.fsf@vostro.rath.org> <1426823821.3150.4.camel@gmail.com>
	 <5531CC47.9000008@rath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:36346 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbbDRECC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 18 Apr 2015 00:02:02 -0400
In-Reply-To: <5531CC47.9000008@rath.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Nikolaus Rath <Nikolaus@rath.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>

On Fri, 2015-04-17 at 20:15 -0700, Nikolaus Rath wrote:
> 
> Is there anything I can do to help debug this issue?

You could try to bisect it, but judging from the problem description, 
that could be more like a career than a troubleshooting session.

        -Mike
