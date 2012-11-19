From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v5 RESEND 1/5] ACPI: Add acpi_pr_<level>() interfaces
Date: Mon, 19 Nov 2012 08:06:32 -0800
Message-ID: <1353341192.5287.9.camel@joe-AO722>
References: <1352214130-12055-1-git-send-email-toshi.kani@hp.com>
	 <1352214130-12055-2-git-send-email-toshi.kani@hp.com>
	 <1353315374.3129.3.camel@joe-AO722>
	 <1353340280.10939.42.camel@misato.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from perches-mx.perches.com ([206.117.179.246]:40485 "EHLO
	labridge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752355Ab2KSQGc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 Nov 2012 11:06:32 -0500
In-Reply-To: <1353340280.10939.42.camel@misato.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: linux-acpi@vger.kernel.org, rjw@sisk.pl, lenb@kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, isimatu.yasuaki@jp.fujitsu.com, vijaymohan.pandarathil@hp.com, imammedo@redhat.com, prarit@redhat.com

On Mon, 2012-11-19 at 08:51 -0700, Toshi Kani wrote:
> On Mon, 2012-11-19 at 00:56 -0800, Joe Perches wrote:
> > is acpi_bus.h really the right file for these prototypes?
> This interface is limited for ACPI, so it should be declared in a header
> file under include/acpi.  Among the files in this directory, acpi_bus.h
> seems to be a good fit as it declares the interfaces provided by ACPI
> core.

I'd've put them in acpi.h or maybe created acpi_utils.h 

cheers, Joe

