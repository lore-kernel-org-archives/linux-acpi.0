From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [Xen-devel] [PATCH v2 1/3] x86/boot: add acpi rsdp address
 to setup_header
Date: Fri, 08 Dec 2017 01:28:44 -0700
Message-ID: <5A2A5B4C0200007800195CDC@prv-mh.provo.novell.com>
References: <20171207122821.30158-1-jgross@suse.com>
 <20171207122821.30158-2-jgross@suse.com>
 <20171208071653.mzyf3ct6n6h2x37r@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171208071653.mzyf3ct6n6h2x37r@gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: lenb@kernel.org, x86@kernel.org, tglx@linutronix.de, xen-devel@lists.xenproject.org, corbet@lwn.net, boris.ostrovsky@oracle.com, mingo@redhat.com, rjw@rjwysocki.net, Juergen Gross <jgross@suse.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com
List-Id: linux-acpi@vger.kernel.org

>>> On 08.12.17 at 08:16, <mingo@kernel.org> wrote:
> Also, a more fundamental question: why doesn't Xen use EFI to hand over 
> hardware configuration details?

Iirc the main purpose of the change here is to allow booting PVH
(guest or Dom0) with Grub2 in the middle. PVH, at least for the
time being, is something that gets away without any firmware
(and I'm pretty certain this is going to remain that way for Dom0).
ACPI tables are being built by the tool stack (guest) or hypervisor
(Dom0). Hence there simply isn't any EFI which could be used to
propagate such information.

Jan
