From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH] Fujitsu-laptop update
Date: Wed, 28 May 2008 13:42:06 +0930 (CST)
Message-ID: <200805280412.m4S4C6Cr008232@turbo.physics.adelaide.edu.au>
References: <20080523161659.GB19674@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:58041 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751025AbYE1EMc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 May 2008 00:12:32 -0400
In-Reply-To: <20080523161659.GB19674@srcf.ucam.org> from "Matthew Garrett" at May 23, 2008 05:16:59 PM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, linux-acpi@vger.kernel.org, lenb@kernel.org, nokos@gmx.net

Matthew Garrett wrote:
> Can you also add a modalias for the PNP device? That would avoid the 
> need to add a large number of DMI entries.

At the risk of sounding uninformed (which is fine, because I am :-) ), how
does one go about finding the appropriate ID for the PNP device?  Are we
talking the FUJ02B1 and FUJ02E3 devices themselves (in which case we'll have
two such modaliases) or some other overarching device?

Regards
  jonathan


