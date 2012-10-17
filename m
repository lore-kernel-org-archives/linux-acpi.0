From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] ACPI S3 and Xen (suprisingly small\!).
Date: Wed, 17 Oct 2012 09:03:12 -0700
Message-ID: <507ED6C0.4020503@zytor.com>
References: <1350481786-4969-1-git-send-email-konrad.wilk@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:60764 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751908Ab2JQQDW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Oct 2012 12:03:22 -0400
In-Reply-To: <1350481786-4969-1-git-send-email-konrad.wilk@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com, lenb@kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org

On 10/17/2012 06:49 AM, Konrad Rzeszutek Wilk wrote:
>
> Note: These are the other patches that went in 3.7-rc1:
> xen/bootup: allow {read|write}_cr8 pvops call [https://lkml.org/lkml/2012/10/10/339]
> xen/bootup: allow read_tscp call for Xen PV guests. [https://lkml.org/lkml/2012/10/10/340]
>

So WTF do we have a read_tscp PV call?  Again, if there isn't a user we 
should just axe it...

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.

