From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: suspend to RAM failure on t61p
Date: Tue, 11 Dec 2007 02:31:36 -0800
Message-ID: <20071211023136.b01a1dd7.akpm@linux-foundation.org>
References: <20071209011928.c9873c66.akpm@linux-foundation.org>
	<200712100204.13881.rjw@sisk.pl>
	<20071209232547.1d0c6599.akpm@linux-foundation.org>
	<200712101206.15037.rjw@sisk.pl>
	<20071210222156.f51dd114.akpm@linux-foundation.org>
	<20071210225858.f9746533.akpm@linux-foundation.org>
	<20071211015751.3a786fb4.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54584 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751864AbXLKKbm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Dec 2007 05:31:42 -0500
In-Reply-To: <20071211015751.3a786fb4.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Tomas Carnecky <tom@dbservice.com>, linux-acpi@vger.kernel.org

On Tue, 11 Dec 2007 01:57:51 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> Now let me see what caused the keystrokes-no-longer-trigger-resume-from-RAM
> regression.

OK, I must have dreamed this - 2.6.23 requires a power-button tap to
come back from suspend-to-RAM as well.
