From: Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: [patch 1/2] acpi: add checking for NULL early param
Date: Thu, 21 Aug 2008 19:34:12 +0400
Message-ID: <20080821153412.GB7214@lenovo>
References: <200808202341.m7KNfkb8005410@imap1.linux-foundation.org> <8763pun9vv.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:64080 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760527AbYHUPds (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Aug 2008 11:33:48 -0400
Received: by fg-out-1718.google.com with SMTP id 19so26551fgg.17
        for <linux-acpi@vger.kernel.org>; Thu, 21 Aug 2008 08:33:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <8763pun9vv.fsf@basil.nowhere.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: akpm@linux-foundation.org, linux-acpi@vger.kernel.org

[Andi Kleen - Thu, Aug 21, 2008 at 08:46:12AM +0200]
| akpm@linux-foundation.org writes:
| 
| > From: Cyrill Gorcunov <gorcunov@gmail.com>
| >
| > The early_param handling function could recieve NULL pointer as argument
| > in case if user didn't enter parameter value.  So we have to be ready for
| > a such situation and do check for NULL pointer if needed.
| >
| > Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
| > Cc: Andi Kleen <andi@firstfloor.org>
| > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
| 
| Queued for 2.6.27. Thanks.
| 
| But I wonder if it wouldn't be generally safer for the caller to just pass
| an empty string instead of NULL in this case?
| 
| -Andi
| 

Actually this would require to patch kernel code not in
one place. There was some discusion about this	

	http://lkml.org/lkml/2008/8/12/229
	

- in short it could lead to hidden bug since not all
users of early_param are ready for this and they have
to be checked.

		- Cyrill -
