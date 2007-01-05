From: Len Brown <lenb@kernel.org>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Date: Fri, 5 Jan 2007 12:19:00 -0500
Message-ID: <200701051219.00509.lenb@kernel.org>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net> <20070104191512.GC25619@inferi.kami.home> <459E1909.9020703@fnxweb.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51018 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422633AbXAERTy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 5 Jan 2007 12:19:54 -0500
In-Reply-To: <459E1909.9020703@fnxweb.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Neil Bird <neil@fnxweb.com>
Cc: linux-acpi@vger.kernel.org, malattia@linux.it

On Friday 05 January 2007 04:23, Neil Bird wrote:

>    But last time I tried (couple of kernel releases ago) it crashes on 
> start-up;  I think it's something to do with kmallocs in the ACPI code tyhat 
> I'm calling that aren't allowed in certain contexts, buit I have no control 
> over what kmallocs are used in acpi.

running the AML interpreter in  interrupt context would be a no-no.

I thought we had deferred the notify handlers so that they wouldn't
run in interrupt context, but maybe there is a case here where
that does not happen.

-Len
