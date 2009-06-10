From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Bad _BQC behaviour on Packard Bell Easynot BG-45
Date: Wed, 10 Jun 2009 10:24:42 +0800
Message-ID: <1244600682.9076.71.camel@rzhang-dt>
References: <d7ead6de0906090819h177b7495xaa98dd062abf1f62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:42509 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751013AbZFJCYA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Jun 2009 22:24:00 -0400
In-Reply-To: <d7ead6de0906090819h177b7495xaa98dd062abf1f62@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vladimir 'phcoder' Serbinenko <phcoder@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, 2009-06-09 at 23:19 +0800, Vladimir 'phcoder' Serbinenko wrote:
> Hello. On the following model
> 	Manufacturer: Packard Bell BV
> 	Product Name: EasyNote_BG45-U-001CH
> BQC returns a value between 0 and 15 but the brightness levels are
> between 0 and 8. I could make a table of correspondance however I find
> it too inflexible. So I propose the following patch which disables BQC
> if it behaves badly
> 
the patch seems good.
could you please send the acpidump of your laptop so that we can see if
there is any chance that we can enable the brightness control on this
laptop?

thanks,
rui

