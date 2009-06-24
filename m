From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] for Bad _BQC behavior on HP laptops
Date: Wed, 24 Jun 2009 12:01:54 +0800
Message-ID: <1245816114.15520.109.camel@rzhang-dt>
References: <8555910906130530y7bb92108ia46c23ec476b6b04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:6803 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721AbZFXEBO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Jun 2009 00:01:14 -0400
In-Reply-To: <8555910906130530y7bb92108ia46c23ec476b6b04@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Scott Howard <showard314@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Acked-by: Zhang Rui <rui.zhang@intel.com>

thanks,
rui

On Sat, 2009-06-13 at 20:30 +0800, Scott Howard wrote:
> Hello, this is the patch [1] as discussed on kernel bugzilla bug
> #13511 [2]. I'm including the original comments from the patch
> creator.
> 
> [1] http://bugzilla.kernel.org/attachment.cgi?id=21889
> [2] http://bugzilla.kernel.org/show_bug.cgi?id=13511
> 
> 
> 
> Hello. On the following model
>     Manufacturer: Packard Bell BV
>     Product Name: EasyNote_BG45-U-001CH
> BQC returns a value between 0 and 15 but the brightness levels are
> between 0 and 8. I could make a table of correspondance however I find
> it too inflexible. So I propose the following patch which disables BQC
> if it behaves badly
> 

