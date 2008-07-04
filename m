From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Panasonic Let's Note laptop extras driver v0.94
Date: Fri, 4 Jul 2008 10:10:31 +0100
Message-ID: <20080704091031.GA8905@srcf.ucam.org>
References: <20080702090044.GB12272@prithivi.gnumonks.org> <20080704034419.GG4381@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:45247 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755461AbYGDJKg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jul 2008 05:10:36 -0400
Content-Disposition: inline
In-Reply-To: <20080704034419.GG4381@prithivi.gnumonks.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Harald Welte <laforge@gnumonks.org>
Cc: linux-acpi@vger.kernel.org, Hiroshi Miura <miura@da-cha.org>

I'd still have a preference for not including the proc_generate_event 
stuff, but I'm not sure that there's any real consensus on that so I'm 
not going to block it.

Acked-by: mjg@redhat.com

-- 
Matthew Garrett | mjg59@srcf.ucam.org
