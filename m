From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Clear abnormal poweroff flag on VIA southbridges, fix
 resume
Date: Tue, 20 Jun 2006 02:07:13 -0700
Message-ID: <20060620020713.84bddbb4.akpm@osdl.org>
References: <20060618191421.GA15358@srcf.ucam.org>
	<20060619230144.155bc938.akpm@osdl.org>
	<20060620085429.GB27362@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:49059 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030187AbWFTJHR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jun 2006 05:07:17 -0400
In-Reply-To: <20060620085429.GB27362@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tue, 20 Jun 2006 09:54:29 +0100
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> CONFIG_ACPI_SLEEP might be a better choice than CONFIG_ACPI, 
> yes.

OK, I diddled the diff to use CONFIG_ACPI_SLEEP, thanks.
