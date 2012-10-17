From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Is: axe read_tscp pvops call. Was: Re: [RFC] ACPI S3 and Xen
 (suprisingly small\!).
Date: Wed, 17 Oct 2012 12:10:36 -0400
Message-ID: <20121017161036.GA10691@phenom.dumpdata.com>
References: <1350481786-4969-1-git-send-email-konrad.wilk@oracle.com>
 <507ED6C0.4020503@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:42857 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757386Ab2JQQWo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Oct 2012 12:22:44 -0400
Content-Disposition: inline
In-Reply-To: <507ED6C0.4020503@zytor.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com, lenb@kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org

On Wed, Oct 17, 2012 at 09:03:12AM -0700, H. Peter Anvin wrote:
> On 10/17/2012 06:49 AM, Konrad Rzeszutek Wilk wrote:
> >
> >Note: These are the other patches that went in 3.7-rc1:
> >xen/bootup: allow {read|write}_cr8 pvops call [https://lkml.org/lkml/2012/10/10/339]
> >xen/bootup: allow read_tscp call for Xen PV guests. [https://lkml.org/lkml/2012/10/10/340]
> >
> 
> So WTF do we have a read_tscp PV call?  Again, if there isn't a user
> we should just axe it...

Let me spin off a patch to see if that can be done.
