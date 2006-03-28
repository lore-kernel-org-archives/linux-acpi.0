From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Compaq V2000 Fan Control
Date: Tue, 28 Mar 2006 02:04:45 +0100
Message-ID: <20060328010445.GA25040@srcf.ucam.org>
References: <E124AAE027DA384D8B919F93E4D8C7080182A5C2@mssmsx402nb> <1143506477.6550.9.camel@ubuntu.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:13519 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1750710AbWC1BFF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Mar 2006 20:05:05 -0500
Content-Disposition: inline
In-Reply-To: <1143506477.6550.9.camel@ubuntu.americas.hpqcorp.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Bonilla, Alejandro" <abonilla@linuxwireless.org>
Cc: linux-acpi@vger.kernel.org

On Mon, Mar 27, 2006 at 06:41:17PM -0600, Bonilla, Alejandro wrote:

> I know I don't have it. Is there a way to debug this and see if it could
> occur or if it just could be that it needs a tweak? Or is definitely not
> going to work?

Your laptop doesn't expose the fan as an ACPI object. As a result, 
there's no way to control it through the standard ACPI interfaces.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
