From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [Xen-devel] [PATCH v3 4/4] x86/xen: supply rsdp address in
 boot params for pvh guests
Date: Mon, 11 Dec 2017 03:09:00 -0700
Message-ID: <5A2E674C0200007800196522@prv-mh.provo.novell.com>
References: <20171208151139.30213-1-jgross@suse.com>
 <20171208151139.30213-5-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from prv-mh.provo.novell.com ([137.65.248.74]:49995 "EHLO
        prv-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752433AbdLKKJF (ORCPT
        <rfc822;groupwise-linux-acpi@vger.kernel.org:9:1>);
        Mon, 11 Dec 2017 05:09:05 -0500
In-Reply-To: <20171208151139.30213-5-jgross@suse.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Juergen Gross <jgross@suse.com>
Cc: lenb@kernel.org, x86@kernel.org, tglx@linutronix.de, xen-devel@lists.xenproject.org, corbet@lwn.net, boris.ostrovsky@oracle.com, mingo@redhat.com, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com

>>> On 08.12.17 at 16:11, <jgross@suse.com> wrote:
> Set the boot loader version to 2.14 (0x020e) replacing the wrong 0x0212
> which should have been 0x020c.

This part of the description has become partly stale now with the
new patch 3.

Jan

