From: Vladimir Zajac <eightgraph@gmail.com>
Subject: Re: [PATCH 2.6.30-rc4] thermal: fix off-by-1 error in trip point trigger condition
Date: Tue, 9 Jun 2009 19:06:21 +0200
Message-ID: <200906091906.22162.eightgraph@gmail.com>
References: <200905061934.21821.eightgraph@gmail.com> <200906091510.11285.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:36911 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973AbZFIRG1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Jun 2009 13:06:27 -0400
In-Reply-To: <200906091510.11285.trenn@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: rui.zhang@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 09 June 2009 15:10:10 Thomas Renninger wrote:
> This one should have
> CC: stable@kernel.org
> added.
> Vladimir, do you mind submitting this one for stable inclusion
> if not done already.
> 
Inclusion into stable is not needed.
The bug was introduced in 2.6.30-rc1, stable release is not affected. 

Vladimir
