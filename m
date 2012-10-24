From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Enable A20 using KBC for some MSI laptops to fix S3
 resume
Date: Wed, 24 Oct 2012 21:09:41 +0100
Message-ID: <20121024210941.3c7d2cfb@pyramind.ukuu.org.uk>
References: <201210240847.52417.linux@rainbow-software.org>
	<450396555.xT2D53NWjT@vostro.rjw.lan>
	<5e64035c-9ee0-4e76-a348-d4f9f6c7b198@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:52628 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754798Ab2JXUGi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Oct 2012 16:06:38 -0400
In-Reply-To: <5e64035c-9ee0-4e76-a348-d4f9f6c7b198@email.android.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Ondrej Zary <linux@rainbow-software.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 24 Oct 2012 12:36:04 -0700
"H. Peter Anvin" <hpa@zytor.com> wrote:

> Minor concern: it should do the wait for ready before sending each command.

Can we get a command line to do this quirk too - it strikes me that if
the MSIs rely upon it then it may be something Windows always does so
will be useful to try on other problem machines as an experiment.
