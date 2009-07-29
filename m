From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [Xen-devel] [PATCH][pvops_dom0][2/4] Introduce the external control
 operation interface for domain0 ACPI parser
Date: Wed, 29 Jul 2009 09:43:50 -0700
Message-ID: <4A707C46.2060405@goop.org>
References: <4D05DB80B95B23498C72C700BD6C2E0B315D64CC@pdsmsx502.ccr.corp.intel.com> <E87738D94A6AD54789B5B8D1BAEB06CC5C744C68C2@azsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from claw.goop.org ([74.207.240.146]:35585 "EHLO claw.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755663AbZG2Qnv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Jul 2009 12:43:51 -0400
In-Reply-To: <E87738D94A6AD54789B5B8D1BAEB06CC5C744C68C2@azsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: "Yu, Ke" <ke.yu@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Tian, Kevin" <kevin.tian@intel.com>

On 07/28/09 21:14, Brown, Len wrote:
> Does somebody expect all this dom0 stuff to really live
> in the upstream linux kernel source tree?
>   

The control domain (dom0) patches are held up by a very specific set of
concerns that I'm working on now.  I don't think there's any fundamental
reason it won't make it in at some point, and there's no reason not to
lay the groundwork in the meantime.

These acpi patches are very useful, but not essential functionality. 
I'd like to see them evolve along lines that are acceptable to everyone
before making a serious push upstream.

> s/extcntl/xen/ to make it clear why this code exists --
> or is there an expected "external control" other than Xen?
>   

I dislike making Xen-specific changes.  Ideally we can find a way to fit
these changes into some other abstraction which already exists, or if
added would be useful to more than one user.

    J
