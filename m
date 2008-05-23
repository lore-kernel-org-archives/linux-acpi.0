From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Fujitsu-laptop update
Date: Fri, 23 May 2008 17:16:59 +0100
Message-ID: <20080523161659.GB19674@srcf.ucam.org>
References: <200805230005.m4N05gEf004890@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:50680 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbYEWQRX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 23 May 2008 12:17:23 -0400
Content-Disposition: inline
In-Reply-To: <200805230005.m4N05gEf004890@turbo.physics.adelaide.edu.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, nokos@gmx.net

Can you also add a modalias for the PNP device? That would avoid the 
need to add a large number of DMI entries.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
