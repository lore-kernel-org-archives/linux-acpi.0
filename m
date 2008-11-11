From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: ACPI crash on lid close - SMP race?
Date: Tue, 11 Nov 2008 02:05:39 +0000
Message-ID: <20081111020539.GA11616@srcf.ucam.org>
References: <20081110161105.GA2041@srcf.ucam.org> <1226366834.15014.60.camel@rzhang-dt> <20081111013359.GA11364@srcf.ucam.org> <1226368778.15014.73.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:47577 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446AbYKKCFl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Nov 2008 21:05:41 -0500
Content-Disposition: inline
In-Reply-To: <1226368778.15014.73.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Nov 11, 2008 at 09:59:38AM +0800, Zhang Rui wrote:

> oops. sorry, I mean system crashes on lid close if _DOS=0 on some UP
> platform.

Oh, ugh. I don't have any with that issue, but that ought to be 
"interesting" to fix.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
