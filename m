From: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: [PATCH 0/2] acpi: section annotation adjustments in
	 processor driver
Date: Thu, 03 Mar 2011 07:49:39 +0000
Message-ID: <4D6F56230200007800034A7A@vpn.id2.novell.com>
References: <4D5D5BBE02000078000327A5@vpn.id2.novell.com>
 <alpine.LFD.2.02.1103022058450.12344@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.02.1103022058450.12344@x980>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

>>> On 03.03.11 at 02:58, Len Brown <lenb@kernel.org> wrote:
> how much memory does this patch set save?
> 
> thanks,
> Len Brown, Intel Open Source Technology Center

On x86-64, patch 1 about 900 bytes, patch 2 about 400 bytes (plus
the ia64 specific savings which I don't have at hand right now).

Jan

