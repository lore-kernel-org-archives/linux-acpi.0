From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [patch 09/11] bay: exit if notify handler cannot be installed
Date: Tue, 10 Jun 2008 00:28:17 +0100
Message-ID: <20080609232817.GA21101@srcf.ucam.org>
References: <200806092322.m59NMP01013979@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:52887 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775AbYFIX2Z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jun 2008 19:28:25 -0400
Content-Disposition: inline
In-Reply-To: <200806092322.m59NMP01013979@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, hmacht@suse.de, kristen.c.accardi@intel.com, rui.zhang@intel.com, trenn@suse.de

It looks like the plan is to subsume the bay driver into the dock 
driver. I'm not sure if this is needed in the short term until then?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
