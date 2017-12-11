From: Juergen Gross <jgross@suse.com>
Subject: Re: [Xen-devel] [PATCH v3 4/4] x86/xen: supply rsdp address in boot
 params for pvh guests
Date: Mon, 11 Dec 2017 11:51:44 +0100
Message-ID: <1a231a0d-b505-31c8-4723-52ef1dda634f@suse.com>
References: <20171208151139.30213-1-jgross@suse.com>
 <20171208151139.30213-5-jgross@suse.com> <5A2E674C0200007800196522@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41237 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751999AbdLKKvs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 Dec 2017 05:51:48 -0500
In-Reply-To: <5A2E674C0200007800196522@suse.com>
Content-Language: de-DE
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Beulich <JBeulich@suse.com>
Cc: lenb@kernel.org, x86@kernel.org, tglx@linutronix.de, xen-devel@lists.xenproject.org, corbet@lwn.net, boris.ostrovsky@oracle.com, mingo@redhat.com, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com

On 11/12/17 11:09, Jan Beulich wrote:
>>>> On 08.12.17 at 16:11, <jgross@suse.com> wrote:
>> Set the boot loader version to 2.14 (0x020e) replacing the wrong 0x0212
>> which should have been 0x020c.
> 
> This part of the description has become partly stale now with the
> new patch 3.

Indeed. I'll wait for other comments before sending out a new version.

Thanks,


Juergen
