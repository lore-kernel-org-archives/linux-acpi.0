From: Andi Kleen <ak@suse.de>
Subject: Re: [ACPI] ACPI global lock macros
Date: Thu, 11 Dec 2003 09:07:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20031211090716.0c3662d3.ak@suse.de>
References: <3ACA40606221794F80A5670F0AF15F8401720C21@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720C21@PDSMSX403.ccr.corp.intel.com>
To: "Yu, Luming" <luming.yu@intel.com>
Cc: menage@google.com, agrover@groveronline.com, linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Thu, 11 Dec 2003 15:06:10 +0800
"Yu, Luming" <luming.yu@intel.com> wrote:

> 
> Above code have a bug! Considering below code:
> 
> u8	acquired = FALSE;
> 
> ACPI_ACQUIRE_GLOBAL_LOC(acpi_gbl_common_fACS.global_lock, acquired);
> if(acquired) {
> ....
> }
> 
> Gcc will complain " ERROR: '%cl' not allowed with sbbl ". And I think any other compiler will
> complain that  too !

It has even more bugs, e.g. it doesn't tell gcc that GLptr is modified (this hurts with
newer versions that optimize more aggressively) 

I tried to fix it on x86-64, but eventually gave up and adopted the IA64 C version.

-Andi
