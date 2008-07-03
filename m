From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Panasonic Let's Note laptop extras driver
Date: Thu, 3 Jul 2008 18:08:57 +0100
Message-ID: <20080703170857.GA30135@srcf.ucam.org>
References: <20080702090044.GB12272@prithivi.gnumonks.org> <20080702101919.GB699@srcf.ucam.org> <20080703165219.GE4172@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:46184 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752608AbYGCRJB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Jul 2008 13:09:01 -0400
Content-Disposition: inline
In-Reply-To: <20080703165219.GE4172@prithivi.gnumonks.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Harald Welte <laforge@gnumonks.org>
Cc: linux-acpi@vger.kernel.org, Hiroshi Miura <miura@da-cha.org>, hadi@cyberus.ca

On Fri, Jul 04, 2008 at 12:52:19AM +0800, Harald Welte wrote:

> So I vote for keeping those events in the driver - just as long as there
> is no new standard mechanism for signalling brightness up/down button
> events to userspace.

There is - they should just be sent as KEY_BRIGHTNESSUP and 
KEY_BRIGHTNESSDOWN.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
